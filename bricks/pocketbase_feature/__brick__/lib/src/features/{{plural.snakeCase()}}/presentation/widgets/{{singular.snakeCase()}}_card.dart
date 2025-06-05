
import 'package:flutter/material.dart';
import 'package:{{packageName.snakeCase()}}/src/core/widgets/selectable_card.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';

class {{singular.pascalCase()}}Card extends StatelessWidget {
  const {{singular.pascalCase()}}Card({
    super.key,
    required this.{{singular.snakeCase()}},
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final {{singular.pascalCase()}} {{singular.snakeCase()}};

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
          leading: Icon(Icons.home),
          title: Text({{singular.snakeCase()}}.id),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text({{singular.snakeCase()}}.id),
            ],
          )),
    );
  }
}
