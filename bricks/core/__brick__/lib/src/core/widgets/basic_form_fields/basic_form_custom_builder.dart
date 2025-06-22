import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:{{packageName.snakeCase()}}/src/core/widgets/loading_filled_button.dart';

class BasicFormCustomBuilder extends HookConsumerWidget {
  final GlobalKey<FormBuilderState>? formKey;
  final Widget field;
  final void Function(Map<String, dynamic>? result) onSubmit;
  final void Function(Map<String, dynamic> value)? onChange;
  final bool isLoading;
  final AutovalidateMode? validateMode;
  final String buttonText;
  final Map<String, dynamic> initialValues;
  final bool addAutomaticKeepAlives;
  final EdgeInsets padding;

  const BasicFormCustomBuilder({
    super.key,
    required this.formKey,
    required this.field,
    required this.onSubmit,
    this.onChange,
    this.isLoading = false,
    this.validateMode,
    this.buttonText = 'Submit',
    this.initialValues = const {},
    this.addAutomaticKeepAlives = true,
    this.padding = const EdgeInsets.only(top: 14, left: 20, right: 20),
  });

  onFormSubmit(GlobalKey<FormBuilderState>? _formKey) async {
    final form = _formKey?.currentState;
    if (form?.saveAndValidate() ?? false) {
      final current = form?.instantValue ?? {};
      onSubmit(current);
      return;
    }
  }

  onFormChange(GlobalKey<FormBuilderState>? _formKey) async {
    if (onChange != null) {
      final current = _formKey?.currentState?.instantValue ?? {};
      onChange!(current);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormBuilder(
      key: formKey,
      enabled: !isLoading,
      initialValue: initialValues,
      autovalidateMode: validateMode,
      onChanged: () => onFormChange(formKey),
      child: ListView(
        padding: padding,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        children: [
          ///
          /// Widgets
          ///
          field,

          ///
          /// Save Button
          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: LoadingFilledButton(
              isLoading: isLoading,
              child: Text(buttonText),
              onPressed: () => onFormSubmit(formKey),
            ),
          ),
        ],
      ),
    );
  }
}
