import 'package:{{packageName.snakeCase()}}/src/core/models/fields/pb_field.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/pb_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/packages/pocketbase.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/pocketbase_collections.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/page_results.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{singular.snakeCase()}}_repository.g.dart';

@Riverpod(keepAlive: true)
PBCollectionRepository<{{singular.pascalCase()}}> {{singular.camelCase()}}Repository(Ref ref) {
  return {{singular.pascalCase()}}RepositoryImpl(pb: ref.watch(pocketbaseProvider));
}

class {{singular.pascalCase()}}RepositoryImpl extends PBCollectionRepository<{{singular.pascalCase()}}> {
  final PocketBase pb;

  {{singular.pascalCase()}}RepositoryImpl({required this.pb});
  
  String get _collectionName => PocketBaseCollections.{{plural.camelCase()}};

  RecordService get collection => pb.collection(_collectionName);

  {{singular.pascalCase()}} mapToData(Map<String, dynamic> map) {
    return {{singular.pascalCase()}}.fromMap(map);
  }

  final expand = '';

  @override
  TaskResult<{{singular.pascalCase()}}> get(String id) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getOne(id, expand: expand);
      return mapToData(result.toJson());
    }, Failure.handle);
  }

  @override
  TaskResult<{{singular.pascalCase()}}> create(
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
  TaskResult<PageResults<{{singular.pascalCase()}}>> list({
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
        items: result.items.map<{{singular.pascalCase()}}>((e) {
          return mapToData(e.toJson());
        }).toList(),
        expand: expand,
      );
    }, Failure.handle);
  }

  @override
  TaskResult<{{singular.pascalCase()}}> update(
    {{singular.pascalCase()}} history,
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
  TaskResult<List<{{singular.pascalCase()}}>> listAll({
    int batch = 500,
    String? filter,
    String? sort,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await collection.getFullList(filter: filter, sort: sort, expand: expand);
      return result.map<{{singular.pascalCase()}}>((e) => mapToData(e.toJson())).toList();
    }, Failure.handle);
  }
}
