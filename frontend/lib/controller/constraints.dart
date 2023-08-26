import 'package:flutter/material.dart';

class constraints{
  static final  primaryColor=Colors.green;
  static final colorBlack=Colors.black;
  static final colorWhite=Colors.white;
  static final colorGrey=Colors.grey;
  static final secondaryColor=Colors.blueAccent;
  double getDeviceWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }
  double getDeviceHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }
}