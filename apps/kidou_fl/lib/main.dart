import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kidou_fl/constants.dart';
import 'package:kidou_fl/di/app_theme_notifier.dart';
import 'package:kidou_fl/presentation/home_screen.dart';
import 'package:kidou_fl/theme.dart';
import 'package:talker/talker.dart';
import 'package:toastification/toastification.dart';

final talker = Talker();
late String genericMatcherEndpoint;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: KidouFl()));
}

final _goRouter = GoRouter(
  initialLocation: initialRoute,
  routes: [
    GoRoute(
      path: initialRoute,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
        );
      },
    ),
  ],
);

class KidouFl extends ConsumerWidget {
  const KidouFl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeProvider);
    return ToastificationWrapper(
      child: MaterialApp.router(
        routerConfig: _goRouter,
        title: 'KENBUN',
        theme: MaterialTheme(TextTheme()).light(),
        darkTheme: MaterialTheme(TextTheme()).dark(),
        themeMode: appThemeState ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
