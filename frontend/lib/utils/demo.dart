import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/userPage.dart';

import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/reactorList.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';
import 'package:frontend/pages/commentPage.dart';
import '../pages/singleRecipePage.dart';
import '../provider/myProvider.dart';
import 'bottomSheet.dart';

class demo extends StatefulWidget {
  const demo({super.key, required this.data, required this.currentImagePage});
  final data;
  final int currentImagePage;
  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> with TickerProviderStateMixin {
  late AnimationController animationController, controller;
  int userId = 2;
  @override
  void initState() {
    // TODO: implement initState
    final p = Provider.of<myProvider>(context, listen: false);
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controller.forward();
    // final isReact=p.isAlreadyReact(widget.userId, widget.data.pk);
    // if(isReact){
    //   animationController.forward();
    // }
    // else{
    //   animationController.reverse();
    // }
    p.initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    animationController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => singleRecipePage(
                        user: widget.data.user,
                        description: widget.data.description,
                        addedAt: widget.data.addedAt.toIso8601String(),
                        hastag: widget.data.hashtags,
                        title: widget.data.title,
                        ingredients: widget.data.ingredients,
                        steps: widget.data.steps,
                        media: widget.data.image)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.data.isShare
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            debugPrint("onTap");
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>userPage()));
                          },
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
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
                              SizedBox(width: 5,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  smalltext(
                                      text: widget.data.user.name + " Share",
                                      weight: FontWeight.bold),
                                  smalltext(
                                      text:
                                          "${widget.data.owner.name} recipe"),
                                  smalltext(
                                    text: DateFormat('yyyy-MM-dd HH:mm')
                                        .format(widget.data.addedAt),
                                  )
                                ],
                              ),
                              Spacer(),
                              widget.data.isShare
                                  ? IconButton(
                                      onPressed: () {
                                        buttomSheet(context);
                                      },
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: constraints.colorBlack,
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              widget.data.shareTitle != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: mediumtext(text: widget.data.shareTitle),
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
                    // crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smalltext(
                              text: widget.data.isShare
                                  ? widget.data.owner.name
                                  : widget.data.user.name,
                              weight: FontWeight.bold),
                          smalltext(
                            text: DateFormat('yyyy-MM-dd HH:mm')
                                .format(widget.data.addedAt),
                          )
                        ],
                      ),
                      Spacer(),
                      widget.data.isShare == false
                          ? IconButton(
                              onPressed: () {
                                buttomSheet(context);
                              },
                              icon: Icon(
                                Icons.more_horiz,
                                color: constraints.colorBlack,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: mediumtext(text: widget.data.title),
              ),
              Stack(
                children: [
                  Container(
                    height: constraints().getDeviceHeight(context) / 1.4,
                    child: PageView.builder(
                      controller: p.imagePageController,
                      onPageChanged: (value) {
                        p.handleCurrentImagePage(value);
                      },
                      itemCount: widget.data.image.length,
                      itemBuilder: (context, i) {
                        final image = widget.data.image[i];
                        return Container(
                          height: constraints().getDeviceHeight(context) / 1.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("asset/images/discover.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // This part will be displayed at the bottom
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
                               userId.toString(),
                                    animationController!,isShare:widget.data.isShare);
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
                              p.shareRecipe(widget.data.pk.toString(), 1.toString());
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
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: PageViewDotIndicator(
              //       currentItem: widget.currentImagePage,
              //       count: widget.data.image.length,
              //       unselectedColor: constraints.colorBlack,
              //       selectedColor: constraints.colorGrey),
              // ),
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
                  padding: const EdgeInsets.all(8.0),
                  child:widget.data.description!=null?smalltext(
                      text: 
                      widget.data.description.length > 100
                          ? widget.data.description.substring(0, 100) + "..."
                          : widget.data.description):Container())
            ],
          ),
        ),
        Divider(
          thickness: 3,
        ),
      ],
    );
  }
}
