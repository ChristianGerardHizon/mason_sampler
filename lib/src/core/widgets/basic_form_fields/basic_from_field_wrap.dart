import 'package:flutter/material.dart';

class ResponsiveBreakpoint {
  final double minWidth;
  final int columns;

  const ResponsiveBreakpoint({required this.minWidth, required this.columns});
}

class BasicFormFieldWrap extends StatelessWidget {
  final List<Widget> children;
  final List<ResponsiveBreakpoint> breakpoints;
  final double spacing;
  final double runSpacing;

  const BasicFormFieldWrap({
    super.key,
    required this.children,
    required this.breakpoints,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
  });

  int _getColumnsForWidth(double width) {
    final sorted = [...breakpoints]
      ..sort((a, b) => a.minWidth.compareTo(b.minWidth));
    int columns = 1;

    for (final bp in sorted) {
      if (width >= bp.minWidth) {
        columns = bp.columns;
      } else {
        break;
      }
    }

    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final columns = _getColumnsForWidth(screenWidth);
        final itemWidth = (screenWidth - (columns - 1) * spacing) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }
}
