import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildShimmerContainer(double height,double width,{double radius=0,bool isRadius=false}){
  return Container(height: height,width: width,decoration: BoxDecoration(
    borderRadius: isRadius?BorderRadius.circular(radius):BorderRadius.zero,
    color: Colors.white
  ),);
}