import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/core/models/pb_repository.dart';
import 'package:mason_sampler/src/core/models/failure.dart';
import 'package:mason_sampler/src/core/packages/pocketbase.dart';
import 'package:mason_sampler/src/core/models/pocketbase_collections.dart';
import 'package:mason_sampler/src/core/models/page_results.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sales_transaction_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<SalesTransaction> salesTransactionRepository(Ref ref) {
  return SalesTransactionRepositoryImpl(pb: ref.watch(pocketbaseProvider));
}

class SalesTransactionRepositoryImpl extends PBCollectionRepository<SalesTransaction> {
  final PocketBase pb;

  SalesTransactionRepositoryImpl({required this.pb});
  
  String get _collectionName => PocketBaseCollections.salesTransactions;

  RecordService get collection => pb.collection(_collectionName);

  SalesTransaction mapToData(Map<String, dynamic> map) {
    return SalesTransaction.fromMap(map);
  }

  final expand = '';

  @override
  TaskResult<SalesTransaction> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<SalesTransaction> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload, files: files, expand: expand);
      return mapToData(response.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> delete(String id) {
    return TaskResult.tryCatch(() async {
      await collection.delete(id);
    }, Failure.handle);
  }

  @override
  TaskResult<PageResults<SalesTransaction>> list({
    String? filter,
    required int pageNo,
    required int pageSize,
    String? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getList(
        filter: filter,
        page: pageNo,
        perPage: pageSize,
        sort: sort,
        expand: expand,
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<SalesTransaction>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<SalesTransaction> update(
    SalesTransaction history,
    Map<String, dynamic> update, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final historyMap = history.toMap();
      final combinedMap = {...historyMap, ...update};
      final result = await collection.update(
        history.id,
        body: combinedMap,
        files: files,
        expand: expand,
      );
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<void> softDeleteMulti(List<String> ids) {
    return TaskResult.tryCatch(() async {
      final batch = pb.createBatch();
      final batchCollection = batch.collection(_collectionName);
      for (final id in ids) {
        batchCollection.update(id, body: {PbField.isDeleted: true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<SalesTransaction>> listAll({
    int batch = 500,
    String? filter,
    String? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getFullList(filter: filter, sort: sort, expand: expand);
      return result.map<SalesTransaction>((e) => mapToData(e.toJson())).toList();
    }, Failure.handle);
  }
}
