import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';

import 'package:frontend/utils/simmerEffect.dart';
import 'package:frontend/utils/singleRecipeContent.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:frontend/utils/toastmessage.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'demo.dart';

class homePageContent extends StatefulWidget {
  const homePageContent({super.key});

  @override
  State<homePageContent> createState() => _homePageContentState();
}

class _homePageContentState extends State<homePageContent> {
  RefreshController refreshController = new RefreshController();
  @override
  void dispose() {
    // TODO: implement dispose
    refreshController.dispose();
    super.dispose();
  }

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
        if (value.isUserBack) {
          if (value.specificUserRecipe.isEmpty) {
            return Container(
              child: Center(
                child: smalltext(text: "Nothing to show"),
              ),
            );
          } else {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.specificUserRecipe.length,
              itemBuilder: (context, index) {
                final data = value.specificUserRecipe[index]; // Remove [0] here

                return demo(
                    data: data, currentImagePage: value.currentImagePage);
                //  singleRecipeContent(
                //     data: data, currentImagePage: value.currentImagePage);
              },
            );
          }
        } else {
          return SmartRefresher(
            controller: refreshController,
            enablePullDown: true, // Enable pull-to-refresh
            enablePullUp: true, // Enable pull-up to load more
            enableTwoLevel: true,
            onRefresh: () async {
              await p.handleRefresh(RefreshStatus, refreshController);
              refreshController.refreshCompleted(); // Complete the refresh
            },
            onLoading: () async {
              await p.handleLoading(LoadStatus, refreshController);
            },
            child: SingleChildScrollView(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: value.items.length,
                itemBuilder: (context, index) {
                  final data = value.items[index]; // Remove [0] here

                  return demo(
                      data: data, currentImagePage: value.currentImagePage);
                  //  singleRecipeContent(
                  //     data: data, currentImagePage: value.currentImagePage);
                },
              ),
            ),
          );
        }
      },
    );
  }
}
