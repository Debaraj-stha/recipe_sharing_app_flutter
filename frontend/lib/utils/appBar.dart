import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key, this.title = "", this.isShowSearchField = false})
      : super(key: key);
  final String title;
  final bool isShowSearchField;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<myProvider>(context, listen: false);
    return AppBar(
      leading: BackButton(
        color: constraints.colorBlack,
      ),
      elevation: 0,
      backgroundColor: constraints.colorWhite,
      title: title != ""
          ? mediumtext(
              text: title,
              weight: FontWeight.bold,
            )
          : Container(
              child: Card(
                shape: RoundedRectangleBorder(),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    provider.clearField();
                  },
                  onChanged: (value) {
                    provider.searchRecipe(value);
                  },
                  controller: provider.searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(),
                    hintText: "Search here..."
                  ),
                ),
              ),
            ),
      actions: [
        PopupMenuButton<int>(
            // color: constraints.colorBlack,
            surfaceTintColor: constraints.colorBlack,
            icon: Icon(
              Icons.more_vert,
              color: constraints.colorBlack,
            ),
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
            enableFeedback: true,
            onSelected: (int value) {
              provider.handleupopUpButton(value);
            },
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: smalltext(text: "Home"),
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: smalltext(text: "Search"),
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: smalltext(text: "Discover"),
                    value: 3,
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
                ])
      ],
    );
  }
}
