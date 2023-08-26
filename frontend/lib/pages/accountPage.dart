import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/appBar.dart';
import 'package:frontend/utils/smalltext.dart';

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

  void demo() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Account"),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: constraints.secondaryColor,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: constraints.colorBlack,
                    ),
                  ),
                  Positioned(
                    bottom: 0, // Adjust the positioning as needed
                    right: 0, // Adjust the positioning as needed
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
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  smalltext(
                    text: "Mina Ghimire",
                    weight: FontWeight.bold,
                  ),
                  smalltext(
                    text: "deepaghimire@gmail.com",
                    weight: FontWeight.bold,
                  )
                ],
              ),
            ],
          ),
          ExpansionTile(
            // iconColor: constraints.primaryColor,
            // collapsedIconColor: constraints.primaryColor,
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.account_circle),
            title: smalltext(text: "Account Settings",weight:FontWeight.bold),
            children: [
              buildList(Icons.key, "Change Profile Picture", demo),
              buildList(Icons.edit, "Edit your details", demo)
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.manage_accounts),
            title: smalltext(text: "Recipe Management",weight:FontWeight.bold),
            children: [
              buildList(Icons.list, "Your recipe", demo),
              buildList(Icons.edit_attributes, "Edit your recipe", demo)
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.bookmark_added),
            title: smalltext(text: "Saved Recipe",weight:FontWeight.bold),
            children: [
              buildList(Icons.bookmark_add, "Saved recipes", demo),
              buildList(Icons.delete_forever, "Remove save recipe", demo)
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.people),
            title: smalltext(text: "Followers and Followings",weight:FontWeight.bold),
            children: [
              buildList(Icons.person_add, "Follower", demo),
              buildList(Icons.people, "Following", demo)
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.delete_forever_outlined),
            title: smalltext(text: "Account Deletion",weight:FontWeight.bold),
            children: [
              buildList(Icons.person_add, "Delete this account", demo),
            ],
          ),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            leading: Icon(Icons.settings),
            title: smalltext(text: "Settiongs",weight:FontWeight.bold),
            children: [
              buildList(Icons.palette, "Chnage app theme", demo),
              buildList(Icons.language, "Chnage Language", demo),
              buildList(Icons.update, "Check for version and Updates", demo)
            ],
          ),
          InkWell(
            child: smalltext(
              color: constraints.primaryColor,
              weight: FontWeight.bold,
              text: "Log Out",
            ),
          )
        ],
      ),
    );
  }

  Widget buildList(IconData icon, String title, Function function) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Icon(icon), smalltext(text: title,weight: FontWeight.bold,),],
        ),
      ),
    );
  }
}
