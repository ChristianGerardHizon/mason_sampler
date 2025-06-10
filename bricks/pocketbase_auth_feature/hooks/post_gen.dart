// __brick__/post_gen.dart

import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final rawPlural = context.vars['plural'];
  final rawSingular = context.vars['singular'];
  final rawPackageName = context.vars['packageName'];
  if (rawPlural == null) {
    context.logger
        .warn('⚠ `plural` was not provided; skipping all injections.');
    return;
  }
  if (rawSingular == null) {
    context.logger
        .warn('⚠ `singular` was not provided; skipping all injections.');
    return;
  }
  if (rawPackageName == null) {
    context.logger
        .warn('⚠ `packageName` was not provided; skipping all injections.');
    return;
  }
  final plural = rawPlural.toString();
  final packageName = rawPackageName.toString();
  final singular = rawSingular.toString();
  final pluralSnake = _toSnakeCase(plural);
  final pluralPascal = _toPascalCase(plural);
  final singularSnake = _toSnakeCase(singular);
  final singularPascal = _toPascalCase(singular);
  final pluralCamel = _toCamelCase(plural);
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
    // force: false is the default, so you can omit it if you don't want forced insertion.
  );

  // add page to main.routes import
  injectLine(
    context: context,
    targetPath: 'lib/src/core/routing/main.routes.dart',
    marker: "import 'package:go_router/go_router.dart';",
    newLine:
        "import 'package:$packageName/src/features/$pluralSnake/presentation/pages/_index.dart';",
    successMessage: 'Inserted import part for `$plural`',
    alreadyExistsMessage: 'Import part for `$plural` already exists',
    missingFileMessage: 'main.routes file not found',
    // If you ever want to insert even if the import is already present, pass force: true
    // force: true,
  );

  // Example usage for PocketBase collections:
  injectLine(
    context: context,
    targetPath: 'lib/src/core/models/pocketbase_collections.dart',
    // Look for the opening of the class; we’ll insert right after this marker
    marker: 'class PocketBaseCollections {',
    newLine: '  static const $pluralSnake = \'$pluralCamel\';',
    successMessage: 'Inserted PocketBase collection `$pluralSnake`',
    alreadyExistsMessage: 'PocketBase collection `$pluralSnake` already exists',
    missingFileMessage: 'PocketBase collections file not found',
    // force: false (default)
  );
  // add auth router utils imports
  injectLine(
    context: context,
    targetPath: 'lib/src/core/utils/router_utils.dart',
    marker: "import 'package:hooks_riverpod/hooks_riverpod.dart';",
    newLine:
        "import 'package:$packageNameSnake/src/core/utils/${singularSnake}_router_utils.dart';",
    successMessage: 'Inserted auth router utils imports',
    alreadyExistsMessage: 'Auth router utils imports already exists',
    missingFileMessage: 'router utils file not found',
  );

  // add auth router utils
  injectLine(
    context: context,
    targetPath: 'lib/src/core/utils/router_utils.dart',
    marker: 'if (isIgnored) return null;',
    newLine: '''
    final authResult = await ${singularPascal}RouterUtils.redirect(context, state, ref);
    if (authResult != null) {
      return authResult;
    }
''',
    successMessage: 'Inserted auth router utils',
    alreadyExistsMessage: 'Auth router utils already exists',
    missingFileMessage: 'Auth router utils file not found',
  );

  // auth controller imports
  injectLine(
    context: context,
    targetPath: 'lib/src/application.dart',
    marker: "import 'package:flutter/material.dart';",
    newLine: '''
import 'package:$packageNameSnake/src/features/$pluralSnake/presentation/controllers/auth_controller.dart';
import 'package:$packageNameSnake/src/features/$pluralSnake/presentation/pages/_index.dart';
import 'package:$packageNameSnake/src/core/widgets/stack_loader.dart';''',
    successMessage: 'Inserted auth controller import',
    alreadyExistsMessage: 'Auth controller import already exists',
    missingFileMessage: 'Application not found',
  );

  // add auth router utils
  injectLine(
    context: context,
    targetPath: 'lib/src/application.dart',
    marker: 'builder: (context, child) {',
    newLine: '''
              /// auth controller
              final state = ref.watch(authControllerProvider);

              return Stack(
                children: [
                  // 1) Always paint the real app (your router) as the bottom layer
                  if (child != null) Positioned.fill(child: child),

                  // 2) If we’re loading, overlay a semi-opaque barrier + spinner
                  if (state.isLoading)
                    Positioned.fill(
                      child: Container(
                        // match your scaffold / background color so there's never a flash of black:
                        color: Theme.of(
                          context,
                        ).scaffoldBackgroundColor.withOpacity(0.8),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              );''',
    successMessage: 'Inserted auth controller',
    alreadyExistsMessage: 'Auth controller already exists',
    missingFileMessage: 'Application not found',
  );

  context.logger.info('✅ post_gen: completed all injections.');
}

/// A general-purpose function to inject [newLine] into a file at [targetPath].
///
/// - Looks for [marker] (exact match after trimming) in the file’s lines.
///   • If found and [newLine] isn’t already present (or [force] is true), inserts [newLine] immediately
///     after that marker line.
///   • If [marker] isn’t found:
///       – If [newLine] already exists and [force] is false: logs [alreadyExistsMessage].
///       – Otherwise, appends [newLine] at the end.
///   • If [newLine] is already in the file and [force] is false, logs [alreadyExistsMessage] and does nothing.
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
  bool force = false, // <-- New optional parameter. When true, always insert.
}) {
  final file = File(targetPath);
  if (!file.existsSync()) {
    context.logger.warn('⚠ $missingFileMessage: `$targetPath`.');
    return;
  }

  final lines = file.readAsLinesSync();

  // If the file already contains newLine and we're not forcing, bail out.
  if (lines.contains(newLine) && !force) {
    context.logger.info('ℹ $alreadyExistsMessage.');
    return;
  }

  // Find the marker (trimmed) in the file.
  final idx = lines.indexWhere((l) => l.trim() == marker);
  if (idx != -1) {
    // Insert newLine right after the marker, even if it exists elsewhere when force == true.
    final updated = [
      ...lines.sublist(0, idx + 1),
      newLine,
      ...lines.sublist(idx + 1),
    ];
    file.writeAsStringSync(updated.join('\n'));
    context.logger.info('✓ $successMessage after marker `$marker`.');
  } else {
    // Marker not found.
    if (lines.contains(newLine) && !force) {
      // Already handled above, but double-check in case marker wasn’t found.
      context.logger.info('ℹ $alreadyExistsMessage.');
      return;
    }
    // Append newLine at the end.
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

/// Convert To CamelCase
String _toCamelCase(String input) {
  final words = input.trim().split(RegExp(r'[\s_]+'));
  if (words.isEmpty) return '';

  // first word all lowercase
  final firstWord = words.first.toLowerCase();

  // capitalize the first letter of each subsequent word
  final capitalizedWords = words.skip(1).map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join();

  return firstWord + capitalizedWords;
}
