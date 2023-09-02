import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/userPage.dart';
import 'package:frontend/utils/videoplayer.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';
import '../utils/bottomSheet.dart';
import '../utils/mediumtext.dart';
import '../utils/reactorList.dart';
import '../utils/smalltext.dart';
import 'commentPage.dart';

class singleRecipePage extends StatefulWidget {
  const singleRecipePage({
    super.key,
    required this.data,
  });
  final data;

  @override
  State<singleRecipePage> createState() => _singleRecipePageState();
}

class _singleRecipePageState extends State<singleRecipePage>with TickerProviderStateMixin {
  final String video = "https://download.samplelib.com/mp4/sample-5s.mp4";
  int userId=2;
  late AnimationController animationController,controller;
  @override
  void initState() {
    // TODO: implement initState
 animationController=AnimationController(vsync: this,duration: Duration(microseconds: 300));
 controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    p.initialize();
    return Scaffold(
      body: Consumer<myProvider>(builder: (context, value, child) {
// Remove [0] here
        return ListView(children: [
          widget.data.isShare == true
              ? Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: () {
                          debugPrint("onTap");

                          if (p.specificUserRecipe.isEmpty) {
                            p.getSpecificuserRecipe(
                                userId.toString());
                            debugPrint("getSpecificuserRecipe");
                          }
                          p.handleisBack();
                          debugPrint(p.isUserBack.toString());

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const userPage()));
                        },
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align text to the top
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              child: ClipOval(
                                child: Image(
                                  image:
                                      AssetImage("asset/images/discover.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Roboto",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: widget.data.user.name,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        TextSpan(
                                          text:
                                              " shared a ${widget.data.owner.name} new Recipe",
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          4), // Add spacing between RichText and smalltext
                                  smalltext(
                                    text: DateFormat('yyyy-MM-dd HH:mm')
                                        .format(widget.data.addedAt),
                                    // family: "Righteous",
                                  ),
                                ],
                              ),
                            ),
                            widget.data.isShare
                                ? IconButton(
                                    onPressed: () {
                                      buttomSheet(context, widget.data.pk);
                                    },
                                    icon: Icon(
                                      Icons.more_horiz,
                                      color: constraints.colorBlack,
                                    ),
                                  )
                                : Container(),
                          ],
                        )),
                  ),
                )
              : Container(),
          widget.data.shareTitle != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: smalltext(
                    text: widget.data.shareTitle,
                    weight: FontWeight.w500,
                  ),
                )
              : Container(),
          Divider(
            thickness: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                debugPrint("onTap");
              },
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage("asset/images/discover.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Roboto",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: widget.data.isShare
                                      ? widget.data.owner.name
                                      : widget.data.user.name,
                                  style: TextStyle(fontSize: 18)),
                              TextSpan(
                                text: " added a new hhhhh Recipe",
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          // overflow: TextOverflow.ellipsis,
                          // maxLines: 1,
                        ),
                        smalltext(
                          text: DateFormat('yyyy-MM-dd HH:mm')
                              .format(widget.data.addedAt),
                          weight: FontWeight.w500,
                          // family: "Righteous",
                        ),
                      ],
                    ),
                  ),
                  widget.data.isShare == false
                      ? IconButton(
                          onPressed: () {
                            buttomSheet(context, widget.data.pk);
                          },
                          icon: Icon(
                            Icons.more_horiz,
                            color: constraints.colorBlack,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: mediumtext(text: widget.data.title),
          ),
          Container(
            height: constraints().getDeviceHeight(context) / 1.2,
            child: PageView.builder(
              controller: p.singleRecipePageController,
              onPageChanged: (value) {
                p.handleCurrentSingleRecipe(
                    value); // Use 'value' instead of 'index'
              },
              itemCount: widget.data.image.length,
              itemBuilder: (context, i) {
                debugPrint(widget.data.image[i]);
                // Change 'index' to 'i'
                final image = widget.data.image[i]; // Change 'index' to 'i'
                if (p.checkIsVideo(image)) {
                  return videoplayer(url: image);
                } else {
                  return Stack(
                    children: [
                      Container(
                        height: constraints().getDeviceHeight(context) / 1.2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("asset/" + image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                         Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 110,
                            child: InkWell(
                              onTap: () {
                                debugPrint(widget.data.pk.toString());
                                p.likeRecipie(widget.data.pk.toString(),
                                    userId.toString(), animationController,
                                    isShare: widget.data.isShare);
                              },
                              child: Lottie.asset(
                                "asset/lottie/heart.json",
                                alignment: Alignment.bottomCenter,
                                height: 110,
                                controller: animationController,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showReactorList(
                                  context, controller, widget.data.reaction);
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(seconds: 1),
                              child: smalltext(
                                key: ValueKey(widget.data.totalReact),
                                text: widget.data.totalReact.toString(),
                                color: constraints.colorWhite,
                                weight: FontWeight.w700,
                              ),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              p.shareRecipe(
                                  widget.data.pk.toString(), 1.toString());
                            },
                            child: Icon(
                              Icons.share_outlined,
                              color: constraints.colorWhite,
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 10),
                          smalltext(
                            text: p
                                .getShareReactionCount(
                                    widget.data.pk.toString())
                                .toString(),
                            color: constraints.colorWhite,
                            weight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                              onTap: () {
                                p.loadComments(widget.data.pk);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            commentPage(pk: widget.data.pk)));
                              },
                              child: Icon(
                                Icons.comment,
                                color: constraints.colorWhite,
                                size: 30,
                              )),
                          smalltext(
                            text: widget.data.totalComment.toString(),
                            color: constraints.colorWhite,
                            weight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                    ],
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageViewDotIndicator(
                currentItem: value.currentSingleRecipe,
                count: widget.data.image.length,
                unselectedColor: constraints.colorBlack,
                selectedColor: constraints.colorGrey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: List.generate(widget.data.hashtags.length, (index) {
                return InkWell(
                    onTap: () {},
                    child: smalltext(
                      text: widget.data.hashtags[index],
                      color: constraints.primaryColor,
                      weight: FontWeight.bold,
                    ));
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: smalltext(
              text: "Ingredients",
              weight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.data.ingredients.length,
            itemBuilder: (context, index) {
              final item = widget.data.ingredients[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: smalltext(
                  text: "${index + 1}. $item",
                  weight: FontWeight.w500,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: smalltext(
              text: "Steps",
              weight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            padding: EdgeInsets.all(8.0),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.data.steps.length,
            itemBuilder: (context, index) {
              final item = widget.data.steps[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: smalltext(
                  text: "${index + 1}. $item",
                  weight: FontWeight.w500,
                ),
              );
            },
          ),
          widget.data.description!=null?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: smalltext(
              text: widget.data.description,
              weight: FontWeight.w500,
            ),
          ):Container(),
        ]);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios),
        backgroundColor: constraints.primaryColor,
      ),
    );
  }
}
