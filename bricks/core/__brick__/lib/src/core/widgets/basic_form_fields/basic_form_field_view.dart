import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BasicFormFieldView<T> extends HookWidget {
  const BasicFormFieldView({
    required this.name,
    this.initialValue,
    this.validator,
    this.onChange,
    this.margin = const EdgeInsets.only(top: 14),
    this.enabled = true,
    this.decoration = const InputDecoration(),
    this.builder,
    this.keepAlive = false,
    this.valueTransformer,
    super.key,
  });

  final String name;
  final T? initialValue;
  final String? Function(T?)? validator;
  final Function(dynamic)? onChange;
  final EdgeInsets margin;
  final bool enabled;
  final InputDecoration decoration;
  final Widget Function(BuildContext context, T? value)? builder;
  final bool keepAlive;
  final dynamic Function(T?)? valueTransformer;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);
    return Padding(
      padding: margin,
      child: FormBuilderField<T>(
        key: key,
        name: name,
        enabled: enabled,
        validator: validator,
        initialValue: initialValue,
        onChanged: (x) => onChange?.call(x),
        valueTransformer: valueTransformer,
        builder: (FormFieldState<T> field) {
          if (builder == null) return SizedBox();
          return InputDecorator(
            decoration: decoration.copyWith(
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              errorText: field.errorText,
              enabled: FormBuilder.of(context)?.enabled,
            ),
            isEmpty: field.value == null,
            child: builder?.call(context, field.value),
          );
        },
      ),
    );
  }
}
