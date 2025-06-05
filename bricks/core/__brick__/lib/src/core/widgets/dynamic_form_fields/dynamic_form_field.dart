import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_date_time.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_hidden.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_number.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_password.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_pb_files.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_typeahead.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/dynamic_form_fields/fields/dynamic_form_field_view.dart';

import 'dynamic_field.dart';
import 'fields/dynamic_form_field_images.dart';
import 'fields/dynamic_form_field_text.dart';
import 'fields/dynamic_form_field_checkbox.dart';
import 'fields/dynamic_form_field_select.dart';
import 'fields/dynamic_form_field_date.dart';

class DynamicFormField extends HookWidget {
  final DynamicField field;
  final EdgeInsets? margin;

  const DynamicFormField({super.key, required this.field, this.margin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: field.margin ?? margin ?? const EdgeInsets.all(0),
      child: Builder(
        builder: (context) {
          if (field is DynamicTextField) {
            return DynamicFormFieldText(field as DynamicTextField);
          }

          if (field is DynamicCheckboxField) {
            return DynamicFormFieldCheckbox(field as DynamicCheckboxField);
          }

          if (field is DynamicSelectField) {
            return DynamicFormFieldSelect(field as DynamicSelectField);
          }

          if (field is DynamicDateField) {
            return DynamicFormFieldDate(field as DynamicDateField);
          }

          if (field is DynamicImagesField) {
            return DynamicFormFieldImages(field as DynamicImagesField);
          }

          if (field is DynamicPBFilesField) {
            return DynamicFormFieldPBFiles(field as DynamicPBFilesField);
          }

          if (field is DynamicTypeAheadField) {
            return DynamicFormFieldTypeAhead(field as DynamicTypeAheadField);
          }

          if (field is DynamicViewField) {
            return DynamicFormFieldView(field as DynamicViewField);
          }

          if (field is DynamicPasswordField) {
            return DynamicFormFieldPassword(field as DynamicPasswordField);
          }

          if (field is DynamicNumberField) {
            return DynamicFormFieldNumber(field as DynamicNumberField);
          }

          if (field is DynamicHiddenField) {
            return DynamicFormFieldHidden(field as DynamicHiddenField);
          }

          if (field is DynamicDateTimeField) {
            return DynamicFormFieldDateTime(field as DynamicDateTimeField);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
