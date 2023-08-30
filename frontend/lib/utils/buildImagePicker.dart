import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/myProvider.dart';

Widget buildImagePicker(String text, Color color, int type,BuildContext context,{bool isProfile=false}) {
    final provider = Provider.of<myProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: color),
          onPressed: () {
            if (type == 1) {
              provider.pickImage(ImageSource.gallery,isProfile: isProfile);
            } else {
              provider.pickImage(ImageSource.camera,isProfile: isProfile);
            }
          },
          child: smalltext(
            text: text,
            color: constraints.colorWhite,
          )),
    );
  }