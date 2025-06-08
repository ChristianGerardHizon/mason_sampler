import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:mason_sampler/src/features/branches/data/branch_repository.dart';
import 'package:mason_sampler/src/features/branches/domain/branch.dart';

part 'branch_controller.g.dart';

@riverpod
class BranchController extends _$BranchController {
  @override
  Future<Branch> build(String id) async {
    final repo = ref.read(branchRepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
