import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class bigtext extends StatelessWidget {
  const bigtext({super.key,required this.text,this.size=30.0,this.weight=FontWeight.bold,this.color=Colors.black,this.family="Roboto"});
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