// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_transaction_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salesTransactionTableControllerHash() =>
    r'673f35107808d66df1f60f543787944ce98182fd';

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

abstract class _$SalesTransactionTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<SalesTransaction>> {
  late final String tableKey;

  FutureOr<List<SalesTransaction>> build(String tableKey);
}

/// See also [SalesTransactionTableController].
@ProviderFor(SalesTransactionTableController)
const salesTransactionTableControllerProvider =
    SalesTransactionTableControllerFamily();

/// See also [SalesTransactionTableController].
class SalesTransactionTableControllerFamily
    extends Family<AsyncValue<List<SalesTransaction>>> {
  /// See also [SalesTransactionTableController].
  const SalesTransactionTableControllerFamily();

  /// See also [SalesTransactionTableController].
  SalesTransactionTableControllerProvider call(String tableKey) {
    return SalesTransactionTableControllerProvider(tableKey);
  }

  @override
  SalesTransactionTableControllerProvider getProviderOverride(
    covariant SalesTransactionTableControllerProvider provider,
  ) {
    return call(provider.tableKey);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'salesTransactionTableControllerProvider';
}

/// See also [SalesTransactionTableController].
class SalesTransactionTableControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          SalesTransactionTableController,
          List<SalesTransaction>
        > {
  /// See also [SalesTransactionTableController].
  SalesTransactionTableControllerProvider(String tableKey)
    : this._internal(
        () => SalesTransactionTableController()..tableKey = tableKey,
        from: salesTransactionTableControllerProvider,
        name: r'salesTransactionTableControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$salesTransactionTableControllerHash,
        dependencies: SalesTransactionTableControllerFamily._dependencies,
        allTransitiveDependencies:
            SalesTransactionTableControllerFamily._allTransitiveDependencies,
        tableKey: tableKey,
      );

  SalesTransactionTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
  }) : super.internal();

  final String tableKey;

  @override
  FutureOr<List<SalesTransaction>> runNotifierBuild(
    covariant SalesTransactionTableController notifier,
  ) {
    return notifier.build(tableKey);
  }

  @override
  Override overrideWith(SalesTransactionTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SalesTransactionTableControllerProvider._internal(
        () => create()..tableKey = tableKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    SalesTransactionTableController,
    List<SalesTransaction>
  >
  createElement() {
    return _SalesTransactionTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SalesTransactionTableControllerProvider &&
        other.tableKey == tableKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SalesTransactionTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<SalesTransaction>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _SalesTransactionTableControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          SalesTransactionTableController,
          List<SalesTransaction>
        >
    with SalesTransactionTableControllerRef {
  _SalesTransactionTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as SalesTransactionTableControllerProvider).tableKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
