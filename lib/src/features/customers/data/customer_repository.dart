import 'package:mason_sampler/src/core/models/pb_repository.dart';
import 'package:mason_sampler/src/core/models/failure.dart';
import 'package:mason_sampler/src/core/packages/pocketbase.dart';
import 'package:mason_sampler/src/core/packages/pocketbase_collections.dart';
import 'package:mason_sampler/src/core/models/page_results.dart';
import 'package:mason_sampler/src/core/strings/fields.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/features/customers/domain/customer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'customer_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<Customer> customerRepository(Ref ref) {
  return CustomerRepositoryImpl(pb: ref.watch(pocketbaseProvider));
}

class CustomerRepositoryImpl extends PBCollectionRepository<Customer> {
  final PocketBase pb;

  CustomerRepositoryImpl({required this.pb});
  
  String get _collectionName => PocketBaseCollections.customers;

  RecordService get collection => pb.collection(_collectionName);

  Customer mapToData(Map<String, dynamic> map) {
    return Customer.fromMap(map);
  }

  @override
  TaskResult<Customer> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<Customer> create(
    Map<String, dynamic> payload, {
    List<MultipartFile> files = const [],
  }) {
    return TaskResult.tryCatch(() async {
      final response = await collection.create(body: payload, files: files);
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
  TaskResult<PageResults<Customer>> list({
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
      );
      return PageResults(
        page: result.page,
        perPage: result.perPage,
        totalItems: result.totalItems,
        totalPages: result.totalPages,
        items: result.items.map<Customer>((e) {
          return mapToData(e.toJson());
        }).toList(),
      );
    }, Failure.handle);
  }

  @override
  TaskResult<Customer> update(
    Customer history,
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
        batchCollection.update(id, body: {PBField.isDeleted: true});
      }

      await batch.send();
    }, Failure.handle);
  }

  @override
  TaskResult<List<Customer>> listAll({
    int batch = 500,
    String? filter,
    String? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getFullList(filter: filter, sort: sort);
      return result.map<Customer>((e) => mapToData(e.toJson())).toList();
    }, Failure.handle);
  }
}
