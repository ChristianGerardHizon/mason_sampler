import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/features/admins/data/admin_repository.dart';
import 'package:mason_sampler/src/features/admins/domain/admin.dart';

part 'admin_form_controller.g.dart';

class AdminFormState {
  final Admin? admin;

  AdminFormState({required this.admin});
}

@riverpod
class AdminFormController extends _$AdminFormController {
  @override
  Future<AdminFormState> build(String? id) async {
    final adminRepo = ref.read(adminRepositoryProvider);
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return AdminFormState(admin: null);
      }
      final admin = await $(adminRepo.get(id));
      return AdminFormState(admin: admin);
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
