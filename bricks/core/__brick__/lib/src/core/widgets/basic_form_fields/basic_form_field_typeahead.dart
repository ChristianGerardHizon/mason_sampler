import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class BasicFormFieldTypeAhead<T> extends HookWidget {
  final T? initialValue;
  final Future<List<T>> Function(String) onSearch;
  final String Function(T) selectionToString;
  final String? Function(dynamic)? validator;
  final dynamic Function(T?)? valueTransformer;
  final Widget Function(BuildContext, T) itemBuilder;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;
  final Function(T?)? onChange;
  final Duration debounceDuration;
  final InputDecoration decoration;
  final String name;
  final EdgeInsets margin;
  final bool enabled;
  final bool keepAlive;

  const BasicFormFieldTypeAhead({
    super.key,
    this.formFieldKey,
    required this.name,
    this.initialValue,
    this.validator,
    this.decoration = const InputDecoration(),
    required this.onSearch,
    required this.itemBuilder,
    this.valueTransformer,
    required this.selectionToString,
    this.onChange,
    this.debounceDuration = const Duration(milliseconds: 200),
    this.margin = const EdgeInsets.only(top: 14),
    this.enabled = true,
    this.keepAlive = false,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);
    return Padding(
      padding: margin,
      child: FormBuilderTypeAhead<T>(
        key: formFieldKey,
        name: name,
        initialValue: initialValue,
        hideKeyboardOnDrag: true,
        decoration: decoration,
        enabled: enabled,
        validator: validator,
        itemBuilder: itemBuilder,
        suggestionsCallback: onSearch,
        selectionToTextTransformer: selectionToString,
        debounceDuration: debounceDuration,
        valueTransformer: valueTransformer,
        onChanged: onChange,
        hideOnUnfocus: true,
        emptyBuilder: (context) =>
            ListTile(title: const Text('No results found')),
      ),
    );
  }
}
