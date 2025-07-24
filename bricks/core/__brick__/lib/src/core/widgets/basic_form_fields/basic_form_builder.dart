import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/modals/confirm_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:{{packageName.snakeCase()}}/src/core/widgets/loading_filled_button.dart';

/// A lightweight controller that lets anyone call `submit()`,
/// and dispatches to all registered listeners.
class SubmitController {
  final List<VoidCallback> _listeners = [];

  /// Parent (or any widget) registers its onSubmit here.
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// Called by any child to trigger the submit.
  void submit() {
    for (final listener in _listeners) {
      listener();
    }
  }
}

class BasicFormBuilder extends HookConsumerWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<Widget> fields;
  final void Function(Map<String, dynamic>? result) onSubmit;
  final void Function(Map<String, dynamic> value)? onChange;
  final bool isLoading;
  final AutovalidateMode? validateMode;
  final String buttonText;
  final Map<String, dynamic> initialValues;
  final bool addAutomaticKeepAlives;
  final EdgeInsets padding;
  final bool? confirmOnPop;

  const BasicFormBuilder({
    this.confirmOnPop = true,
    super.key,
    required this.formKey,
    required this.fields,
    required this.onSubmit,
    this.onChange,
    this.isLoading = false,
    this.validateMode,
    this.buttonText = 'Submit',
    this.initialValues = const {},
    this.addAutomaticKeepAlives = true,
    this.padding = const EdgeInsets.only(top: 14, left: 20, right: 20),
  });

  onFormSubmit(GlobalKey<FormBuilderState> _formKey) async {
    final form = _formKey.currentState;
    if (form?.saveAndValidate() ?? false) {
      final current = form?.instantValue ?? {};
      onSubmit(current);
      return;
    }
  }

  onFormChange(GlobalKey<FormBuilderState> _formKey) async {
    if (onChange != null) {
      final current = _formKey.currentState?.instantValue ?? {};
      onChange!(current);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canPop = useState<bool>(false);

    return FormBuilder(
      canPop: canPop.value,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop == true) return;
        final isDirty = formKey.currentState?.isDirty ?? false;
        if (isDirty && confirmOnPop == true) {
          final result = await ConfirmModal.taskResult(
            context,
            confirm: 'Discard',
            title: 'Unsaved Changes',
            message: 'Are you sure you want to discard changes?',
            cancel: 'Cancel',
          ).run();

          if (result.isLeft()) return;
        }

        canPop.value = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.pop();
        });
      },
      key: formKey,
      enabled: !isLoading,
      initialValue: initialValues,
      autovalidateMode: validateMode,
      onChanged: () => onFormChange(formKey),
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            ///
            /// Widgets
            ///
            ...fields,

            ///
            /// Save Button
            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
              child: LoadingFilledButton(
                isLoading: isLoading,
                child: Text(buttonText),
                onPressed: () => onFormSubmit(formKey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension FormBuilderExtension on FormBuilderState {
  TaskResult<Map<String, dynamic>> submitAndValidateTask() {
    if (saveAndValidate() == false) {
      return TaskResult.left(
        FormFailure('Form is invalid', StackTrace.current),
      );
    }
    return TaskResult.right(instantValue);
  }
}
