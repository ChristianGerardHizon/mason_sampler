
import 'package:flutter/material.dart';
import 'package:mason_sampler/src/core/widgets/selectable_card.dart';
import 'package:mason_sampler/src/features/sales_transactions/domain/sales_transaction.dart';

class SalesTransactionCard extends StatelessWidget {
  const SalesTransactionCard({
    super.key,
    required this.sales_transaction,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final SalesTransaction sales_transaction;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
          leading: Icon(Icons.home),
          title: Text(sales_transaction.id),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sales_transaction.id),
            ],
          )),
    );
  }
}
