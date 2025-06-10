import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mason_sampler/src/core/models/dynamic_form_result.dart';
import 'package:mason_sampler/src/core/models/pb_file.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:mason_sampler/src/core/widgets/loading_filled_button.dart';

import 'dynamic_field.dart';
import 'dynamic_form_fields.dart';

class DynamicFormBuilder extends HookConsumerWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<DynamicFieldItem> fields;
  final void Function(DynamicFormResult result) onSubmit;
  final void Function(Map<String, dynamic> value)? onChange;
  final bool isLoading;
  final EdgeInsets? itemPadding;
  final AutovalidateMode? validateMode;

  const DynamicFormBuilder({
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    this.onChange,
    this.isLoading = false,
    this.itemPadding,
    this.validateMode,
  });

  onFormSubmit(List<DynamicField> fields) async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final rawValues = formKey.currentState!.value;

      final transformedValues = <String, dynamic>{};
      for (final field in fields) {
        final value = rawValues[field.name];

        // Apply the fieldTransformer if it exists
        final transformed = switch (field) {
          DynamicTextField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as String?),
          DynamicTypeAheadField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value),
          DynamicCheckboxField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as bool?),
          DynamicSelectField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value),
          DynamicDateField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as DateTime?),
          DynamicPBFilesField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as List<PBFile>?),
          DynamicDateTimeField f when f.fieldTransformer != null =>
            f.fieldTransformer!(value as DateTime?),
          _ => value,
        };
        transformedValues[field.name] = transformed;
      }

      final transformedFiles = List<http.MultipartFile>.empty(growable: true);
      for (final field in fields) {
        final value = rawValues[field.name];

        // Apply the fieldTransformer if it exists
        final transformed = switch (field) {
          DynamicPBFilesField f when f.fileTransformer != null =>
            f.fileTransformer!(value as List<PBFile>?),
          _ => value,
        };
        if (transformed is List<Future<http.MultipartFile>>)
          transformedFiles.addAll(await Future.wait(transformed));
      }

      // Now you can use transformedValues as needed
      // print('Transformed Values: $transformedValues');
      // print('Transformed Files: $transformedFiles');
      // e.g. await someRepo.submitForm(transformedValues);
      onSubmit(
        DynamicFormResult(values: transformedValues, files: transformedFiles),
      );
    }
  }

  List<DynamicField> collectFields(List<DynamicFieldItem> fields) {
    final result = <DynamicField>[];
    for (final field in fields) {
      if (field is DynamicFieldGroup) {
        final converted = collectFields(field.fields);
        result.addAll(converted);
      }

      if (field is DynamicFieldTwoColumn) {
        result.add(field.first);
        result.add(field.second);
      }

      if (field is DynamicField) {
        result.add(field);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formFields = collectFields(fields);

    return FormBuilder(
      key: formKey,
      enabled: isLoading == false,
      initialValue: formFields.toInitialValues(),
      autovalidateMode: validateMode,
      onChanged: () {
        if (onChange != null) {
          final current = formKey.currentState?.instantValue ?? {};
          onChange!(current);
        }
      },
      child: CustomScrollView(
        slivers: [
          ///
          /// Widgets
          ///
          SliverList.list(
            children: [
              DynamicFormFields(fieldItems: fields, itemPadding: itemPadding),
            ],
          ),

          ///
          /// Save Button
          ///
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: LoadingFilledButton(
                isLoading: isLoading,
                child: const Text('Save'),
                onPressed: () => onFormSubmit(formFields),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
