import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';

class dropDownButton extends StatefulWidget {
  const dropDownButton({super.key,required this.type});
final String type;
  @override
  State<dropDownButton> createState() => _dropDownButtonState();
}

class _dropDownButtonState extends State<dropDownButton> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);

    return Consumer<myProvider>(builder: (context, value, child) {
      return DropdownButton<int>(
        value: value.sortByAlphaValue,
        icon: Icon(Icons.sort_by_alpha),
        style: TextStyle(color: constraints.colorBlack),
        underline: Container(
          height: 2,
          color: constraints.colorBlack,
        ),
        onChanged: (value) {
          p.handleSortValue(value!,widget.type);
        },
        items: [
          DropdownMenuItem(child: Text("Asc"), value: 1),
          DropdownMenuItem(child: Text("Desc"), value: 2),
        ],
      );
    });
  }
}
