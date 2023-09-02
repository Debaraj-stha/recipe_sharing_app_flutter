import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/buildPopUpMenu.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';

import '../utils/demo.dart';

class savedRecipePAge extends StatelessWidget {
  const savedRecipePAge({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constraints.colorWhite,
        title: smalltext(text:"Saved Recipe",family: "Lato",weight: FontWeight.w700,),
        leading: BackButton(color: constraints.colorBlack,),
        excludeHeaderSemantics: true,
        actions: [
          buildPopUpMenu(context)
        ],
      ),
      body:Consumer<myProvider>(builder: (context,value,chuild){
        return SingleChildScrollView(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.savedRecipe.length,
              itemBuilder: (context, index) {
                final data = value.savedRecipe[index]; // Remove [0] here
          
                return demo(data: data, currentImagePage: value.currentImagePage);
                //  singleRecipeContent(
                //     data: data, currentImagePage: value.currentImagePage);
              },
            ),
          );
      },)
    );
  }
}