import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/sliver_table_view.dart';
import 'package:responsive_builder/responsive_builder.dart'
    show getValueForScreenType;

///
import 'package:{{packageName.snakeCase()}}/src/core/models/dynamic_table_base_column.dart'
    show DynamicTableBaseColumn;
export 'package:{{packageName.snakeCase()}}/src/core/models/dynamic_table_base_column.dart'
    show DynamicTableBaseColumn;
import 'package:{{packageName.snakeCase()}}/src/core/controllers/table_controller.dart';

class SliverDynamicTableBase extends HookConsumerWidget {
  final int itemCount;
  final List<DynamicTableBaseColumn> columns;
  final double tableRowHeight;
  final Widget? Function(BuildContext context, _DynamicTableBuilderValue value)
  tableRowBuilder;
  final Widget Function(BuildContext context, _DynamicTableBuilderValue value)
  mobileBuilder;
  final String tableKey;
  final Function(int index)? onTableRowTap;
  final bool showCheckbox;

  const SliverDynamicTableBase({
    super.key,
    this.showCheckbox = true,
    required this.itemCount,
    required this.columns,
    required this.tableRowHeight,
    required this.tableRowBuilder,
    required this.mobileBuilder,
    required this.tableKey,
    this.onTableRowTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = tableControllerProvider(tableKey);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final selectedRows = state.selected;

    final isMobile = getValueForScreenType(
      context: context,
      mobile: true,
      desktop: false,
      tablet: false,
      watch: true,
    );

    final tableColumns = [
      if (showCheckbox)
        DynamicTableBaseColumn.sticky(
          width: 60,
          freezePriority: 1,
          builder: (context, index) => Checkbox(
            tristate: true,
            value: selectedRows.isNotEmpty
                ? selectedRows.length == itemCount
                      ? true
                      : null
                : false,
            onChanged: (x) {
              if (x == true) {
                notifier.selectAll();
              } else {
                notifier.clearSelection();
              }
            },
          ),
        ),
      ...columns,
    ];

    if (isMobile) {
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return mobileBuilder(
            context,
            _DynamicTableBuilderValue(
              row: index,
              column: 0,
              isSelected: selectedRows.contains(index),
            ),
          );
        }, childCount: itemCount),
      );
    }

    final columnWidths = useState<List<double>>(
      tableColumns.map((e) => e.width ?? e.minResizeWidth ?? 100.0).toList(),
    );
    final resizingColumn = useState<int?>(null);

    return SliverTableView.builder(
      headerBuilder: (context, contentBuilder) {
        return contentBuilder(
          context,
          (context, index) => tableColumns[index].builder(context, index),
        );
      },
      columns: tableColumns
          .mapWithIndex(
            (col, i) => TableColumn(
              width: columnWidths.value[i],
              flex: col.flex,
              maxResizeWidth: col.maxResizeWidth,
              minResizeWidth: col.minResizeWidth,
              freezePriority: col.freezePriority,
              translation: col.translation,
              sticky: col.sticky,
            ),
          )
          .toList(),
      rowCount: itemCount,
      rowHeight: tableRowHeight,
      rowBuilder: (context, row, contentBuilder) {
        return InkWell(
          onTap: () => onTableRowTap?.call(row),
          child: contentBuilder(context, (context, column) {
            final item = tableColumns[column];

            return Row(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (column == 0 && showCheckbox) {
                        return Checkbox(
                          value: selectedRows.contains(row),
                          onChanged: (_) => notifier.toggleRow(row),
                        );
                      }

                      final widget = tableRowBuilder(
                        context,
                        _DynamicTableBuilderValue(
                          row: row,
                          column: column,
                          isSelected: selectedRows.contains(row),
                        ),
                      );

                      return widget ?? const SizedBox();
                    },
                  ),
                ),
                if (column < columnWidths.value.length && item.width == null)
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onHorizontalDragStart: (_) {
                      resizingColumn.value = column;
                    },
                    onHorizontalDragUpdate: (details) {
                      final updated = [...columnWidths.value];
                      updated[column] = (updated[column] + details.delta.dx)
                          .clamp(
                            item.minResizeWidth ?? 100.0,
                            item.maxResizeWidth ?? 400.0,
                          ); // Prevent too small or large
                      columnWidths.value = updated;
                    },
                    onHorizontalDragEnd: (_) {
                      resizingColumn.value = null;
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.resizeColumn,
                      child: VerticalDivider(thickness: 1, width: 5),
                    ),
                  ),

                if (item.width != null) VerticalDivider(thickness: 1, width: 5),
              ],
            );
          }),
        );
      },
    );
  }
}

class _DynamicTableBuilderValue {
  final int row;
  final int column;
  final bool isSelected;

  _DynamicTableBuilderValue({
    required this.row,
    required this.column,
    this.isSelected = false,
  });
}
