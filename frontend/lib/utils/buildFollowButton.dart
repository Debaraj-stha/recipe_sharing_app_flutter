import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/smalltext.dart';

import 'mediumtext.dart';

class buildFollowButton extends StatelessWidget {
  const buildFollowButton({super.key,this.text="follow", this.isBorder=false, this.textColor=Colors.white,this.bgColor=Colors.green,});
final String text;
final Color textColor;
final Color bgColor;
final bool isBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(8),
      decoration: !isBorder?BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: constraints.colorGrey,
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                offset: Offset(3, 3),
                color: constraints.colorGrey),
            BoxShadow(
                blurRadius: 5,
                offset: Offset(-3, 3),
                color: constraints.colorGrey)
          ]
          ):BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
          border: Border.all(width: 1,color: constraints.colorGrey)
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add_alt, color: textColor),
          SizedBox(
            width: 7,
          ),
          smalltext(text: text,color: textColor,weight: FontWeight.bold,family: "Lato",)
        ],
      ),
    );
  }
}
