import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/provider/myProvider.dart';
import 'package:frontend/utils/appBar.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<myProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
        isShowSearchField: true,
      ),
      body: Consumer<myProvider>(builder: (context, value, child) {
        if (value.searchController.value != "") {
          return ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                      
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.person),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            smalltext(text: "Creater ${index}")
                          ],
                        ),
                      ),
                    ),
                    Divider(thickness: 1,)
                  ],
                );
              });
        } else {
          return Container();
        }
      }),
    );
  }
}
