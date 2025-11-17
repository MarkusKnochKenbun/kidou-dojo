import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kidou_fl/constants.dart';
import 'package:kidou_fl/main.dart';
import 'package:kidou_fl/presentation/home_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
    final jsonData = json.decode(initialMessageJsonString);

    final matcherConfigJsonString = await rootBundle.loadString(matcherConfigFilePath);
    final matcherConfig = json.decode(matcherConfigJsonString);

    jsonData["initial_commands"] = [matcherConfig];

    talker.info("$jsonData");

    final initialMessages = [json.encode(jsonData)];

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
