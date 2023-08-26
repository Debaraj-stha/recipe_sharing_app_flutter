import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/singleRecipePage.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/simmerEffect.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:lottie/lottie.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'bottomSheet.dart';

class homePageContent extends StatefulWidget {
  const homePageContent({super.key});

  @override
  State<homePageContent> createState() => _homePageContentState();
}

class _homePageContentState extends State<homePageContent>
    with SingleTickerProviderStateMixin {
  

  AnimationController? animationController;
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
    p.initialize();
    return Consumer<myProvider>(
      builder: (context, value, child) {
        if (value.items.isEmpty && value.isLoading) {
          return  buildShimmer(context);
            
        } else if (value.items.length == 0) {
          return Container(
            child: Center(child: smalltext(text: "Nothing to displau")),
          );
        }
        return ListView.builder(
          itemCount: value.items.length,
          itemBuilder: (context, index) {
            final data = value.items[index]; // Remove [0] here

            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => singleRecipePage(
                                user: data.user,
                                description: data.description,
                                addedAt: data.addedAt.toIso8601String(),
                                hastag: data.hashtags,
                                title: data.title,
                                ingredients: data.ingredients,
                                steps: data.steps,
                                media: data.image)));
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
                                    image:
                                        AssetImage("asset/images/discover.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  smalltext(
                                      text: data.user.name,
                                      weight: FontWeight.bold),
                                  smalltext(
                                    text: DateFormat('yyyy-MM-dd HH:mm')
                                        .format(data.addedAt),
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
                        child: mediumtext(text: data.title),
                      ),
                      Stack(
                        children: [
                          Container(
                            height:
                                constraints().getDeviceHeight(context) / 1.4,
                            child: PageView.builder(
                              controller: p.imagePageController,
                              onPageChanged: (value) {
                                p.handleCurrentImagePage(value);
                              },
                              itemCount: data.image.length,
                              itemBuilder: (context, i) {
                                final image = data.image[i];
                                return Container(
                                  height:
                                      constraints().getDeviceHeight(context) /
                                          1.2,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "asset/images/discover.png"),
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
                                        p.likeRecipie(data.pk.toString(),
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
                                    text: p
                                        .getReactionCount(data.pk.toString())
                                        .toString(),
                                    color: constraints.colorWhite,
                                    weight: FontWeight.w700,
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      p.shareRecipie(data.pk.toString());
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
                                            data.pk.toString())
                                        .toString(),
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
                            currentItem: value.currentImagePage,
                            count: data.image.length,
                            unselectedColor: constraints.colorBlack,
                            selectedColor: constraints.colorGrey),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 8,
                          children:
                              List.generate(data.hashtags.length, (index) {
                            return InkWell(
                                onTap: () {},
                                child: smalltext(
                                  text: data.hashtags[index],
                                  color: constraints.primaryColor,
                                  weight: FontWeight.bold,
                                ));
                          }),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: smalltext(
                              text: data.description.length > 100
                                  ? data.description.substring(0, 100) + "..."
                                  : data.description))
                    ],
                  ),
                ),
                Divider(
                  thickness: 3,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
