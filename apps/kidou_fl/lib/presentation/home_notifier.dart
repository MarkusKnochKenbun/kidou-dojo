import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kidou_fl/constants.dart';
import 'package:kidou_fl/main.dart';
import 'package:kidou_fl/presentation/home_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:toastification/toastification.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  AudioRecorder? record;

  @override
  Future<HomeData> build() async {
    talker.info("HomeNotifier build");

    final endpointJsonString = await rootBundle.loadString(defaultEndpointFilePath);
    final endpointJson = json.decode(endpointJsonString);

    genericMatcherEndpoint = endpointJson["endpoint"];

    ref.onDispose(() {
      talker.info("HomeNotifier triggered onDispose");
    });

    return HomeData(message: "", serviceState: ServiceState.idle, endpoint: genericMatcherEndpoint);
  }

  void onEndpointValueChange(String value) {
    update((data) => data.copyWith(endpoint: value));
  }

  Future<String> selectMatcherConfig() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );

    if (result != null) {
      // Read the file bytes
      final fileBytes = result.files.first.bytes;

      if (fileBytes != null) {
        // Convert bytes to string
        final fileContent = utf8.decode(fileBytes);

        // Decode the JSON string
        final matcherConfig = json.decode(fileContent) as Map<String, dynamic>;

        talker.info("matcherConfig: $matcherConfig");

        // Update state with the parsed JSON
        update((data) => data.copyWith(matcherConfig: matcherConfig));

        return result.files.first.name;
      } else {
        toastification.show(
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          title: Text("Error"),
          description: Text("Non valid matcher config!"),
          autoCloseDuration: const Duration(seconds: 5),
        );

        talker.warning("File bytes are null");
      }
    }

    return "";
  }

  void start(HomeData widgetState) async {
    if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS || kIsWeb) {
      final status = await Permission.microphone.request();

      if (status.isGranted) {
        _start(widgetState);
      }
    } else {
      _start(widgetState);
    }
  }

  void _start(HomeData widgetState) async {
    await update((data) => data.copyWith(serviceState: ServiceState.running));

    // record
    record = AudioRecorder();

    // websocket
    final initialMessageJsonString = await rootBundle.loadString(initialMessageFilePath);
    final initialMessage = json.decode(initialMessageJsonString) as Map<String, dynamic>;

    // Use the matcher config from state if available, otherwise load from assets
    final matcherConfig = widgetState.matcherConfig;

    if (matcherConfig == null) {
      await update((data) => data.copyWith(serviceState: ServiceState.idle));

      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        title: Text("Error"),
        description: Text("Non valid matcher config!"),
        autoCloseDuration: const Duration(seconds: 5),
      );
      return;
    }

    // Set initial_commands inside the "value" object
    if (initialMessage["value"] is Map<String, dynamic>) {
      (initialMessage["value"] as Map<String, dynamic>)["initial_commands"] = [
        {"matcher_config": matcherConfig},
      ];
    }

    talker.info("$initialMessage");

    final initialMessages = [json.encode(initialMessage)];

    final channel = WebSocketChannel.connect(Uri.parse(widgetState.endpoint));
    await channel.ready;

    channel.stream.listen(
      (message) async {
        if (message is String) {
          await update((data) => data.copyWith(message: message));
          talker.info("WebSocketChannel - message: $message");
        }
      },
      onError: (e) {
        talker.info("WebSocketChannel - onError: $e");
      },
      onDone: () async {
        talker.info("WebSocketChannel - onDone");
        record?.cancel();
        await update((data) => data.copyWith(serviceState: ServiceState.idle));
      },
    );

    for (var message in initialMessages) {
      talker.info("WebSocketChannel message: $message");
      channel.sink.add(message);
    }

    final defaultSamplerate = 16_000;
    final streamBufferSize = 1600;

    final recordConfig = RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: defaultSamplerate,
      numChannels: 1,
      device: null,
      autoGain: false,
      echoCancel: false,
      noiseSuppress: false,
      androidConfig: const AndroidRecordConfig(audioSource: AndroidAudioSource.voiceRecognition),
      iosConfig: const IosRecordConfig(),
      streamBufferSize: streamBufferSize,
    );

    final stream = await record?.startStream(recordConfig);

    stream?.listen(
      (audio) {
        channel.sink.add(audio);
        // print("audio: ${audio.length}");
      },
      onError: (error) async {
        talker.info("AudioRecorder, onError: $error");
      },
      onDone: () async {
        talker.info("AudioRecorder, onDone");
        await record?.stop();
        try {
          await channel.sink.close(1000, 'Client disconnecting gracefully');
        } catch (e) {
          talker.info("Error. $e");
        }
      },
    );
  }

  void stop() async {
    record?.stop();
  }
}
