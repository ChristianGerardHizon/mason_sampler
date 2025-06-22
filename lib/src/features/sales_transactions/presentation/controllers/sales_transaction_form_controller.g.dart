// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_transaction_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salesTransactionFormControllerHash() =>
    r'23e58fe76c84a28fb7db1e980b20e8a5e77336b1';

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

abstract class _$SalesTransactionFormController
    extends BuildlessAutoDisposeAsyncNotifier<SalesTransactionFormState> {
  late final String? id;

  FutureOr<SalesTransactionFormState> build(String? id);
}

/// See also [SalesTransactionFormController].
@ProviderFor(SalesTransactionFormController)
const salesTransactionFormControllerProvider =
    SalesTransactionFormControllerFamily();

/// See also [SalesTransactionFormController].
class SalesTransactionFormControllerFamily
    extends Family<AsyncValue<SalesTransactionFormState>> {
  /// See also [SalesTransactionFormController].
  const SalesTransactionFormControllerFamily();

  /// See also [SalesTransactionFormController].
  SalesTransactionFormControllerProvider call(String? id) {
    return SalesTransactionFormControllerProvider(id);
  }

  @override
  SalesTransactionFormControllerProvider getProviderOverride(
    covariant SalesTransactionFormControllerProvider provider,
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
  String? get name => r'salesTransactionFormControllerProvider';
}

/// See also [SalesTransactionFormController].
class SalesTransactionFormControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          SalesTransactionFormController,
          SalesTransactionFormState
        > {
  /// See also [SalesTransactionFormController].
  SalesTransactionFormControllerProvider(String? id)
    : this._internal(
        () => SalesTransactionFormController()..id = id,
        from: salesTransactionFormControllerProvider,
        name: r'salesTransactionFormControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$salesTransactionFormControllerHash,
        dependencies: SalesTransactionFormControllerFamily._dependencies,
        allTransitiveDependencies:
            SalesTransactionFormControllerFamily._allTransitiveDependencies,
        id: id,
      );

  SalesTransactionFormControllerProvider._internal(
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
  FutureOr<SalesTransactionFormState> runNotifierBuild(
    covariant SalesTransactionFormController notifier,
  ) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(SalesTransactionFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: SalesTransactionFormControllerProvider._internal(
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
    SalesTransactionFormController,
    SalesTransactionFormState
  >
  createElement() {
    return _SalesTransactionFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SalesTransactionFormControllerProvider && other.id == id;
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
mixin SalesTransactionFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<SalesTransactionFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _SalesTransactionFormControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          SalesTransactionFormController,
          SalesTransactionFormState
        >
    with SalesTransactionFormControllerRef {
  _SalesTransactionFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as SalesTransactionFormControllerProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
