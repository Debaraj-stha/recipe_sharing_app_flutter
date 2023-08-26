import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/appBar.dart';

import '../utils/mediumtext.dart';

class verificationPage extends StatefulWidget {
  const verificationPage({super.key});

  @override
  State<verificationPage> createState() => _verificationPageState();
}

class _verificationPageState extends State<verificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "Verification Page"),
        body: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: constraints.primaryColor, width: 2)),
              child: TextFormField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintText: "Enter otp here...",
                    hintStyle: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: constraints.primaryColor),
                onPressed: () {
                  //  if (p.loginformKey.currentState!.validate()) {
                  //  p.login();
                  // } 
                },
                child: mediumtext(
                  text: "Login",
                  family: "LobsterTwo ",
                  color: constraints.colorWhite,
                )),
        ]));
  }
}
