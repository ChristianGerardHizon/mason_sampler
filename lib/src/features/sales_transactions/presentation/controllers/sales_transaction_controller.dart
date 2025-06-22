import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/features/sales_transactions/data/sales_transaction_repository.dart';
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction.dart';

part 'sales_transaction_controller.g.dart';

@riverpod
class SalesTransactionController extends _$SalesTransactionController {
  @override
  Future<SalesTransaction> build(String id) async {
    final repo = ref.read(salesTransactionRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
