import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_notifier.g.dart';

@riverpod
class AppThemeNotifier extends _$AppThemeNotifier {
  @override
  bool build() {
    return false;
  }

  void setLightTheme() {
    state = false;
  }

  void setDarkTheme() {
    state = true;
  }
}