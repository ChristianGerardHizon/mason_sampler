import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/features/sales_transactions/data/sales_transaction_repository.dart';
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction.dart';
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction_form_state.dart';
part 'sales_transaction_form_controller.g.dart';


@riverpod
class SalesTransactionFormController extends _$SalesTransactionFormController {
  @override
  Future<SalesTransactionFormState> build(String? id) async {
    final salesTransactionRepo = ref.read(salesTransactionRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return SalesTransactionFormState(salesTransaction: null);
      }
      final salesTransaction = await $(salesTransactionRepo.get(id));
      return SalesTransactionFormState(salesTransaction: salesTransaction);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
