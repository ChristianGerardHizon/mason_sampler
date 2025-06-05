// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerFormControllerHash() =>
    r'24b826ccc1a77b8752102c1501869cc52e6dc5f4';

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

abstract class _$CustomerFormController
    extends BuildlessAutoDisposeAsyncNotifier<CustomerFormState> {
  late final String? id;

  FutureOr<CustomerFormState> build(String? id);
}

/// See also [CustomerFormController].
@ProviderFor(CustomerFormController)
const customerFormControllerProvider = CustomerFormControllerFamily();

/// See also [CustomerFormController].
class CustomerFormControllerFamily
    extends Family<AsyncValue<CustomerFormState>> {
  /// See also [CustomerFormController].
  const CustomerFormControllerFamily();

  /// See also [CustomerFormController].
  CustomerFormControllerProvider call(String? id) {
    return CustomerFormControllerProvider(id);
  }

  @override
  CustomerFormControllerProvider getProviderOverride(
    covariant CustomerFormControllerProvider provider,
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
  String? get name => r'customerFormControllerProvider';
}

/// See also [CustomerFormController].
class CustomerFormControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CustomerFormController,
          CustomerFormState
        > {
  /// See also [CustomerFormController].
  CustomerFormControllerProvider(String? id)
    : this._internal(
        () => CustomerFormController()..id = id,
        from: customerFormControllerProvider,
        name: r'customerFormControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$customerFormControllerHash,
        dependencies: CustomerFormControllerFamily._dependencies,
        allTransitiveDependencies:
            CustomerFormControllerFamily._allTransitiveDependencies,
        id: id,
      );

  CustomerFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  FutureOr<CustomerFormState> runNotifierBuild(
    covariant CustomerFormController notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(CustomerFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CustomerFormControllerProvider._internal(
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
    CustomerFormController,
    CustomerFormState
  >
  createElement() {
    return _CustomerFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CustomerFormControllerProvider && other.id == id;
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
mixin CustomerFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<CustomerFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _CustomerFormControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CustomerFormController,
          CustomerFormState
        >
    with CustomerFormControllerRef {
  _CustomerFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as CustomerFormControllerProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
