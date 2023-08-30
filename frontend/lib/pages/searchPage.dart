import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/singleRecipePage.dart';
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
        if (value.searchItems.isNotEmpty && value.searchItems.length!=0) {
          return ListView.builder(
              itemCount: value.searchItems.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final data=value.searchItems[index];
                return InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>singleRecipePage(user: user, description: description, addedAt: addedAt, media: media)))
                  },
                  child: Column(
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
                              data.title!=null?smalltext(text: data.title!):Container()
                            ],
                          ),
                        ),
                      ),
                      Divider(thickness: 1,)
                    ],
                  ),
                );
              });
        } else {
          return Container();
        }
      }),
    );
  }
}
