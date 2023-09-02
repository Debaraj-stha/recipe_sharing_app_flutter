import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/videoplayer.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';
import '../utils/bottomSheet.dart';
import '../utils/mediumtext.dart';
import '../utils/smalltext.dart';

class singleRecipePage extends StatefulWidget {
  const singleRecipePage(
      {super.key,
      required this.user,
      required this.description,
      this.title = "",
      required this.addedAt,
      required this.media,
      this.isVideo = false,
      this.steps = const [],
      this.ingredients = const [],
      this.hastag = const []});

  final String description;
  final user;
  final String title;
  final String addedAt;
  final List<String> media;
  final List<String> hastag;
  final List<String> ingredients;
  final bool isVideo;
  final List<String> steps;
  @override
  State<singleRecipePage> createState() => _singleRecipePageState();
}

class _singleRecipePageState extends State<singleRecipePage> {
  final String video = "https://download.samplelib.com/mp4/sample-5s.mp4";
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    p.initialize();
    return Scaffold(
      body: Consumer<myProvider>(builder: (context, value, child) {
// Remove [0] here
        return ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                  children: [
                    smalltext(
                        text: widget.user['name'], weight: FontWeight.bold),
                    smalltext(
                      text: widget.addedAt,
                    )
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // buttomSheet(context,widget.addedAt);
                  },
                  icon: Icon(
                    Icons.more_horiz,
                    color: constraints.colorBlack,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: mediumtext(text: widget.title),
          ),
          Container(
            height: constraints().getDeviceHeight(context) / 1.2,
            child: PageView.builder(
              controller: p.singleRecipePageController,
              onPageChanged: (value) {
                p.handleCurrentSingleRecipe(
                    value); // Use 'value' instead of 'index'
              },
              itemCount: widget.media.length,
              itemBuilder: (context, i) {
                // Change 'index' to 'i'
                final image = widget.media[i]; // Change 'index' to 'i'
                if (p.checkIsVideo(image)) {
                  return videoplayer(url: image);
                }
                else{
                return Stack(
                  children: [
                    Container(
                      height: constraints().getDeviceHeight(context) / 1.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
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
                count: widget.media.length,
                unselectedColor: constraints.colorBlack,
                selectedColor: constraints.colorGrey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              children: List.generate(widget.hastag.length, (index) {
                return InkWell(
                    onTap: () {},
                    child: smalltext(
                      text: widget.hastag[index],
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
            itemCount: widget.ingredients.length,
            itemBuilder: (context, index) {
              final item = widget.ingredients[index];
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
            itemCount: widget.steps.length,
            itemBuilder: (context, index) {
              final item = widget.steps[index];
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
              text: widget.description,
              weight: FontWeight.w500,
            ),
          ),
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
