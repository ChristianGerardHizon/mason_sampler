import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:mason_sampler/src/core/widgets/basic_form_fields/basic_form_custom_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BasicFormModal extends HookConsumerWidget {
  final Widget field;
  final Map<String, dynamic> initialValues;
  final GlobalKey<FormBuilderState>? formKey;

  BasicFormModal({
    super.key,
    required this.field,
    this.initialValues = const {},
    this.formKey,
  });

  ///
  /// Show Modal
  ///
  static Future<Map<String, dynamic>?> show(
    BuildContext context,
    Widget field, {
    GlobalKey<FormBuilderState>? formKey,
    Map<String, dynamic> initialValues = const {},
  }) async {
    return showModalBottomSheet<Map<String, dynamic>?>(
      isDismissible: true,
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return BasicFormModal(
          field: field,
          initialValues: initialValues,
          formKey: formKey,
        );
      },
    );
  }

  ///
  /// Build Function
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasicFormCustomBuilder(
      formKey: formKey,
      field: field,
      initialValues: initialValues,
      onSubmit: (p0) {
        context.pop(p0);
      },
    );
  }
}
