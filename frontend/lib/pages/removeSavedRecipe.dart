import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
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
  late AnimationController _controller;
  late Animation<double> _opacity;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 2), // Change duration to milliseconds
    );
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Change curve as needed
    ));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 0) {
        _controller.forward();
      }
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
            controller: _scrollController,
            child: Container(
              padding: EdgeInsets.all(8),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // Use the opacity animation for each list item
                      return FadeTransition(
                        opacity: _opacity,
                        child: buildRecipeList(
                          value.getSelectedRecipeForDelete(index.toString()),
                          index,
                          "List item ${index} Consectetur do dolore cupidatat i. ",
                          "",
                        ),
                      );
                    },
                    itemCount: 15,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRecipeList(
      bool isChheckd, int index, String recipeName, String image) {
    final p = Provider.of<myProvider>(context, listen: false);
    return InkWell(
      onTap: () {
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
                child: smalltext(
              text: recipeName,
              color: Colors.black,
              family: "Lato",
              weight: FontWeight.bold,
            ))
          ],
        ),
      ),
    );
  }
}
