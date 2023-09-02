import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/dropDownButton.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';

import 'buildFollowButton.dart';

class followingPage extends StatelessWidget {
  const followingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            top: 40,
            child: Consumer<myProvider>(
              builder: (context, value, child) {
                if (value.followings.isEmpty) {
                  return Center(
                    child: mediumtext(
                      text: "You do not have followed any user yet",
                      family: "Righteous",
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: value.followings.length,
                    padding: EdgeInsets.only(left: 8, right: 8, top: 5),
                    itemBuilder: (context, index) {
                      final follower = value.followings[index];
                      return Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape
                                  .circle, // This creates a circular shape
                              image: DecorationImage(
                                image: AssetImage(
                                  "asset/${follower.user.image}", // Make sure the path is correct
                                ),
                               
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          smalltext(
                            text: follower.user.name,
                            weight: FontWeight.bold,
                            family: "Lato",
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              value.unfollowUser(follower.id.toString());
                              debugPrint("tapped");
                            },
                            child: buildFollowButton(
                                bgColor: constraints.colorWhite,
                                textColor: constraints.colorBlack,
                                text: "Unfollow",
                                isBorder: true),
                          )
                        ],
                      );
                    });
              },
            )),
        Positioned(
            top: 0,
            left: 10,
            child: Row(
              children: [
                dropDownButton(type:"following"),
                Container(
                    height: 40,
                    width: constraints().getDeviceWidth(context),
                    padding: EdgeInsets.only(left: 5),
                    // margin: EdgeInsets.only(bottom: 10),
                    child: Center(
                        child: mediumtext(
                      text: "Following",
                      family: "LobsterTwo",
                    ))),
              ],
            ))
      ],
    );
  }
}
