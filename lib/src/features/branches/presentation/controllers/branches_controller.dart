import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/core/models/fields/pb_field.dart';
import 'package:mason_sampler/src/features/branches/data/branch_repository.dart';
import 'package:mason_sampler/src/features/branches/domain/branch.dart';

part 'branches_controller.g.dart';

@riverpod
class BranchesController extends _$BranchesController {
  @override
  Future<List<Branch>> build() async {
    final repo = ref.read(branchRepositoryProvider);
    final result = await repo
        .listAll(filter: "${PbField.isDeleted} = false")
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
