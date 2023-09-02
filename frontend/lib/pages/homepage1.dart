import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/accountPage.dart';
import 'package:frontend/pages/addRecipe.dart';
import 'package:frontend/pages/discoverPage.dart';
import 'package:frontend/pages/searchPage.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/homepageContent.dart';
import 'package:provider/provider.dart';

class homePage1 extends StatefulWidget {
  const homePage1({super.key});

  @override
  State<homePage1> createState() => _homePage1State();
}

class _homePage1State extends State<homePage1> {
  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<myProvider>(context, listen: false);
    provider.initialize();
    super.initState();
  }

  @override
  final iconList = <IconData>[
    Icons.home,
    Icons.explore,
    Icons.search,
    Icons.person,
  ];
  List pages = [
    homePageContent(),
    discoverPage(),
    searchPage(),
    accountPage()
  ];
  Widget build(BuildContext context) {
    final provider = Provider.of<myProvider>(context, listen: false);
    provider.loadRecipe();
    provider.getFollowUser("1");
    provider.getFollowing("1");
    provider.initialize();
    return Scaffold(
        body: Consumer<myProvider>(builder: (context, value, child) {
          return pages[value.currentActiveTab];
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: constraints.primaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>addRecipePage()));
          },
          child: Icon(
            Icons.add,
            size: 30,
          ),
          //params
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Consumer<myProvider>(
          builder: (context, value, child) {
            return AnimatedBottomNavigationBar(
              backgroundColor: constraints.colorBlack.withOpacity(.8),
              icons: iconList,

              activeIndex: value.currentActiveTab, // Use value from provider
              gapLocation: GapLocation.center,
              inactiveColor: constraints.colorWhite,
              // notchSmoothness: NotchSmoothness.verySmoothEdge,
              activeColor: constraints.primaryColor,

              onTap: (index) {
                provider.handleCurrentActivePage(index);
              },
              //other params
            );
          },
        ));
  }
}
