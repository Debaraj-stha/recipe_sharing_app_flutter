import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:shimmer/shimmer.dart';


  Widget buildShimmer(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        
                      ),
                      SizedBox(width: 10), // Add spacing
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 15,
                            color: Colors.white,
                          ),
                          SizedBox(height: 8), // Add spacing
                          Container(
                            width: 100,
                            height: 15,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Container(height: 20,width: constraints().getDeviceWidth(context)-20,color: constraints.colorWhite,),
                  SizedBox(height: 8,),
                  Container(
                    height: 200,
                    margin: EdgeInsets.symmetric(vertical: 3), // Adjust the height as needed
                    color: Colors.white,
                  ),
                  SizedBox(height: 8), // Add spacing
                  Wrap(
                    spacing: 8,
                    children: List.generate(7, (index) {
                      return Container(
                        width: 30,
                        height: 15,
                        color: Colors.white,
                      );
                    }),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

