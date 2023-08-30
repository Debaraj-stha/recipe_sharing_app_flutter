import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';

import 'package:frontend/utils/simmerEffect.dart';
import 'package:frontend/utils/singleRecipeContent.dart';
import 'package:frontend/utils/smalltext.dart';

import 'package:provider/provider.dart';

import 'demo.dart';

class homePageContent extends StatefulWidget {
  const homePageContent({super.key});

  @override
  State<homePageContent> createState() => _homePageContentState();
}

class _homePageContentState extends State<homePageContent> {
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    p.initialize();
    return Consumer<myProvider>(
      builder: (context, value, child) {
        if (value.items.isEmpty && value.isLoading) {
          return buildShimmer(context);
        } else if (value.items.length == 0) {
          return Container(
            child: Center(child: smalltext(text: "Nothing to display")),
          );
        }
        if(value.specificUser.isNotEmpty){
          return Container();
        }
        else{
        return ListView.builder(
         physics: NeverScrollableScrollPhysics(),
         shrinkWrap: true,
          itemCount: value.items.length,
          itemBuilder: (context, index) {
            final data = value.items[index]; // Remove [0] here

            return demo(data: data,currentImagePage: value.currentImagePage);
            //  singleRecipeContent(
            //     data: data, currentImagePage: value.currentImagePage);
          },
        );
        }
      },
    );
  }
}
