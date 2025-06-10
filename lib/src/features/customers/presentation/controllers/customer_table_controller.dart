import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/controllers/table_controller.dart';
import 'package:mason_sampler/src/core/models/page_results.dart';
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/core/models/pb_filter.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/features/customers/data/customer_repository.dart';
import 'package:mason_sampler/src/features/customers/domain/customer.dart';

part 'customer_table_controller.g.dart';

@riverpod
class CustomerTableController extends _$CustomerTableController {
  @override
  Future<List<Customer>> build(String tableKey) async {
    final repo = ref.read(customerRepositoryProvider);

    final page = ref.watch(
      tableControllerProvider(tableKey).select((state) => state.page),
    );
    final pageSize = ref.watch(
      tableControllerProvider(tableKey).select((state) => state.pageSize),
    );
    final tableFilter = ref.watch(
      tableControllerProvider(tableKey).select((state) => state.filter),
    );

    final notifier = ref.read(tableControllerProvider(tableKey).notifier);
    final baseFilter = '${PbField.isDeleted} = false';
    final filterFunc = PocketbaseFilter(baseFilter: baseFilter);

    final result = await repo
        // 1. Fetch data
        .list(
          filter: filterFunc.searchName(tableFilter).build(),
          pageNo: page,
          pageSize: pageSize,
          sort: '-updated',
        )
        // 2. success sideffect
        .flatMap((result) => _handleSuccess(result, notifier))
        // 3. run
        .run();

    return result.fold(Future.error, (x) => Future.value(x.items));
  }
}

TaskResult _handleSuccess(
  PageResults<Customer> result,
  TableController notifier,
) {
  notifier.fetchSuccess(
    hasNext: result.hasNext,
    page: result.page,
    totalItems: result.totalItems,
    totalPages: result.totalPages,
  );
  return TaskResult.right(result);
}
