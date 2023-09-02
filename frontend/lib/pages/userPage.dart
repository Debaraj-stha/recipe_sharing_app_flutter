import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/buildPopUpMenu.dart';
import 'package:frontend/utils/homepageContent.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/userPageHeader.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';

class userPage extends StatefulWidget {
  const userPage({super.key});

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constraints.colorWhite,
        leading: BackButton(
          color: constraints.colorBlack,
          onPressed: () {
            Navigator.pop(context);
            p.handleisBack();
             debugPrint(p.isUserBack.toString());
          },
         
        ),
        title: mediumtext(text: "Jeevan Shrestha Profile",family: "NotoSerif",),
        actions: [
          buildPopUpMenu(context)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [userPageHeader(), homePageContent()],
        ),
      ),
    );
  }
}
