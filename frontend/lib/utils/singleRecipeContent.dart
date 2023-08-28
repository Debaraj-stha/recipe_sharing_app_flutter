import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/commentButtonSheet.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';

import '../pages/singleRecipePage.dart';
import '../provider/myProvider.dart';
import 'bottomSheet.dart';

class singleRecipeContent extends StatefulWidget {
  const singleRecipeContent(
      {super.key, required this.data, required this.currentImagePage});
  final data;
  final int currentImagePage;
  @override
  State<singleRecipeContent> createState() => _singleRecipeContentState();
}

class _singleRecipeContentState extends State<singleRecipeContent>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    final p = Provider.of<myProvider>(context, listen: false);
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    p.initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          smalltext(
                              text: widget.data.user.name,
                              weight: FontWeight.bold),
                          smalltext(
                            text: DateFormat('yyyy-MM-dd HH:mm')
                                .format(widget.data.addedAt),
                          )
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          buttomSheet(context);
                        },
                        icon: Icon(
                          Icons.more_horiz,
                          color: constraints.colorBlack,
                        ),
                      )
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
                                p.likeRecipie(widget.data.pk.toString(),
                                    animationController!);
                              },
                              child: Lottie.asset(
                                "asset/lottie/heart.json",
                                alignment: Alignment.bottomCenter,
                                height: 110,
                                controller: animationController,
                              ),
                            ),
                          ),
                          smalltext(
                            text: widget.data.totalReact.toString(),
                            color: constraints.colorWhite,
                            weight: FontWeight.w700,
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              p.shareRecipie(widget.data.pk.toString());
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>commentPage()));
                              },
                              child: Icon(
                                Icons.comment,
                                color: constraints.colorWhite,
                                size: 30,
                              )),
                          smalltext(
                            text: "10",
                            color: constraints.colorWhite,
                            weight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageViewDotIndicator(
                    currentItem: widget.currentImagePage,
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
                  padding: const EdgeInsets.all(8.0),
                  child: smalltext(
                      text: widget.data.description.length > 100
                          ? widget.data.description.substring(0, 100) + "..."
                          : widget.data.description))
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
