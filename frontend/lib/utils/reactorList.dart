import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:frontend/utils/toastmessage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

Future showReactorList(
    BuildContext context, AnimationController animationController,List reaction) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top:constraints().getDeviceWidth(context)/11),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
              child: ListView.builder(
                  itemCount: reaction.length,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final data=reaction[index];
                    return InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>userProfilePage()))
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            onBackgroundImageError: (exception, stackTrace){
                              return showmessage("image loading failed");
                            },
                            backgroundColor: constraints.secondaryColor,
                            backgroundImage: AssetImage("asset/images/welcome.jpg"),
                          ),
                          SizedBox(width: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mediumtext(text: data.user.name),
                                  smalltext(
                        text: DateFormat("yyyy-MM-dd HH:mm")
                            .format(data.created_at))
                            ],
                          ),
                          Spacer(),
                          Lottie.asset(
                            "asset/lottie/heart.json",
                            alignment: Alignment.bottomCenter,
                            height: 80,
                            controller: animationController,
                          )
                        ],
                      ),
                    );
                  }),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap:() {
                  Navigator.pop(context);
                },
                
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:Border.all(color: constraints.colorGrey,width: 2)
                  ),
                  child: Icon(Icons.close,size: 30,))),
            )
          ],
        );
      });
}
