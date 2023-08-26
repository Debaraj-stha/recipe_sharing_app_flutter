import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class smalltext extends StatelessWidget {
  const smalltext({super.key,required this.text,this.size=18.0,this.weight=FontWeight.normal,this.color=Colors.black,this.family="Roboto"});
final String text;
final double size;
final FontWeight weight;
final Color color;
final String family;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: weight,fontFamily: family),);
  }
}