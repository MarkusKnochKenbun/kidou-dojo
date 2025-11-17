import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kidou_fl/additional_widgets/file_select_widget.dart';
import 'package:kidou_fl/additional_widgets/text_input_widget.dart';
import 'package:kidou_fl/main.dart';
import 'package:kidou_fl/presentation/home_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncWidgetState = ref.watch(homeProvider);

    return asyncWidgetState.when(
      loading: () => const SizedBox(child: Text("Loading")),
      error: (error, stack) => SizedBox(child: Text("Test")),
      data: (widgetState) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'KIDOU',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Theme.of(context).colorScheme.outline),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(child: _buildFormattedMessage(widgetState.message)),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextInputWidget(
                        onValidChanged: (value) {
                          ref.read(homeProvider.notifier).onEndpointValueChange(value);
                        },
                        initialValue: genericMatcherEndpoint,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: FileSelectWidget(
                        selectFile: () => ref.read(homeProvider.notifier).selectMatcherConfig(),
                        selectText: "matcher config",
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        if (widgetState.serviceState.isRunning()) {
                          ref.read(homeProvider.notifier).stop();
                        } else {
                          ref.read(homeProvider.notifier).start(widgetState);
                        }
                      },
                      child: widgetState.serviceState.isRunning() ? const Text("Stop") : const Text("Start"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormattedMessage(String message) {
    if (message.isEmpty) {
      return const Text('No message yet...');
    }

    try {
      // Try to parse as JSON
      final jsonObject = json.decode(message);
      // Pretty print with 2-space indentation
      final prettyJson = const JsonEncoder.withIndent('  ').convert(jsonObject);

      return SelectableText(prettyJson, style: const TextStyle(fontFamily: 'monospace', fontSize: 14));
    } catch (e) {
      // If not valid JSON, display as plain text
      return SelectableText(message, style: const TextStyle(fontSize: 14));
    }
  }
}
