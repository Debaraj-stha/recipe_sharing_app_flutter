import 'package:flutter/material.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/model/model.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';

Future buttomSheet(BuildContext context, int pk) {
  final p = Provider.of<myProvider>(context, listen: false);

  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 150,
          width: constraints().getDeviceWidth(context),
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              InkWell(
                child:
                    Options(Icons.bookmark, "Save this content", Colors.indigo),
                onTap: () {
                  p.saveRecipe(pk);
                },
              ),
              InkWell(
                child: Options(Icons.block_sharp,
                    "Stop receiving content from this creater", Colors.red),
                onTap: () {},
              ),
              InkWell(
                child: Options(
                    Icons.report, "Report this content", Colors.redAccent),
                onTap: () {},
              )
            ],
          ),
        );
      });
}

Widget Options(IconData icon, String option, Color color) {
  return Row(
    children: [
      Icon(
        icon,
        size: 40,
        color: color,
      ),
      mediumtext(
        text: option,
        size: 18,
      ),
    ],
  );
}
