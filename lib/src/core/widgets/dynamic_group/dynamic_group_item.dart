import 'package:flutter/material.dart';
import 'package:mason_sampler/src/core/routing/router.dart';

class DynamicGroupItem extends StatelessWidget {
  const DynamicGroupItem({
    super.key,
    this.title,
    this.value,
    this.trailing,
    this.onTap,
    this.leading,
    this.onLongPress,
    this.contentPadding,
  });

  final Widget? title;
  final Widget? value;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsets? contentPadding;

  static DynamicGroupItem action({
    Widget? leading,
    Widget? trailing,
    required String title,
    Color? titleColor,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    final context = rootKey.currentContext!;
    final theme = Theme.of(context);

    return DynamicGroupItem(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      title: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(color: titleColor),
      ),
      trailing: trailing,
    );
  }

  static DynamicGroupItem field({
    Widget? leading,
    Widget? trailing,
    required String title,
    Widget? value,
    Color? titleColor,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    EdgeInsets? padding,
  }) {
    final context = rootKey.currentContext!;
    final theme = Theme.of(context);

    return DynamicGroupItem(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      trailing: trailing,
      value: value,
      title: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: titleColor ?? theme.colorScheme.primary,
        ),
      ),
    );
  }

  static DynamicGroupItem widget({
    required Widget? value,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    EdgeInsets? contentPadding,
  }) {
    return DynamicGroupItem(
      onTap: onTap,
      onLongPress: onLongPress,
      value: value,
      contentPadding: contentPadding,
    );
  }

  static DynamicGroupItem text({
    Widget? leading,
    Widget? trailing,
    required String title,
    required String value,
    Color? titleColor,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
  }) {
    final context = rootKey.currentContext!;
    final theme = Theme.of(context);

    return DynamicGroupItem(
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      title: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500,
          color: titleColor ?? theme.colorScheme.primary,
        ),
      ),
      trailing: trailing,
      value: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 2.0),
        child: Text(value, style: theme.textTheme.bodyMedium),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return ListTile(
      contentPadding: contentPadding,
      onTap: onTap,
      onLongPress: onLongPress,
      leading: leading,
      title: title,
      subtitle: value,
      trailing: trailing,
    );
  }
}
