// __brick__/post_gen.dart

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:mason/mason.dart';

void run(HookContext context) {
  // Define all relative folders you want to scan for the deletion marker.
  // For example: ['projectdirector/lib', 'another_folder/src']
  final pathsToPurge = [
    'lib',
  ];

  deleteMarkedFilesInPaths(context, pathsToPurge);

  context.logger.info(
      'post_gen: removed all files containing the deletion marker under the specified paths.');
}

/// Traverses each folder in [relativePaths] (relative to the project root)
/// and deletes any files that contain the exact marker
/// `// TODO: delete me postgen`.
///
/// For each deleted file, it logs an informational message. If a target
/// directory does not exist, it logs a warning and moves on to the next path.
void deleteMarkedFilesInPaths(HookContext context, List<String> relativePaths) {
  final rootDir = Directory.current;

  for (final relPath in relativePaths) {
    final targetDir = Directory(p.join(rootDir.path, relPath));

    if (!targetDir.existsSync()) {
      context.logger.warn('Directory not found: ${targetDir.path}');
      continue;
    }

    for (final entity in targetDir.listSync(recursive: true)) {
      if (entity is File) {
        try {
          final content = entity.readAsStringSync();
          if (content.contains('// TODO: delete me postgen')) {
            entity.deleteSync();
            context.logger.info('Deleted marked file: ${entity.path}');
          }
        } catch (_) {
          // If reading fails (e.g. binary file), skip it.
          continue;
        }
      }
    }
  }
}
