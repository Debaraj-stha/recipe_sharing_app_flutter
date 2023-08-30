import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'mediumtext.dart';

class singleComment extends StatefulWidget {
  const singleComment({super.key, required this.comment});
  final comment;
  @override
  State<singleComment> createState() => _singleCommentState();
}

class _singleCommentState extends State<singleComment> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    bool isShowMore = p.isShowMore(widget.comment.comment);
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: constraints.colorWhite),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: constraints.secondaryColor,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mediumtext(text: widget.comment.user.name),
                Consumer<myProvider>(builder: ((context, value, child) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smalltext(
                          text: isShowMore
                              ? widget.comment.comment.substring(0, 150) + "..."
                              : widget.comment.comment,
                        ),
                        if (widget.comment.comment.length > 150)
                          InkWell(
                            focusColor: constraints.primaryColor,
                            hoverColor: constraints.primaryColor,
                            child: smalltext(
                              text: isShowMore ? "Show More" : "Show Less",
                              color: constraints.secondaryColor,
                            ),
                            onTap: () {
                              p.toggleShowMore(widget.comment.comment);
                            },
                          ),
                      ]);
                })),
                SizedBox(
                  height: 5,
                ),
                smalltext(
                    text: DateFormat("yyyy-MM-dd HH:mm")
                        .format(widget.comment.created_at))
              ],
            ),
          ),
        ]));
  }
}
