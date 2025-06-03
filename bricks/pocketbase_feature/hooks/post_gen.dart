// __brick__/post_gen.dart

import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  final rawPlural = context.vars['plural'];
  if (rawPlural == null) {
    context.logger
        .warn('⚠ `plural` was not provided; skipping all injections.');
    return;
  }
  final featureName = rawPlural.toString();

  _injectRoutePart(
    context: context,
    featureName: featureName,
    // Defaults:
    // targetPath = 'lib/src/core/routing/main.routes.dart'
    // marker = "part 'main.routes.g.dart';"
  );

  _injectPocketBaseConstant(
    context: context,
    rawPlural: featureName,
    // Defaults:
    // targetPath = 'lib/src/core/models/pocketbase_collections.dart'
    // className = 'PocketBaseCollections'
  );

  context.logger.info('✅ post_gen: completed all injections.');
}

/// Inserts a `part 'routes/<featureName>.routes.dart';` line into
/// `main.routes.dart`, immediately after [marker]. If [marker] is not found,
/// it appends the line at the end. Ignores if the line already exists.
void _injectRoutePart({
  required HookContext context,
  required String featureName,
  String targetPath = 'lib/src/core/routing/main.routes.dart',
  String marker = "part 'main.routes.g.dart';",
}) {
  final newLine = "part 'routes/$featureName.routes.dart';";
  final file = File(targetPath);

  if (!file.existsSync()) {
    context.logger
        .warn('⚠ File "$targetPath" not found. Skipping route injection.');
    return;
  }

  final lines = file.readAsLinesSync();
  if (lines.contains(newLine)) {
    context.logger
        .info('ℹ `$newLine` already present in $targetPath. No changes made.');
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
    context.logger
        .info('✅ Inserted `$newLine` after `$marker` in $targetPath.');
  } else {
    final updated = [...lines, newLine];
    file.writeAsStringSync(updated.join('\n'));
    context.logger.info(
      '✅ Marker `$marker` not found. Appended `$newLine` to end of $targetPath.',
    );
  }
}

/// Inserts a `static const <snake> = '<Pascal>';` line into
/// `pocketbase_collections.dart`, immediately inside the body of [className].
/// If the class opening isn’t found, it inserts before the final closing brace.
/// Ignores if the line already exists.
void _injectPocketBaseConstant({
  required HookContext context,
  required String rawPlural,
  String targetPath = 'lib/src/core/models/pocketbase_collections.dart',
  String className = 'PocketBaseCollections',
}) {
  final snake = _toSnakeCase(rawPlural);
  final pascal = _toPascalCase(rawPlural);
  final newLine = '  static const $snake = \'$pascal\';';

  final file = File(targetPath);
  if (!file.existsSync()) {
    context.logger
        .warn('⚠ File "$targetPath" not found. Skipping collection injection.');
    return;
  }

  final originalContent = file.readAsStringSync();
  if (originalContent.contains(newLine)) {
    context.logger
        .info('ℹ `$newLine` already present in $targetPath. No changes made.');
    return;
  }

  final updatedContent = _injectConstantIntoClass(
    originalContent: originalContent,
    className: className,
    constantLine: newLine,
  );

  if (updatedContent != originalContent) {
    file.writeAsStringSync(updatedContent);
    context.logger.info('✅ Inserted collection constant into $targetPath');
  } else {
    context.logger.info(
        'ℹ Could not find class `$className` in $targetPath. No changes made.');
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

/// Inserts [constantLine] into the body of `class <className> { … }`.
/// If it finds `class <className> {`, it inserts immediately after that opening brace.
/// Otherwise, it tries to insert just before the final closing brace `}`. If neither
/// spot is found or if [constantLine] already exists, returns the original content.
String _injectConstantIntoClass({
  required String originalContent,
  required String className,
  required String constantLine,
}) {
  final classOpeningPattern =
      RegExp(r'(class\s+' + RegExp.escape(className) + r'\s*\{\s*)');

  if (classOpeningPattern.hasMatch(originalContent)) {
    return originalContent.replaceFirstMapped(
      classOpeningPattern,
      (match) => '${match.group(1)}\n$constantLine\n',
    );
  }

  final closingBracePattern = RegExp(r'(\}\s*)$');
  if (closingBracePattern.hasMatch(originalContent)) {
    return originalContent.replaceFirstMapped(
      closingBracePattern,
      (match) => '  $constantLine\n${match.group(1)}',
    );
  }

  return originalContent;
}
