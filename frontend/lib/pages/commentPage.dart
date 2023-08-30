import 'package:flutter/material.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/bigtext.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';

import '../utils/singleComment.dart';

class commentPage extends StatefulWidget {
  const commentPage({super.key, required this.pk});
  final int pk;
  @override
  State<commentPage> createState() => _commentPageState();
}

class _commentPageState extends State<commentPage> {
  int userId = 1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    final provider = Provider.of<myProvider>(context, listen: false);
   

    // scrollController.addListener(provider.listenScrolling(scrollController));
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<myProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: constraints.colorWhite,
        title: mediumtext(text: "Comments"),
        leading: BackButton(
          color: constraints.colorBlack,
        ),
      ),
      body: Container(
        color: constraints.colorLightGrey,
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<myProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.only(bottom: 10),
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
                maxLines: 2,
                controller: provider.textEditingController,
                onFieldSubmitted: (value) {
                  provider.postComment(widget.pk, userId,scrollController!);
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  suffix: InkWell(
                      onTap: () {
                        provider.postComment(widget.pk, userId,scrollController!);
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
  }
}
