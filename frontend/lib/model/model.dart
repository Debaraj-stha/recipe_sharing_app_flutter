import 'package:frontend/pages/singleRecipePage.dart';

class Intro {
  Intro({required this.intro});
  String intro;
  factory Intro.fromJson(Map<String, dynamic> json) =>
      Intro(intro: json['intro']);
  Map<String, dynamic> toJson() => {"intro": intro};
}

class User {
  String name;
  String email;
  String? image; // Change the type from List<String>? to String?
  int pk;

  User({
    required this.name,
    required this.email,
    this.image,
    required this.pk,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      image: json['image'], // Expect a string here
      pk: json['pk'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "image": image,
        "pk": pk,
      };
}

class RecipeItem {
  int? shareId;
  String? shareTitle;
  List<String>? image;
  String? title;
  String? description;
  List<String>? steps;
  List<String>? ingredients;
  List<String>? hashtags;
  int pk;
  User user;
  DateTime addedAt;
  int? totalReact;
  int? totalComment;
  int? totalShare;
  List<React>? reaction;
  bool isShare;
  User? owner;

  RecipeItem(
      {this.shareId,
      this.shareTitle,
      required this.isShare,
      this.owner,
      this.totalComment,
      this.totalReact,
      this.reaction,
      this.totalShare,
      this.image,
      this.title,
      this.description,
      this.steps,
      this.ingredients,
      this.hashtags,
      required this.pk,
      required this.user,
      required this.addedAt});
  factory RecipeItem.fromJson(Map<String, dynamic> json) {
    return RecipeItem(
      isShare: json["isShare"],
      shareId: json["shareId"],
      shareTitle: json["shareTitle"],
      owner: json["owner"] != null ? User.fromJson(json["owner"]) : null,
      reaction: json["reaction"] != null
          ? List<React>.from(json["reaction"].map((x) => React.fromJson(x)))
          : null,
      pk: json["id"],
      totalComment: json['totalComment'],
      totalReact: json['totalReact'],
      totalShare: json['totalShare'],
      addedAt: DateTime.parse(json['addedAt']),
      user: User.fromJson(json['user']),
      image: List<String>.from(json['image']),
      title: json['title'],
      description: json['description'],
      steps: List<String>.from(json['steps']),
      ingredients: List<String>.from(json['ingredients']),
      hashtags: List<String>.from(json['hashtags']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "shareId": shareId,
      "shareTitle": shareTitle,
      "isShare": isShare,
      "owner": owner?.toJson(),
      "reaction": reaction?.map((react) => react.toJson()).toList(),
      "pk": pk,
      "totalComment": totalComment,
      "totalReact": totalReact,
      "totalShare": totalShare,
      "addedAt": addedAt.toIso8601String(),
      "user": user.toJson(),
      "image": image,
      "title": title,
      "description": description,
      "steps": steps,
      "ingredients": ingredients,
      "hashtags": hashtags,
    };
  }

}

class Search {
  String query;
  String id;
  Search({required this.query, required this.id});
  factory Search.fromJson(Map<String, dynamic> json) =>
      Search(id: json['id'], query: json['query']);
  Map<String, dynamic> toJson() => {"id": id, "query": query};
}

//                 "comment": c.comment,
//                 "id": c.pk,
//                 "created_at": c.created_at,
//                 "user": {
//                     "name": c.user.name,
//                     "email": c.user.email,
//                     "pk": c.user.pk,
//                     "image": str(c.user.image)
//                 }
class Comment {
  String comment;
  int id;
  DateTime created_at;
  User user;
  Comment(
      {required this.comment,
      required this.id,
      required this.created_at,
      required this.user});
  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      comment: json['comment'],
      id: json['id'],
      created_at: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']));
  Map<String, dynamic> toJson() =>
      {"comment": comment, "id": id, "created_at": created_at, "user": user};
}

class React {
  User user;
  int recipeId;
  DateTime created_at;
  int id;
  React(
      {required this.id,
      required this.created_at,
      required this.user,
      required this.recipeId});
  factory React.fromJson(Map<String, dynamic> json) => React(
      id: json['id'],
      created_at: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']),
      recipeId: json['recipeId']);
  Map<String, dynamic> toJson() =>
      {"id": id, "created_at": created_at, "user": user, "recipeId": recipeId};
}

class Follower {
  User user;
  int id;
  Follower({required this.id, required this.user});
  factory Follower.fromJson(Map<String, dynamic> json) =>
      Follower(id: json['id'], user: User.fromJson(json['user']));
  Map<String, dynamic> toJson() => {
        "user": user,
        "id": id,
      };
}

class FollowerCount {
  FollowerCount({required this.follower, required this.following});

  int follower;
  int following;
  factory FollowerCount.fromJson(Map<String, dynamic> json) => FollowerCount(
        follower: json['follower'],
        following: json['following'],
      );
  Map<String, dynamic> toJSON() =>
      {"follower": follower, "following": following};
}
