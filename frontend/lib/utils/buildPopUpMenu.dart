import 'package:flutter/material.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';

Widget buildPopUpMenu(BuildContext context){
     final provider= Provider.of<myProvider>(context, listen: false);
  return PopupMenuButton<int>(
            
            surfaceTintColor: constraints.colorBlack,
            icon: Icon(
              Icons.more_vert,
              color: constraints.colorBlack,
            ),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            enableFeedback: true,
            onSelected: (int value) {
              provider.handleupopUpButton(value,context);
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: smalltext(text: "Home"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: smalltext(text: "Search"),
                    value: 3,
                  ),
                  PopupMenuItem(
                    child: smalltext(text: "Discover"),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: smalltext(text: "Account"),
                    value: 4,
                  ),
                  PopupMenuItem(
                    child: smalltext(text: "About Us"),
                    value: 5,
                  ),
                  PopupMenuItem(
                    child: smalltext(text: "Feedback"),
                    value: 6,
                  ),
                ]);
}