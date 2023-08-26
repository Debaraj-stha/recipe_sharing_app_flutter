import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';

import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';

import '../utils/intropageWidget.dart';

class introPage extends StatefulWidget {
  const introPage({super.key});

  @override
  State<introPage> createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  @override
  void initState() {
    // TODO: implement initState
    final p = Provider.of<myProvider>(context, listen: false);
    p.initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    final p = Provider.of<myProvider>(context, listen: false);
    p.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: p.pageController,
              onPageChanged: (value) {
                p.setCurrentPage(value);
              },
              children: [
                introPageWidget(
                    title: "Welcome",
                    message:
                        "Cook, Capture, Connect: Your Culinary Journey Begins",
                    secondmessage: "To our Recipe Sharing app",
                    image: "asset/images/welcome.jpg"),
                introPageWidget(
                    title: "Discover",
                    message:
                        "Discover Delightful Recipes from Around the World",
                    image: "asset/images/discover1.jpg"),
                introPageWidget(
                  message: "Cooking Made Fun, Sharing Made Easy",
                  title: "Share",
                  image: "asset/images/share3.jpg",
                ),
                introPageWidget(
                  message: "Explore, Create, Share: Unleash Your Inner Chef!",
                  title: "Create",
                  image: "asset/images/create1.jpg",
                ),
                introPageWidget(
                  title: "Favourite",
                  message: "Save your favourite Recipe",
                  image: "asset/images/save.jpg",
                ),
                introPageWidget(
                  title: "Get Started",
                  message: "Sign Up",
                  issignUp: true,
                  image: "asset/images/signup2.jpg",
                )
              ],
            ),
          ),
          Consumer<myProvider>(builder: ((context, value, child) {
            return  PageViewDotIndicator(
            count: 6,
            currentItem: value.currentPage,
            unselectedColor: constraints.colorGrey,
            selectedColor: constraints.primaryColor,
          );
          })),
         
          TextButton(
            onPressed: () {},
            child: smalltext(
              text: "Skip",
              color: constraints.primaryColor,
              weight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
