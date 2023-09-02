import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/changeAppTheme.dart';
import 'package:frontend/pages/deleteAccountPage.dart';
import 'package:frontend/pages/editDetailsPage.dart';
import 'package:frontend/pages/myRecipe.dart';
import 'package:frontend/pages/removeSavedRecipe.dart';
import 'package:frontend/pages/savedRecipePage.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/appBar.dart';
import 'package:frontend/utils/buildImagePicker.dart';
import 'package:frontend/utils/followerPage.dart';
import 'package:frontend/utils/followingPage.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class accountPage extends StatefulWidget {
  const accountPage({super.key});

  @override
  State<accountPage> createState() => _accountPageState();
}

class _accountPageState extends State<accountPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void demo(MaterialPageRoute route) {
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
        final provider = Provider.of<myProvider>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppBar(title: "Account"),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Consumer<myProvider>(builder: (context, value, child) {
            return Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: constraints.secondaryColor,
                        backgroundImage: value.profile != null
                            ? FileImage(File(value.profile!.path))
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0, // Adjust the positioning as needed
                      right: 0, // Adjust the positioning as needed
                      child: InkWell(
                        onTap: () {
                          showButtonSheet(context);
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: constraints.colorGrey,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smalltext(
                      text: "Mina Ghimire",
                      weight: FontWeight.bold,
                      family: "Lato",
                    ),
                    smalltext(
                      text: "deepaghimire@gmail.com",
                      family: "Lato",
                      weight: FontWeight.bold,
                    ),
                    value.profile!=null?
                    InkWell(
                      child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        decoration: BoxDecoration(
                          color: constraints.primaryColor,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: smalltext(text: "Update",color: constraints.colorWhite,)),
                      onTap: () {
                        provider.changeProfile(20);
                      },
                    ):Container()
                  ],
                ),
              ],
            );
          }),
          ExpansionTile(
            // iconColor: constraints.primaryColor,
            // collapsedIconColor: constraints.primaryColor,
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.account_circle),
            title: smalltext(text: "Account Settings", weight: FontWeight.bold,family:"Lato"),
            children: [
              // buildList(Icons.key, "Change Profile Picture", demo),
              buildList(Icons.edit, "Edit your details", demo,MaterialPageRoute(builder: (context)=>editDetailsPAge()))
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.manage_accounts),
            title:
                smalltext(text: "Recipe Management", weight: FontWeight.bold,family:"Lato"),
            children: [
              buildList(Icons.list, "Your recipe", demo,MaterialPageRoute(builder: (context)=>myRecipe())),
              // buildList(Icons.edit_attributes, "Edit your recipe", demo)
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.bookmark_added),
            title: smalltext(text: "Saved Recipe", weight: FontWeight.bold,family:"Lato"),
            children: [
              buildList(Icons.bookmark_add, "Saved recipes", demo,MaterialPageRoute(builder: (context)=>savedRecipePAge())),
              buildList(Icons.delete_forever, "Remove save recipe", demo,MaterialPageRoute(builder: (context)=>RemoveSavedRecipe()))
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.people),
            title: smalltext(
                text: "Followers and Followings", weight: FontWeight.bold,family: "Lato",),
            children: [
              buildList(Icons.person_add, "Follower", demo,MaterialPageRoute(builder: (context)=>followerPage())),
              buildList(Icons.people, "Following", demo,MaterialPageRoute(builder: (context)=>followingPage()))
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.delete_forever_outlined),
            title: smalltext(text: "Account Deletion", weight: FontWeight.bold,family:"Lato"),
            children: [
              buildList(Icons.person_add, "Delete this account", demo,MaterialPageRoute(builder: (context)=>DelteteAccount())),
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.settings),
            title: smalltext(text: "Settiongs", weight: FontWeight.bold,family:"Lato"),
            children: [
              buildList(Icons.palette, "Chnage app theme", demo,MaterialPageRoute(builder: (context)=>changeAppTheme())),
              // buildList(Icons.language, "Chnage Language", demo),
              // buildList(Icons.update, "Check for version and Updates", demo)
            ],
          ),
          InkWell(
            child: smalltext(
              color: constraints.primaryColor,
              weight: FontWeight.bold,
              text: "Log Out",family:"Lato",
            ),
          )
        ],
      ),
    );
  }

  Widget buildList(IconData icon, String title, Function function,MaterialPageRoute route) {
    return InkWell(
      onTap: (){
        demo(route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon),
            smalltext(
              text: title,
              weight: FontWeight.bold,
              family: "Lato",
            ),
          ],
        ),
      ),
    );
  }

  Future showButtonSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            width: constraints().getDeviceWidth(context),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildImagePicker("Pick From Gallery",
                      constraints.secondaryColor, 1, context,
                      isProfile: true),
                  buildImagePicker(
                      "Pick From Camera", constraints.primaryColor, 2, context,
                      isProfile: true)
                ],
              ),
            ),
          );
        });
  }
}
