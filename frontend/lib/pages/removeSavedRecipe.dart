import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/singleRecipePage.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:provider/provider.dart';

import '../utils/buildPopUpMenu.dart';
import '../utils/smalltext.dart';

class RemoveSavedRecipe extends StatefulWidget {
  const RemoveSavedRecipe({super.key});

  @override
  State<RemoveSavedRecipe> createState() => _RemoveSavedRecipeState();
}

class _RemoveSavedRecipeState extends State<RemoveSavedRecipe>
    with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constraints.colorWhite,
        title: smalltext(
          text: "Delete saved Recipe",
          family: "Lato",
          weight: FontWeight.w700,
        ),
        leading: BackButton(
          color: constraints.colorBlack,
        ),
        excludeHeaderSemantics: true,
        actions: [
          Consumer<myProvider>(builder: (context, value, child) {
            bool isDeleteIconDisabled = value.selectedrecipeforDelete.isEmpty ||
                !value.selectedrecipeforDelete.containsValue(true);
            return isDeleteIconDisabled
                ? Container(
                    decoration: BoxDecoration(),
                    child: Icon(
                      Icons.delete,
                      color: constraints.colorLightGrey,
                    ),
                  )
                : InkWell(
                    splashColor: constraints.colorWhite,
                    highlightColor: constraints.colorWhite,
                    onTap: () {},
                    child: Container(
                        child: Icon(
                      Icons.delete,
                      color: isDeleteIconDisabled
                          ? constraints.colorLightGrey
                          : constraints.primaryColor,
                    )),
                  );
          }),
          buildPopUpMenu(context)
        ],
      ),
      body: Consumer<myProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = value.items[index];
                  var description = data.description;
                  String check() {
                    if (data.description != null) {
                      if (data.description!.length > 50) {
                        return data.description!.substring(0, 50)+"...";
                      } else {
                        return data.description!;
                      }
                    }
                    else return "";
                  }

                  return buildRecipeList(
                      value.getSelectedRecipeForDelete(data.pk.toString()),
                      data.pk,
                      data.title ?? "",
                      data.image!.first,
                      check(),
                      data
                      );
                },
                itemCount: value.items.length,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRecipeList(bool isChheckd, int index, String recipeName,
      String image, String description,data) {
    final p = Provider.of<myProvider>(context, listen: false);
    return InkWell(
      onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>singleRecipePage(data:data)));

      },
      onLongPress: () {
        p.handleSelectedRecipe(index.toString(), isChheckd);
      },
      child: Container(
        height: 100,
        child: Row(
          children: [
            Checkbox(
                value: isChheckd,
                onChanged: (value) {
                  p.handleSelectedRecipe(index.toString(), isChheckd);
                }),
            Container(
              height: 80,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/images/discover.png"))),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                smalltext(
                  text: recipeName,
                  color: Colors.black,
                  family: "Lato",
                  weight: FontWeight.bold,
                ),
                smalltext(
                  text: description,
                  color: Colors.black,
                  family: "Lato",
                  weight: FontWeight.bold,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
