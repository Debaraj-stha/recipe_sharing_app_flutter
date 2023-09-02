import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/followingFollowerPage.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';

class userPageHeader extends StatefulWidget {
  const userPageHeader({
    super.key,
  });

  @override
  State<userPageHeader> createState() => _userPageHeaderState();
}

class _userPageHeaderState extends State<userPageHeader> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);

    return Container(
        height: constraints().getDeviceHeight(context) / 2,
        child: Consumer<myProvider>(
          builder: (context, value, child) {
            return Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: constraints.primaryColor, width: 2),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("asset/images/discover.png")))),
                  SizedBox(
                    height: 7,
                  ),
                  mediumtext(
                    text: "Jeevan Shresth",
                    size: 20,
                    family: "NotoSerif",
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  InkWell(onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => followerFollowuingPage()));
                  }, child: Consumer<myProvider>(
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              mediumtext(
                                text: "Followers",
                                size: 20,
                                family: "NotoSerif",
                              ),
                              smalltext(
                                text: value.specificUserRecipe.isNotEmpty
                                    ? value.followerCount[0].follower.toString()
                                    : "0",
                                family: "NotoSerif",
                                weight: FontWeight.bold,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              mediumtext(
                                text: "Following",
                                size: 20,
                                family: "NotoSerif",
                              ),
                              smalltext(
                                family: "NotoSerif",
                                text: value.specificUserRecipe.isNotEmpty
                                    ? value.followerCount[0].follower!
                                        .toString()
                                    : "0",
                                weight: FontWeight.bold,
                              )
                            ],
                          )
                        ],
                      );
                    },
                  )),
                  SizedBox(
                    height: 7,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: constraints.secondaryColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(3, 3),
                                color: constraints.colorGrey),
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(-3, 3),
                                color: constraints.colorGrey)
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add_alt,
                              color: constraints.colorWhite),
                          SizedBox(
                            width: 7,
                          ),
                          mediumtext(
                            family: "LobsterTwo",
                            text: "Follow",
                            color: constraints.colorWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Divider(
                  //   thickness: 2,
                  //   color: constraints.colorLightGrey,
                  // )
                ],
              ),
            );
          },
        ));
  }
}
