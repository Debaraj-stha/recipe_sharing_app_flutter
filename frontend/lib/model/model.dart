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
  final List<String> image;
  final String title;
  final String description;
  final List<String> steps;
  final List<String> ingredients;
  final List<String> hashtags;
  final int pk;
  final User user;
DateTime addedAt;
  RecipeItem({
    required this.image,
    required this.title,
    required this.description,
    required this.steps,
    required this.ingredients,
    required this.hashtags,
    required this.pk,
    required this.user,
    required this.addedAt
  });

  factory RecipeItem.fromJson(Map<String, dynamic> json) {
    return RecipeItem(
      pk: json["id"],
      addedAt: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']),
      image: List<String>.from(json['image']),
      title: json['title'],
      description: json['description'],
      steps: List<String>.from(json['steps']),
      ingredients: List<String>.from(json['ingredients']),
      hashtags: List<String>.from(json['hastags']),
    );
  }
}

