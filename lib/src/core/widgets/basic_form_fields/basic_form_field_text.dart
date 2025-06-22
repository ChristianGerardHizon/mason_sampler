import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BasicFormFieldText extends HookWidget {
  const BasicFormFieldText({
    required this.name,
    this.initialValue,
    this.validator,
    this.valueTransformer,
    this.onChange,
    this.onSubmitted,
    this.margin = const EdgeInsets.only(bottom: 12),
    this.enabled = true,
    this.decoration = const InputDecoration(),
    this.obscureText = false,
    this.builder,
    this.keepAlive = false,
    super.key,
    this.minLines,
    this.maxLines,
  });

  final String name;
  final String? initialValue;
  final String? Function(String?)? validator;
  final dynamic Function(String?)? valueTransformer;
  final Function(dynamic)? onChange;
  final EdgeInsets margin;
  final bool enabled;
  final InputDecoration decoration;
  final bool obscureText;
  final int? minLines;
  final int? maxLines;
  final Widget Function(BuildContext context, String? value)? builder;
  final bool keepAlive;
  final void Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);

    return FormBuilderTextField(
      name: name,
      initialValue: initialValue,
      decoration: decoration,
      validator: validator,
      obscureText: obscureText,
      minLines: obscureText ? 1 : minLines,
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChange,
      valueTransformer: valueTransformer,
      onSubmitted: onSubmitted,
    );
  }
}
