import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showmessage(String message,
    {Color textcolor = Colors.white, Color bgColor = Colors.green}) {
  Fluttertoast.showToast(
      msg: message,
      textColor: textcolor,
      backgroundColor: bgColor,
      fontSize: 18,
      
      gravity: ToastGravity.BOTTOM);
}
