import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:frontend/controller/constraints.dart';
import 'package:frontend/pages/singleRecipePage.dart';
import 'package:frontend/utils/bigtext.dart';
import 'package:frontend/utils/mediumtext.dart';
import 'package:frontend/utils/smalltext.dart';

import '../utils/appBar.dart';

class discoverPage extends StatefulWidget {
  const discoverPage({super.key});

  @override
  State<discoverPage> createState() => _discoverPageState();
}

class _discoverPageState extends State<discoverPage> {
  List dummyData = [
    {
      "id": "1",
      "user": {"name": "Jhon Doe", "profile": "asset/images/discover.png"},
      "description":
          "Lorem ipsum dolor sit amet Ut aliquip officia commodo incididunt reprehenderit eiusmod enim proident adipisicing eiusmod nostrud et incididunt. Esse consectetur Lorem commodo amet eiusmod sit incididunt cupidatat. Do excepteur magna magna dolor ullamco. Ad eu proident ipsum in excepteur fugiat nostrud anim ad dolore adipisicing magna nisi dolore. Nulla commodo ullamco aliqua est magna adipisicing duis labore aliqua cupidatat cupidatat nulla dolore do.",
      "title": "Mollit in occaecat...",
      "media": [
        "asset/images/discover.png",
        "asset/images/create1.jpg",
        "asset/images/share1.jpg",
        "https://download.samplelib.com/mp4/sample-5s.mp4"
      ],
      "addedAt": "1 days ago",
      "isvideo": false,
      "hastag": [
        "#recipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
      ],
      "ingredients": [
        "Pizza dough (you can make your own or buy pre-made dough)",
        "Sliced mushrooms",
        "Sliced bell peppers",
        "Sliced onions",
        "Sliced black olives",
        "Sliced tomatoes",
        "Cooked and crumbled sausage",
        "Sliced ham",
        "Pineapple chunks (for Hawaiian pizza)",
        "Fresh basil leaves",
        "Olive oil",
        "Garlic (minced)",
        "Dried oregano",
        "Salt and pepper"
      ],
      "steps": [
        "If you're making your own pizza dough, follow a recipe to mix the ingredients (flour, water, yeast, salt, and optionally olive oil) and knead until",
        "Preheat your oven to around 450°F (232°C) or as specified in your dough recipe.",
        " In a small bowl, mix pizza sauce, a drizzle of olive oil, minced garlic, dried oregano, and a pinch of salt and pepper. Adjust the seasoning to taste.",
        "On a floured surface, roll out the pizza dough to your desired thickness and shape. Place it on a pizza stone, baking sheet, or pizza pan.",
        "Spread the prepared sauce over the pizza dough, leaving a small border around the edges. Sprinkle shredded mozzarella cheese over the sauce, and add grated Parmesan cheese for extra flavor.",
      ]
    },
    {
      "id": "2",
      "user": {"name": "Jhon Doe", "profile": "asset/images/discover.png"},
      "description":
          "Lorem ipsum dolor sit amet Ut aliquip officia commodo incididunt reprehenderit eiusmod enim proident adipisicing eiusmod nostrud et incididunt. Esse consectetur Lorem commodo amet eiusmod sit incididunt cupidatat. Do excepteur magna magna dolor ullamco. Ad eu proident ipsum in excepteur fugiat nostrud anim ad dolore adipisicing magna nisi dolore. Nulla commodo ullamco aliqua est magna adipisicing duis labore aliqua cupidatat cupidatat nulla dolore do.",
      "title": "Mollit in occaecat...",
      "media": [
        "asset/images/discover.png",
        "asset/images/create1.jpg",
        "asset/images/share1.jpg",
        "https://download.samplelib.com/mp4/sample-5s.mp4"
      ],
      "addedAt": "1 days ago",
      "isvideo": false,
      "hastag": [
        "#recipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
      ],
      "ingredients": [
        "Pizza dough (you can make your own or buy pre-made dough)",
        "Sliced mushrooms",
        "Sliced bell peppers",
        "Sliced onions",
        "Sliced black olives",
        "Sliced tomatoes",
        "Cooked and crumbled sausage",
        "Sliced ham",
        "Pineapple chunks (for Hawaiian pizza)",
        "Fresh basil leaves",
        "Olive oil",
        "Garlic (minced)",
        "Dried oregano",
        "Salt and pepper"
      ],
      "steps": [
        "If you're making your own pizza dough, follow a recipe to mix the ingredients (flour, water, yeast, salt, and optionally olive oil) and knead until",
        "Preheat your oven to around 450°F (232°C) or as specified in your dough recipe.",
        " In a small bowl, mix pizza sauce, a drizzle of olive oil, minced garlic, dried oregano, and a pinch of salt and pepper. Adjust the seasoning to taste.",
        "On a floured surface, roll out the pizza dough to your desired thickness and shape. Place it on a pizza stone, baking sheet, or pizza pan.",
        "Spread the prepared sauce over the pizza dough, leaving a small border around the edges. Sprinkle shredded mozzarella cheese over the sauce, and add grated Parmesan cheese for extra flavor.",
      ]
    },
    {
      "id": "3",
      "user": {"name": "Jhon Doe", "profile": "asset/images/discover.png"},
      "description":
          "Lorem ipsum dolor sit amet Ut aliquip officia commodo incididunt reprehenderit eiusmod enim proident adipisicing eiusmod nostrud et incididunt. Esse consectetur Lorem commodo amet eiusmod sit incididunt cupidatat. Do excepteur magna magna dolor ullamco. Ad eu proident ipsum in excepteur fugiat nostrud anim ad dolore adipisicing magna nisi dolore. Nulla commodo ullamco aliqua est magna adipisicing duis labore aliqua cupidatat cupidatat nulla dolore do.",
      "title": "Mollit in occaecat...",
      "media": [
        "asset/images/discover.png",
        "asset/images/create1.jpg",
        "asset/images/share1.jpg",
        "https://download.samplelib.com/mp4/sample-5s.mp4"
      ],
      "addedAt": "1 days ago",
      "isvideo": false,
      "hastag": [
        "#recipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
        "#newrecipe",
      ],
      "ingredients": [
        "Pizza dough (you can make your own or buy pre-made dough)",
        "Sliced mushrooms",
        "Sliced bell peppers",
        "Sliced onions",
        "Sliced black olives",
        "Sliced tomatoes",
        "Cooked and crumbled sausage",
        "Sliced ham",
        "Pineapple chunks (for Hawaiian pizza)",
        "Fresh basil leaves",
        "Olive oil",
        "Garlic (minced)",
        "Dried oregano",
        "Salt and pepper"
      ],
      "steps": [
        "If you're making your own pizza dough, follow a recipe to mix the ingredients (flour, water, yeast, salt, and optionally olive oil) and knead until",
        "Preheat your oven to around 450°F (232°C) or as specified in your dough recipe.",
        " In a small bowl, mix pizza sauce, a drizzle of olive oil, minced garlic, dried oregano, and a pinch of salt and pepper. Adjust the seasoning to taste.",
        "On a floured surface, roll out the pizza dough to your desired thickness and shape. Place it on a pizza stone, baking sheet, or pizza pan.",
        "Spread the prepared sauce over the pizza dough, leaving a small border around the edges. Sprinkle shredded mozzarella cheese over the sauce, and add grated Parmesan cheese for extra flavor.",
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Discover"),
        body: GridView.builder(
          itemCount: dummyData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 12,
              mainAxisExtent: constraints().getDeviceHeight(context)/2.4),
          itemBuilder: (context, index) {
            final data = dummyData[index];
            return InkWell(
              onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>singleRecipePage(data:data,
 )));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                // color: Colors.red, 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                          padding: const EdgeInsets.only(left: 5,bottom: 3),
                      child: smalltext(
                        text: data['title'].length>20?data['title'].substring(0,20):data['title'],
                        size: 20,
                        weight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      child: Image(image: AssetImage(data['media'][0])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: smalltext(
                          text: data['description'].length > 50
                              ? data['description'].substring(0, 50)
                              : data['description']),
                    ),
                            Padding(
                                 padding: const EdgeInsets.only(left: 5),
                              child: InkWell(onTap: (){
                                
                              },child: mediumtext(text: "By:${data['user']['name']}")),
                            )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
