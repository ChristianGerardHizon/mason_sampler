import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/features/admins/data/admin_repository.dart';
import 'package:mason_sampler/src/features/admins/domain/admin.dart';

part 'admins_controller.g.dart';

@riverpod
class AdminsController extends _$AdminsController {
  @override
  Future<List<Admin>> build() async {
    final repo = ref.read(adminRepositoryProvider);
    final result = await repo
        .listAll(filter: "${PbField.isDeleted} = false")
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
