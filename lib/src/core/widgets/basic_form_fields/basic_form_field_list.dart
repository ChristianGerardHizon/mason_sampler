import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mason_sampler/src/core/widgets/modals/basic_form_modal.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BasicFormFieldList<T> extends HookWidget {
  final List<T>? initialValue;
  final String? Function(List<T>?)? validator;
  final void Function(T?)? onSubmit;
  final Widget Function(T?, GlobalKey<FormBuilderState> formKey) fieldBuilder;
  final T Function(Map<String, dynamic>) modalResult;
  final Widget Function(
    BuildContext context,
    int index,
    dynamic value, {
    void Function()? onDelete,
    void Function(Map<String, dynamic> map)? onUpdate,
  })
  builder;
  final String name;
  final InputDecoration decoration;
  final EdgeInsets? margin;
  final bool enabled;
  final dynamic Function(List<T>?)? valueTransformer;
  final bool keepAlive;

  const BasicFormFieldList({
    super.key,
    required this.fieldBuilder,
    required this.builder,
    this.initialValue,
    this.validator,
    this.onSubmit,
    required this.modalResult,
    required this.name,
    this.decoration = const InputDecoration(),
    this.margin,
    this.enabled = true,
    this.valueTransformer,
    this.keepAlive = false,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);

    final theme = Theme.of(context);
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    return FormBuilderField<List<T>>(
      name: name,
      validator: validator,
      valueTransformer: valueTransformer,
      initialValue: initialValue,
      builder: (formField) {
        final list = [...formField.value ?? []];
        final enabled = FormBuilder.of(context)?.enabled;

        /// add a button to add a new item
        return InputDecorator(
          decoration: decoration.copyWith(labelText: 'Lines', enabled: enabled),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 10),

              ///
              /// EmptyBasicFormModal
              ///
              if (list.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      'No lines added',
                      style: TextStyle(
                        color: enabled == true
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurface.withValues(alpha: .5),
                      ),
                    ),
                  ),
                ),

              ///
              /// List
              ///
              if (list.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final widget = builder(
                      context,
                      index,
                      item,
                      onDelete: () {
                        list.removeAt(index);
                        formField.didChange(<T>[...list]);
                      },
                      onUpdate: (Map<String, dynamic> map) async {
                        final result = await BasicFormModal.show(
                          context,
                          fieldBuilder(item, formKey),
                          initialValues: map,
                          formKey: formKey,
                        );
                        if (result == null) return;
                        final data = modalResult(result);
                        final updatedList = <T>[...list];
                        updatedList[index] = data;
                        formField.didChange(<T>[...updatedList]);
                      },
                    );
                    return widget;
                  },
                  itemCount: list.length,
                ),

              ///
              /// Add Button
              ///
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 14),
                child: TextButton(
                  onPressed: enabled == true
                      ? () async {
                          final result = await BasicFormModal.show(
                            context,
                            fieldBuilder(null, formKey),
                            formKey: formKey,
                          );
                          if (result == null) return;
                          final data = modalResult(result);
                          formField.didChange(<T>[...list, data]);
                        }
                      : null,
                  child: const Text('Add Line'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
