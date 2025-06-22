// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_transaction_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salesTransactionControllerHash() =>
    r'f895c641bf69633bc8cc77d76976d9e2919bc22a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SalesTransactionController
    extends BuildlessAutoDisposeAsyncNotifier<SalesTransaction> {
  late final String id;

  FutureOr<SalesTransaction> build(String id);
}

/// See also [SalesTransactionController].
@ProviderFor(SalesTransactionController)
const salesTransactionControllerProvider = SalesTransactionControllerFamily();

/// See also [SalesTransactionController].
class SalesTransactionControllerFamily
    extends Family<AsyncValue<SalesTransaction>> {
  /// See also [SalesTransactionController].
  const SalesTransactionControllerFamily();

  /// See also [SalesTransactionController].
  SalesTransactionControllerProvider call(String id) {
    return SalesTransactionControllerProvider(id);
  }

  @override
  SalesTransactionControllerProvider getProviderOverride(
    covariant SalesTransactionControllerProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'salesTransactionControllerProvider';
}

/// See also [SalesTransactionController].
class SalesTransactionControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          SalesTransactionController,
          SalesTransaction
        > {
  /// See also [SalesTransactionController].
  SalesTransactionControllerProvider(String id)
    : this._internal(
        () => SalesTransactionController()..id = id,
        from: salesTransactionControllerProvider,
        name: r'salesTransactionControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$salesTransactionControllerHash,
        dependencies: SalesTransactionControllerFamily._dependencies,
        allTransitiveDependencies:
            SalesTransactionControllerFamily._allTransitiveDependencies,
        id: id,
      );

  SalesTransactionControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<SalesTransaction> runNotifierBuild(
    covariant SalesTransactionController notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(SalesTransactionController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SalesTransactionControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    SalesTransactionController,
    SalesTransaction
  >
  createElement() {
    return _SalesTransactionControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SalesTransactionControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SalesTransactionControllerRef
    on AutoDisposeAsyncNotifierProviderRef<SalesTransaction> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SalesTransactionControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          SalesTransactionController,
          SalesTransaction
        >
    with SalesTransactionControllerRef {
  _SalesTransactionControllerProviderElement(super.provider);

  @override
  String get id => (origin as SalesTransactionControllerProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
