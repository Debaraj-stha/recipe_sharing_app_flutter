import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/buildPopUpMenu.dart';
import 'package:provider/provider.dart';

import '../utils/followerPage.dart';
import '../utils/followingPage.dart';

class followerFollowuingPage extends StatefulWidget {
  const followerFollowuingPage({super.key});

  @override
  State<followerFollowuingPage> createState() => _followerFollowuingPageState();
}

class _followerFollowuingPageState extends State<followerFollowuingPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<myProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: constraints.colorBlack),
        backgroundColor: constraints.colorWhite,
        title: SearchBox(provider),
        elevation: 0,
        actions: [buildPopUpMenu(context)],
      ),
      body: GestureDetector(
          onTap: () {
            provider.focusNode.unfocus();
          },
          child: PageView(children: [followerPage(), followingPage()])),
    );
  }

  Widget SearchBox(myProvider provider) {
    return Container(
      child: Card(
        shadowColor: constraints.colorGrey,
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 1),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(8),
        child: TextFormField(
          onFieldSubmitted: (value) {
            provider.focusNode.unfocus();
            provider.textEditingController.clear();
          },
          style: TextStyle(fontFamily: "Righteous"),
          controller: provider.textEditingController,
          focusNode: provider.focusNode,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              border: InputBorder.none,
              hintText: "Search here...",
              hintStyle: TextStyle(fontFamily: "Righteous")),
        ),
      ),
    );
  }
}
