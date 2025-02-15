import 'package:flutter/material.dart';
import 'package:katkoot_elwady/features/tools_management/widgets/production_base_table_row_item.dart';

class ProductionResultsTableRowItem extends StatelessWidget {
 final  String? title , value;
  const ProductionResultsTableRowItem({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ProductionBaseTableRowItem(title: title,value: value,),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: ProductionBaseTableRowItem(title: title,value: value,),
          ),
        ],
    );
  }
}
