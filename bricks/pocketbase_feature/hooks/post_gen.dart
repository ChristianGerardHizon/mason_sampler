// __brick__/post_gen.dart

import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final rawPlural = context.vars['plural'];
  final rawPackageName = context.vars['packageName'];
  if (rawPlural == null) {
    context.logger
        .warn('⚠ `plural` was not provided; skipping all injections.');
    return;
  }
  if (rawPackageName == null) {
    context.logger
        .warn('⚠ `packageName` was not provided; skipping all injections.');
    return;
  }
  final plural = rawPlural.toString();
  final packageName = rawPackageName.toString();
  final pluralSnake = _toSnakeCase(plural);
  final pluralPascal = _toPascalCase(plural);
  final packageNameSnake = _toSnakeCase(packageName.toString());

  // Example usage for routes:
  injectLine(
    context: context,
    targetPath: 'lib/src/core/routing/main.routes.dart',
    marker: "part 'main.routes.g.dart';",
    newLine: "part 'routes/$plural.routes.dart';",
    successMessage: 'Inserted route part for `$plural`',
    alreadyExistsMessage: 'Route part for `$plural` already exists',
    missingFileMessage: 'main.routes file not found',
  );

  // add page to main.routes import
  // Example usage for routes:
  injectLine(
    context: context,
    targetPath: 'lib/src/core/routing/main.routes.dart',
    marker: "import 'package:go_router/go_router.dart';",
    newLine:
        "import 'package:$packageName/src/features/$pluralSnake/presentation/pages/_index.dart';",
    successMessage: 'Inserted import part for `$plural`',
    alreadyExistsMessage: 'Import part for `$plural` already exists',
    missingFileMessage: 'main.routes file not found',
  );

  // Example usage for PocketBase collections:
  injectLine(
    context: context,
    targetPath: 'lib/src/core/models/pocketbase_collections.dart',
    // Look for the opening of the class; we’ll insert right after this marker
    marker: 'class PocketBaseCollections {',
    newLine: '  static const $pluralSnake = \'$pluralPascal\';',
    successMessage: 'Inserted PocketBase collection `$pluralSnake`',
    alreadyExistsMessage: 'PocketBase collection `$pluralSnake` already exists',
    missingFileMessage: 'PocketBase collections file not found',
  );

  context.logger.info('✅ post_gen: completed all injections.');
}

/// A general-purpose function to inject [newLine] into a file at [targetPath].
///
/// - Looks for [marker] (exact match after trimming) in the file’s lines.
///   • If found and [newLine] isn’t already present, inserts [newLine] immediately
///     after that marker line.
///   • If [marker] isn’t found, appends [newLine] at the end (unless already present).
///   • If [newLine] is already in the file, logs [alreadyExistsMessage] and does nothing.
///   • If [targetPath] doesn’t exist, logs [missingFileMessage] and does nothing.
///
/// You can customize the logged messages via [successMessage], [alreadyExistsMessage],
/// and [missingFileMessage]. Icons (✓, ℹ, ⚠) are included for clarity.
void injectLine({
  required HookContext context,
  required String targetPath,
  required String marker,
  required String newLine,
  required String successMessage,
  required String alreadyExistsMessage,
  required String missingFileMessage,
}) {
  final file = File(targetPath);
  if (!file.existsSync()) {
    context.logger.warn('⚠ $missingFileMessage: `$targetPath`.');
    return;
  }

  final lines = file.readAsLinesSync();
  if (lines.contains(newLine)) {
    context.logger.info('ℹ $alreadyExistsMessage.');
    return;
  }

  final idx = lines.indexWhere((l) => l.trim() == marker);
  if (idx != -1) {
    final updated = [
      ...lines.sublist(0, idx + 1),
      newLine,
      ...lines.sublist(idx + 1),
    ];
    file.writeAsStringSync(updated.join('\n'));
    context.logger.info('✓ $successMessage after marker `$marker`.');
  } else {
    final updated = [...lines, newLine];
    file.writeAsStringSync(updated.join('\n'));
    context.logger
        .info('✓ Marker `$marker` not found; appended `$newLine` to end.');
  }
}

/// Converts “MyFeatureName” or “my feature name” to `my_feature_name`.
String _toSnakeCase(String input) {
  final buffer = StringBuffer();
  var prevWasLower = false;

  for (var i = 0; i < input.length; i++) {
    final char = input[i];
    if (RegExp(r'[A-Z]').hasMatch(char)) {
      if (i > 0 && prevWasLower) buffer.write('_');
      buffer.write(char.toLowerCase());
      prevWasLower = false;
    } else if (RegExp(r'\s+|_').hasMatch(char)) {
      buffer.write('_');
      prevWasLower = false;
    } else {
      buffer.write(char);
      prevWasLower = true;
    }
  }

  return buffer
      .toString()
      .replaceAll(RegExp(r'_+'), '_')
      .replaceAll(RegExp(r'^_|_$'), '');
}

/// Converts “my_feature_name” or “my feature name” to `MyFeatureName`.
String _toPascalCase(String input) {
  final words = input.trim().split(RegExp(r'[\s_]+'));
  final capitalized = words.map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  });
  return capitalized.join();
}
