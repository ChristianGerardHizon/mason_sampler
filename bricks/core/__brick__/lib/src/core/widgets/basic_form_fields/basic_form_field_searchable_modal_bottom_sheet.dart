import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class BasicFormFieldSearchableModalBottomSheet<T> extends HookWidget {
  final T? initialValue;
  final String name;
  final bool enabled;
  final bool keepAlive;
  final InputDecoration decoration;
  final InputDecoration searchDecoration;
  final FutureOr<List<T>> Function(String, LoadProps?)? asyncItems;
  final String Function(T)? itemAsString;
  final FormFieldValidator<T>? validator;
  final dynamic Function(T?)? valueTransformer;
  final Function(T?)? onChange;
  final List<T> items;
  final List<T> Function(List<T>)? suggestedItems;
  final DropdownSearchFilterFn<T>? filterFn;
  final DropdownSearchCompareFn<T>? compareFn;
  final Widget Function(BuildContext, T, bool, bool)? itemBuilder;
  final DropdownSearchBuilder<T>? dropdownBuilder;
  final EdgeInsets margin;
  final PopupBuilder? popupBuilder;

  BasicFormFieldSearchableModalBottomSheet({
    super.key,
    this.initialValue,
    required this.name,
    this.enabled = true,
    this.keepAlive = false,
    this.decoration = const InputDecoration(),
    this.searchDecoration = const InputDecoration(),
    this.asyncItems,
    this.itemAsString,
    this.validator,
    this.valueTransformer,
    this.onChange,
    this.items = const [],
    this.suggestedItems,
    this.filterFn,
    this.compareFn,
    this.itemBuilder,
    this.dropdownBuilder,
    this.margin = const EdgeInsets.only(top: 14),
    this.popupBuilder,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);
    return Padding(
      padding: margin,
      child: FormBuilderSearchableDropdown<T>(
        name: name,
        initialValue: initialValue,
        enabled: enabled,
        asyncItems: asyncItems,
        itemAsString: itemAsString,
        decoration: decoration,
        validator: validator,
        valueTransformer: valueTransformer,
        onChanged: onChange,
        items: items,
        compareFn: compareFn,
        dropdownBuilder: dropdownBuilder,
        filterFn: filterFn,
        popupProps: PopupProps.modalBottomSheet(
          suggestedItemProps: SuggestedItemProps(
            suggestedItems: suggestedItems,
            showSuggestedItems: true,
          ),
          itemBuilder: itemBuilder,
          showSearchBox: true,
          containerBuilder: (context, popupWidget) {
            if (popupBuilder != null) {
              return popupBuilder!(context, popupWidget);
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: popupWidget,
            );
          },
          emptyBuilder: (context, text) {
            if (text.isEmpty) {
              return Center(
                child: Text(
                  'No items found',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              );
            }

            return Center(
              child: Text(
                'Unable to find items with "$text"',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            );
          },
          searchFieldProps: TextFieldProps(decoration: searchDecoration),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: 800,
          ),
          modalBottomSheetProps: ModalBottomSheetProps(
            useRootNavigator: true,
            useSafeArea: true,
          ),
        ),
      ),
    );
  }
}
