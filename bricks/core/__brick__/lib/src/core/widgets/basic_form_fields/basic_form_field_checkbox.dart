import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BasicFormFieldCheckbox extends HookWidget {
  const BasicFormFieldCheckbox({
    required this.name,
    required this.title,
    this.initialValue,
    this.validator,
    this.valueTransformer,
    this.onChange,
    this.margin = const EdgeInsets.only(top: 14),
    this.enabled = true,
    this.decoration = const InputDecoration(),
    this.keepAlive = false,
    this.controlAffinity = ListTileControlAffinity.leading,
    super.key,
  });

  final String name;
  final bool? initialValue;
  final String? Function(dynamic)? validator;
  final dynamic Function(bool?)? valueTransformer;
  final Function(bool?)? onChange;
  final EdgeInsets margin;
  final bool enabled;
  final InputDecoration decoration;
  final bool keepAlive;
  final Widget title;
  final ListTileControlAffinity controlAffinity;

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);

    return Padding(
      padding: margin,
      child: FormBuilderCheckbox(
        name: name,
        title: title,
        initialValue: initialValue,
        decoration: decoration,
        validator: validator,
        onChanged: onChange,
        controlAffinity: controlAffinity,
        valueTransformer: valueTransformer,
      ),
    );
  }
}
