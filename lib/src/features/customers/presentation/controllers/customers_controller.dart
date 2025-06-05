import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/features/customers/data/customer_repository.dart';
import 'package:mason_sampler/src/features/customers/domain/customer.dart';

part 'customers_controller.g.dart';

@riverpod
class CustomersController extends _$CustomersController {
  @override
  Future<List<Customer>> build() async {
    final repo = ref.read(customerRepositoryProvider);
    final result = await repo
        .listAll(filter: "${PbField.isDeleted} = false")
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
