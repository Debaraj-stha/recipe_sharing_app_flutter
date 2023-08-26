import 'package:flutter/material.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';

Future buttomSheet(BuildContext context) {
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
                child: Options(Icons.bookmark, "Save this content"),
                onTap: () {},
              ),
              InkWell(
                child: Options(Icons.block_sharp,
                    "Stop receiving content from this creater"),
                onTap: () {},
              ),
              InkWell(
                child: Options(Icons.report, "Report this content"),
                onTap: () {},
              )
            ],
          ),
        );
      });
}

Widget Options(IconData icon, String option) {
  return Row(
    children: [
      Icon(
        icon,
        size: 40,
      ),
      mediumtext(
        text: option,
        size: 18,
      ),
    ],
  );
}
