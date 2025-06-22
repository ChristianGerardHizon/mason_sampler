import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/features/sales_transactions/data/sales_transaction_repository.dart';
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction.dart';

part 'sales_transactions_controller.g.dart';

@riverpod
class SalesTransactionsController extends _$SalesTransactionsController {
  @override
  Future<List<SalesTransaction>> build() async {
    final repo = ref.read(salesTransactionRepositoryProvider);
    final result = await repo
        .listAll(filter: "${PbField.isDeleted} = false")
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
