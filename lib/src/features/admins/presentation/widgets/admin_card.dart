
import 'package:flutter/material.dart';
import 'package:mason_sampler/src/core/widgets/selectable_card.dart';
import 'package:mason_sampler/src/features/admins/domain/admin.dart';

class AdminCard extends StatelessWidget {
  const AdminCard({
    super.key,
    required this.admin,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final Admin admin;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
          leading: Icon(Icons.home),
          title: Text(admin.id),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(admin.id),
            ],
          )),
    );
  }
}
