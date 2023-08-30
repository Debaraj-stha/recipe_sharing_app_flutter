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
  String? image;
  int pk;
  User({required this.name, required this.email, this.image, required this.pk});
  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      email: json['email'],
      image: json['image'],
      pk: json['pk']);
  Map<String, dynamic> toJson() =>
      {"email": email, "name": name, "image": image, "pk": pk};
}

class RecipeItem {
   List<String> image;
   String title;
   String description;
   List<String>? steps;
   List<String>? ingredients;
   List<String>? hashtags;
   int pk;
   User user;
  DateTime addedAt;
   int totalReact;
   int totalComment;
   int? totalShare;
   List<React>? reaction;
  bool isShare;
  String?sharetitle;
  User?owner;
  RecipeItem(
      {
        required this.isShare,
        this.sharetitle,
        this.owner,
        required this.totalComment,
      required this.totalReact,
      
      this.reaction,
      this.totalShare,
      required this.image,
      required this.title,
      required this.description,
       this.steps,
       this.ingredients,
       this.hashtags,
      required this.pk,
      required this.user,
      required this.addedAt
      });
  factory RecipeItem.fromJson(Map<String, dynamic> json) {
  return RecipeItem(
    isShare: json["isShare"],
    sharetitle: json["sharetitle"],
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
      user:User.fromJson(json['user']));
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
