import 'package:flutter/material.dart';

class KenbunErrorScreen extends StatelessWidget {
  final String errorMessage;
  const KenbunErrorScreen({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const .all(8.0),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Row(
              mainAxisAlignment: .center,
              children: [
                Flexible(
                  child: Text(
                    errorMessage,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
