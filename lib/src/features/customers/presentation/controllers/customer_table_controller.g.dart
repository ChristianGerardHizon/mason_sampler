// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerTableControllerHash() =>
    r'bd50a60367131bbfd2e2abdc28cce460ebc08ef7';

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

abstract class _$CustomerTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<Customer>> {
  late final String tableKey;

  FutureOr<List<Customer>> build(String tableKey);
}

/// See also [CustomerTableController].
@ProviderFor(CustomerTableController)
const customerTableControllerProvider = CustomerTableControllerFamily();

/// See also [CustomerTableController].
class CustomerTableControllerFamily extends Family<AsyncValue<List<Customer>>> {
  /// See also [CustomerTableController].
  const CustomerTableControllerFamily();

  /// See also [CustomerTableController].
  CustomerTableControllerProvider call(String tableKey) {
    return CustomerTableControllerProvider(tableKey);
  }

  @override
  CustomerTableControllerProvider getProviderOverride(
    covariant CustomerTableControllerProvider provider,
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
  String? get name => r'customerTableControllerProvider';
}

/// See also [CustomerTableController].
class CustomerTableControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CustomerTableController,
          List<Customer>
        > {
  /// See also [CustomerTableController].
  CustomerTableControllerProvider(String tableKey)
    : this._internal(
        () => CustomerTableController()..tableKey = tableKey,
        from: customerTableControllerProvider,
        name: r'customerTableControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$customerTableControllerHash,
        dependencies: CustomerTableControllerFamily._dependencies,
        allTransitiveDependencies:
            CustomerTableControllerFamily._allTransitiveDependencies,
        tableKey: tableKey,
      );

  CustomerTableControllerProvider._internal(
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
  FutureOr<List<Customer>> runNotifierBuild(
    covariant CustomerTableController notifier,
  ) {
    return notifier.build(tableKey);
  }

  @override
  Override overrideWith(CustomerTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomerTableControllerProvider._internal(
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
    CustomerTableController,
    List<Customer>
  >
  createElement() {
    return _CustomerTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerTableControllerProvider &&
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
mixin CustomerTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Customer>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _CustomerTableControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CustomerTableController,
          List<Customer>
        >
    with CustomerTableControllerRef {
  _CustomerTableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as CustomerTableControllerProvider).tableKey;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
