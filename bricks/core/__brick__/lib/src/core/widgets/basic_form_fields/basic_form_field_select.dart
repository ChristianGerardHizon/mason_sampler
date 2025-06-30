import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SelectOption<T> {
  final T value;
  final String label;

  const SelectOption({required this.value, required this.label});
}

class BasicFormFieldSelect<T> extends HookWidget {
  const BasicFormFieldSelect({
    required this.name,
    required this.options,
    this.initialValue,
    this.validator,
    this.valueTransformer,
    this.onChange,
    this.enabled = true,
    this.decoration = const InputDecoration(),
    super.key,
    this.keepAlive = false,
    this.margin = const EdgeInsets.only(top: 14),
  });

  final String name;
  final List<SelectOption<T>> options;
  final T? initialValue;
  final String? Function(T?)? validator;
  final dynamic Function(T?)? valueTransformer;
  final Function(dynamic)? onChange;
  final EdgeInsets margin;
  final bool enabled;
  final InputDecoration decoration;
  final bool keepAlive;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);

    return Padding(
      padding: margin,
      child: FormBuilderField<T>(
        key: key,
        name: name,
        initialValue: initialValue,
        enabled: enabled,
        validator: validator,
        onChanged: (x) => onChange?.call(x),
        valueTransformer: valueTransformer,
        builder: (FormFieldState<T> state) {
          final isEnabled = FormBuilder.of(context)?.enabled;
          return InputDecorator(
            decoration: decoration.copyWith(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              errorText: state.errorText,
              enabled: isEnabled,
              suffixIcon: state.value == null
                  ? null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                            tooltip: 'Clear selection',
                            icon: const Icon(Icons.clear),
                            onPressed: () => state.didChange(null),
                          ),
                        ),
                      ],
                    ),
            ),
            isEmpty: state.value == null,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                isExpanded: true,
                value: state.value,
                hint: Text(decoration.hintText ?? ''),
                onChanged: isEnabled == true
                    ? (val) {
                        state.didChange(val);
                        onChange?.call(val);
                      }
                    : null,
                items: options
                    .map(
                      (opt) => DropdownMenuItem(
                        value: opt.value,
                        child: Text(opt.label),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
