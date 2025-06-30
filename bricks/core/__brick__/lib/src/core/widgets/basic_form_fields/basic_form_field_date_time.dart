import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class BasicFormFieldDateTime extends HookWidget {
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;
  final DateFormat? format;
  final String? Function(DateTime?)? validator;
  final GlobalKey<FormBuilderFieldState>? formFieldKey;
  final TimeOfDay? defaultTime;
  final String name;
  final InputDecoration decoration;
  final String? Function(DateTime?)? selectionToString;
  final Function(DateTime)? onChange;
  final Duration debounceDuration;
  final EdgeInsets margin;
  final bool enabled;
  final dynamic Function(DateTime?)? valueTransformer;
  final bool keepAlive;

  const BasicFormFieldDateTime({
    this.formFieldKey,
    this.defaultTime,
    required this.name,
    this.initialValue,
    this.validator,
    this.decoration = const InputDecoration(),
    this.valueTransformer,
    this.selectionToString,
    this.onChange,
    this.debounceDuration = const Duration(milliseconds: 300),
    this.margin = const EdgeInsets.only(top: 14),
    this.enabled = true,
    this.firstDate,
    this.lastDate,
    this.format,
    this.keepAlive = false,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);

    return Padding(
      padding: margin,
      child: FormBuilderField<DateTime?>(
        key: formFieldKey,
        enabled: enabled,
        name: name,
        validator: validator,
        initialValue: initialValue,
        valueTransformer: valueTransformer,
        builder: (FormFieldState<DateTime?> state) {
          return InputDecorator(
            decoration: decoration.copyWith(
              errorText: state.errorText,
              enabled: FormBuilder.of(context)?.enabled,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (state.value != null)
                    IconButton(
                      tooltip: 'Clear date & time',
                      icon: const Icon(Icons.clear),
                      onPressed: () => state.didChange(null),
                    ),
                  IconButton(
                    tooltip: 'Pick date',
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: state.value ?? DateTime.now(),
                        firstDate: firstDate ?? DateTime(1900),
                        lastDate: lastDate ?? DateTime(2100),
                      );
                      if (pickedDate != null) {
                        final old = state.value ?? DateTime.now();
                        final newDateTime = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          old.hour,
                          old.minute,
                        );
                        state.didChange(newDateTime);
                        if (onChange != null) {
                          onChange!(newDateTime);
                        }
                      }
                    },
                  ),
                  IconButton(
                    tooltip: 'Pick time',
                    icon: const Icon(Icons.access_time),
                    onPressed: () async {
                      final current = state.value ?? DateTime.now();
                      final initialTime =
                          defaultTime ?? TimeOfDay.fromDateTime(current);
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: initialTime,
                        initialEntryMode: TimePickerEntryMode.input,
                      );
                      if (pickedTime != null) {
                        final datePart = state.value ?? DateTime.now();
                        final newDateTime = DateTime(
                          datePart.year,
                          datePart.month,
                          datePart.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        state.didChange(newDateTime);
                        if (onChange != null) {
                          onChange!(newDateTime);
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
            child: Text(
              state.value != null
                  ? (format?.format(state.value!) ??
                        DateFormat.yMMMd().add_jm().format(state.value!))
                  : '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        },
      ),
    );
  }
}
