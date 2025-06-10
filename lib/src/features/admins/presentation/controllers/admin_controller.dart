import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/features/admins/data/admin_repository.dart';
import 'package:mason_sampler/src/features/admins/domain/admin.dart';

part 'admin_controller.g.dart';

@riverpod
class AdminController extends _$AdminController {
  @override
  Future<Admin> build(String id) async {
    final repo = ref.read(adminRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
