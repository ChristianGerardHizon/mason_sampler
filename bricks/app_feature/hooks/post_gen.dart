// __brick__/post_gen.dart

import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  // Retrieve the `singular` variable from brick inputs
  final rawFeature = context.vars['plural'];
  if (rawFeature == null) {
    context.logger.warn('`singular` was not provided; skipping injection.');
    return;
  }
  final newFeature = rawFeature.toString();

  // Path to the file we want to modify
  const targetPath = 'lib/src/core/routing/main.routes.dart';
  final targetFile = File(targetPath);

  if (!targetFile.existsSync()) {
    context.logger.warn('File "$targetPath" not found. Skipping injection.');
    return;
  }

  // Read all lines from main.routes.dart
  final lines = targetFile.readAsLinesSync();

  // Anchor to search for
  const marker = "part 'main.routes.g.dart';";

  // The new line we want to insert
  final newLine = "part 'routes/$newFeature.routes.dart';";

  // Find the marker’s index
  final idx = lines.indexWhere((l) => l.trim() == marker);

  if (idx != -1) {
    // If newLine isn’t already present, insert right after the marker
    if (!lines.contains(newLine)) {
      lines.insert(idx + 1, newLine);
      context.logger
          .info('Inserted `$newLine` after `$marker` in $targetPath.');
    } else {
      context.logger
          .info('`$newLine` already present in $targetPath. No changes made.');
    }
  } else {
    // Marker not found → append at bottom if not already present
    if (!lines.contains(newLine)) {
      lines.add(newLine);
      context.logger.info(
          'Marker `$marker` not found. Appended `$newLine` to end of $targetPath.');
    } else {
      context.logger
          .info('`$newLine` already present in $targetPath. No changes made.');
    }
  }

  // Write back the modified contents
  targetFile.writeAsStringSync(lines.join('\n'));
}
