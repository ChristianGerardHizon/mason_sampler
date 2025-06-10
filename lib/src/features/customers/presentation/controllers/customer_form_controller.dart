import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/features/customers/data/customer_repository.dart';
import 'package:mason_sampler/src/features/customers/domain/customer.dart';

part 'customer_form_controller.g.dart';

class CustomerFormState {
  final Customer? customer;

  CustomerFormState({required this.customer});
}

@riverpod
class CustomerFormController extends _$CustomerFormController {
  @override
  Future<CustomerFormState> build(String? id) async {
    final customerRepo = ref.read(customerRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return CustomerFormState(customer: null);
      }
      final customer = await $(customerRepo.get(id));
      return CustomerFormState(customer: customer);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
