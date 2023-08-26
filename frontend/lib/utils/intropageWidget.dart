import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/signupPage.dart';

import 'bigtext.dart';
import 'mediumtext.dart';

class introPageWidget extends StatelessWidget {
  const introPageWidget(
      {super.key,
      required this.title,
      required this.message,
      this.secondmessage = "",
      this.issignUp = false,
      required this.image});
  final String title;
  final String message;
  final String secondmessage;
  final String image;
  final bool issignUp;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: bigtext(text: title),
        ),
        mediumtext(text: secondmessage),
        issignUp
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextButton(
                  style: ElevatedButton.styleFrom(primary: constraints.primaryColor),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (contex)=>signupPage()));
                  },
                  child: mediumtext(
                    text: message,
                    color: constraints.colorWhite,
                  ),
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: mediumtext(
                  text: message,
                  size: 18,
                ),
              ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
