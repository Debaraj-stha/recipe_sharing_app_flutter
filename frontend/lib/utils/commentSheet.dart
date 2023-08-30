import 'package:flutter/material.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/singleComment.dart';
import 'package:provider/provider.dart';

Future showCommentSheet(BuildContext context, ScrollController scrollController,
    int userId, int pk) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        final provider = Provider.of<myProvider>(context, listen: false);
        return SingleChildScrollView(
          reverse: true,
          child: Container(
            color: constraints.colorGrey,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<myProvider>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        itemCount: value.comments.length,
                        itemBuilder: (context, index) {
                          final comment = value.comments[index];
                          return singleComment(comment: comment);
                        },
                      );
                    },
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: provider.textEditingController,
                    onFieldSubmitted: (value) {
                      provider.postComment(pk, userId, scrollController!);
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      suffix: InkWell(
                          onTap: () {
                            provider.postComment(pk, userId, scrollController!);
                          },
                          child: Icon(
                            Icons.telegram,
                            size: 30,
                          )),
                      border: InputBorder.none,
                      hintText: "Comment here",
                      hintStyle: TextStyle(fontFamily: "NotoSerif"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
