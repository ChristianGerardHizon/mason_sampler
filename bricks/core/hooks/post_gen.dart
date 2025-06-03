// __brick__/post_gen.dart

import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  // Starting from the generated project root.
  final rootDir = Directory.current;

  // Recursively walk every file under the project.
  for (final entity in rootDir.listSync(recursive: true)) {
    if (entity is File) {
      try {
        // Read the file as text.
        final content = entity.readAsStringSync();
        // If, after trimming whitespace, it’s empty, delete it.
        if (content.trim().isEmpty) {
          entity.deleteSync();
          context.logger.info('Deleted empty file: ${entity.path}');
        }
      } catch (e) {
        // If reading fails (e.g. binary file), skip it.
        continue;
      }
    }
  }

  context.logger.info('post_gen: removed all empty files.');
}
