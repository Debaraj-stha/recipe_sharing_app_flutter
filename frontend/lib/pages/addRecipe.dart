import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/appBar.dart';
import 'package:frontend/utils/buildImagePicker.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';

class addRecipePage extends StatefulWidget {
  const addRecipePage({super.key});

  @override
  State<addRecipePage> createState() => _addRecipePageState();
}

class _addRecipePageState extends State<addRecipePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final provider = Provider.of<myProvider>(context, listen: false);
    return Scaffold(
        appBar: CustomAppBar(title: "Create New Recipe"),
        body: ListView(children: [
          buildInputField(2, "Title of Recipe", provider.titlecontroller,
              provider.titlenode, ""),
          buildInputField(6, "Description", provider.descriptionController,
              provider.descriptionNode, "add short description of the recipe"),
          buildInputField(
              6,
              "Steps",
              provider.stepsController,
              provider.stepsNode,
              "Add steps of making this recipe.Each sentence represents a step"),
          buildInputField(
              6,
              "Ingredients",
              provider.ingredientsController,
              provider.ingredientsNode,
              "add list of ingredients of the recipe.Comma seperated list represent an ingredients"),
          buildInputField(
              3,
              "Hastag",
              provider.hastagController,
              provider.hastagnode,
              "whitespace seperated list represent a hastag  "),
          Consumer<myProvider>(builder: (context, value, child) {
            if (value.image.isEmpty) {
              return Column(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: smalltext(text: "Add images")),
                  buildImagePicker(
                      "Browse from Gallery", constraints.primaryColor, 1,context,),
                  buildImagePicker(
                      "Take from Camera", constraints.secondaryColor, 2,context),
                ],
              );
            } else {
              return ShrinkWrappingViewport(
                offset: ViewportOffset.zero(),
                slivers: <Widget>[
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 3,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final image = value.imageFile![index];
                        return InkWell(
                          onTap: () {
                            provider.deleteSelectedImage(index);
                          },
                          child: Container(
                            child: Image.file(
                              File(image.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      childCount: value.imageFile!.length,
                    ),
                  ),
                ],
              );
            }
          }),
          Consumer<myProvider>(builder: (context, value, child) {
            if (value.hasimages) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    smalltext(text: "Selected images"),
                    smalltext(text: "click on image for removing image"),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
          TextButton(
              // style: ElevatedButton.styleFrom(
              //   primary: constraints.primaryColor
              // ),
              onPressed: () {
            provider.postRecipe(context);
          }, child: Consumer<myProvider>(
            builder: (context, value, child) {
              return value.progress == 0
                  ? smalltext(
                      text: "POST",
                      weight: FontWeight.bold,
                      color: constraints.colorBlack,
                    )
                  : LinearProgressIndicator(
                      value: value.progress.toDouble(),
                      minHeight: 10,
                      color: Colors.grey,
                      valueColor: _controller.drive(ColorTween(
                        begin: Colors.green, // Starting color
                        end: Colors.blue, // Ending color
                      )),
                    );
            },
          ))
        ]));
  }

  

  Widget buildInputField(int lines, String field,
      TextEditingController controller, FocusNode node, String helperText) {
    final provider = Provider.of<myProvider>(context, listen: false);
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(color: constraints.primaryColor),
      //   borderRadius: BorderRadius.circular(10)
      // ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: TextFormField(
        controller: controller,
        focusNode: node,
        maxLines: lines,
        onFieldSubmitted: (value) {
          provider.clearCreateRecipieField();
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(8),
            hintText: field,
            helperText: helperText),
      ),
    );
  }
}
