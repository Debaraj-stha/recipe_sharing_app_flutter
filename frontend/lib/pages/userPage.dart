import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/homepageContent.dart';
import 'package:frontend/utils/userPageHeader.dart';

class userPage extends StatefulWidget {
  const userPage({super.key});

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: constraints.colorBlack,),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              userPageHeader(),
              homePageContent()
            ],
        ),
      ),
    );
  }
}