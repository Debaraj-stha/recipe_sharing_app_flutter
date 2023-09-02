import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/buildFollowButton.dart';
import 'package:frontend/utils/dropDownButton.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:frontend/utils/toastmessage.dart';
import 'package:provider/provider.dart';

class followerPage extends StatelessWidget {
  const followerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    return Stack(
      children: [
        Positioned.fill(
            top: 40,
            child: Consumer<myProvider>(
              builder: (context, value, child) {
                if (value.followers.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: mediumtext(
                        text: "You do not have any follower yet",
                        family: "Righteous",
                      ),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: value.followers.length,
                    padding: EdgeInsets.only(left: 8, right: 8, top: 5),
                    itemBuilder: (context, index) {
                      final follower = value.followers[index];
                      bool isAlreadyFollow = value.followings.any((following) =>
                          following.user.email == follower.user.email);
                      debugPrint(isAlreadyFollow.toString());
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
                                if (!isAlreadyFollow) {
                                  value.followUser(
                                      "1",
                                      follower.user.pk.toString(),
                                      follower.id.toString());
                                  debugPrint(p.followedText.toString());
                                } else {
                                  showmessage(
                                      "You have already followed to this user");
                                }
                              },
                              onHover: (value) {
                                debugPrint("Hover");
                              },
                              child: buildFollowButton(
                                text: isAlreadyFollow
                                    ? value.chnageFollowedText(
                                        follower.id.toString(), "Following")
                                    : value.chnageFollowedText(
                                        follower.id.toString(), "Follow"),
                                bgColor: constraints.colorBlack,
                                textColor: constraints.colorWhite,
                                isBorder: true,
                              ))
                        ],
                      );
                    });
              },
            )),
             Positioned(
          top: 0,
          left: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            dropDownButton(type:"follower"),
              Container(
                  height: 40,
                  width: constraints().getDeviceWidth(context),
                  padding: EdgeInsets.only(left: 5),
                  // margin: EdgeInsets.only(bottom: 10),
                  child: Center(
                      child: mediumtext(
                    text: "Follower",
                    family: "LobsterTwo",
                  ))),
            ],
          ),
        )
           
       
      ],
    );
  }
}
