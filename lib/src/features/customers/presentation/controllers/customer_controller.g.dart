// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerControllerHash() =>
    r'a0d08f7e3b1356e125cfeaf3a73990561ff51981';

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

abstract class _$CustomerController
    extends BuildlessAutoDisposeAsyncNotifier<Customer> {
  late final String id;

  FutureOr<Customer> build(String id);
}

/// See also [CustomerController].
@ProviderFor(CustomerController)
const customerControllerProvider = CustomerControllerFamily();

/// See also [CustomerController].
class CustomerControllerFamily extends Family<AsyncValue<Customer>> {
  /// See also [CustomerController].
  const CustomerControllerFamily();

  /// See also [CustomerController].
  CustomerControllerProvider call(String id) {
    return CustomerControllerProvider(id);
  }

  @override
  CustomerControllerProvider getProviderOverride(
    covariant CustomerControllerProvider provider,
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
  String? get name => r'customerControllerProvider';
}

/// See also [CustomerController].
class CustomerControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CustomerController, Customer> {
  /// See also [CustomerController].
  CustomerControllerProvider(String id)
    : this._internal(
        () => CustomerController()..id = id,
        from: customerControllerProvider,
        name: r'customerControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$customerControllerHash,
        dependencies: CustomerControllerFamily._dependencies,
        allTransitiveDependencies:
            CustomerControllerFamily._allTransitiveDependencies,
        id: id,
      );

  CustomerControllerProvider._internal(
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
  FutureOr<Customer> runNotifierBuild(covariant CustomerController notifier) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(CustomerController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomerControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CustomerController, Customer>
  createElement() {
    return _CustomerControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerControllerProvider && other.id == id;
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
mixin CustomerControllerRef on AutoDisposeAsyncNotifierProviderRef<Customer> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CustomerControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<CustomerController, Customer>
    with CustomerControllerRef {
  _CustomerControllerProviderElement(super.provider);

  @override
  String get id => (origin as CustomerControllerProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
