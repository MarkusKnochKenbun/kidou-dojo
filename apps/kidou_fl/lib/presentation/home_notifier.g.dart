// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeNotifier)
const homeProvider = HomeNotifierProvider._();

final class HomeNotifierProvider
    extends $AsyncNotifierProvider<HomeNotifier, HomeData> {
  const HomeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeNotifierHash();

  @$internal
  @override
  HomeNotifier create() => HomeNotifier();
}

String _$homeNotifierHash() => r'a2077e98803a46384da5a161289865ebee2208ab';

abstract class _$HomeNotifier extends $AsyncNotifier<HomeData> {
  FutureOr<HomeData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<HomeData>, HomeData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeData>, HomeData>,
              AsyncValue<HomeData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
