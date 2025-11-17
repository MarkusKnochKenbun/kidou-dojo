import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_data.freezed.dart';

enum ServiceState {
  idle,
  running;

  bool isRunning() => this == running;
  bool isIdle() => this == idle;
}

@freezed
abstract class HomeData with _$HomeData {
  const factory HomeData({required String message, required String endpoint, required ServiceState serviceState}) =
      _HomeData;
}
