import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BasicFormFieldNumber extends HookWidget {
  final num min;
  final num max;
  final num? step;
  final num? initialValue;
  final String? Function(dynamic)? validator;
  final dynamic Function(dynamic)? valueTransformer;
  final InputDecoration decoration;
  final EdgeInsets? margin;
  final bool enabled;
  final String name;
  final Function(num?)? onChanged;
  final bool showButtons;
  final bool keepAlive;

  const BasicFormFieldNumber({
    required this.name,
    this.initialValue,
    this.validator,
    this.valueTransformer,
    this.min = 0,
    this.max = 9999999.0,
    this.step,
    this.decoration = const InputDecoration(border: InputBorder.none),
    this.margin,
    this.enabled = true,
    this.onChanged,
    this.showButtons = true,
    super.key,
    this.keepAlive = false,
  });

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive(wantKeepAlive: keepAlive);
    final _fieldKey = GlobalKey<FormBuilderFieldState>();

    return FormBuilderField<num>(
      name: name,
      initialValue: initialValue ?? min,
      key: _fieldKey,
      valueTransformer: valueTransformer,
      validator: validator,

      builder: (FormFieldState<num> field) {
        final rStep = step ?? 1;

        ///
        /// onAdd
        ///
        onAdd() {
          final value = (field.value ?? min);
          final newValue = value + rStep;
          if (newValue > max) return;
          field.didChange(newValue);
        }

        ///
        /// onSubtract
        ///
        onSubtract() {
          final value = (field.value ?? min);
          final newValue = value - rStep;
          if (newValue < min) return;
          field.didChange(newValue);
        }

        return InputDecorator(
          decoration: decoration.copyWith(
            errorText: field.errorText,
            prefix: showButtons
                ? IconButton(onPressed: onSubtract, icon: Icon(MIcons.minus))
                : null,
            suffix: showButtons
                ? IconButton(onPressed: onAdd, icon: Icon(MIcons.plus))
                : null,
          ),
          child: _BasicFormFieldNumber(
            onChanged: (value) {
              field.didChange(value);
              onChanged?.call(value);
            },
            min: min,
            max: max,
            enabled: enabled,
            value: field.value,
          ),
        );
      },
    );
  }
}

class _BasicFormFieldNumber extends HookConsumerWidget {
  final num? value;
  final num min;
  final num max;
  final bool enabled;
  final Function(num?)? onChanged;

  const _BasicFormFieldNumber({
    this.value,
    this.enabled = true,
    required this.min,
    required this.max,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: (value).toString());

    useEffect(() {
      if (value?.toString() == controller.text) return;
      Future.delayed(
        Duration.zero,
        () => controller.text = (value)?.toString() ?? '',
      );
      return null;
    }, [value]);

    return TextFormField(
      onChanged: (value) => onChanged?.call(num.tryParse(value)),
      controller: controller,
      decoration: InputDecoration(border: InputBorder.none),
      textAlign: TextAlign.center,
      enabled: enabled,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          final text = newValue.text.trim();

          if (newValue.text.isEmpty)
            return TextEditingValue(
              text: min.toString(),
              selection: TextSelection(
                baseOffset: 0,
                extentOffset: min.toString().length,
              ),
            );

          // Reject empty or invalid numeric input
          if (text.isEmpty || num.tryParse(text) == null) {
            return TextEditingValue(
              text: oldValue.text,
              selection: oldValue.selection,
            );
          }

          final number = num.parse(text);

          // Reject if out of bounds
          if (number < min || number > max) {
            return TextEditingValue(
              text: oldValue.text,
              selection: oldValue.selection,
            );
          }

          // Accept valid input
          return newValue;
        }),
      ],
    );
  }
}
