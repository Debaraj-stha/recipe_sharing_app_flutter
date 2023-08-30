import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/utils/toastmessage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:http/http.dart' as http;

import '../model/model.dart';

class myProvider with ChangeNotifier {
  late PageController pageController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController searchController;
  late FocusNode searchNode;
  late FocusNode nameNode;
  late FocusNode passwordNode;
  late FocusNode emailNode;
  late TextEditingController titlecontroller;
  late TextEditingController hastagController;
  late TextEditingController descriptionController;
  late TextEditingController stepsController;
  late TextEditingController ingredientsController;
  late FocusNode titlenode;
  late FocusNode descriptionNode;
  late FocusNode ingredientsNode;
  late FocusNode stepsNode;
  late FocusNode hastagnode;
  int currentPage = 0;
  final formKey = GlobalKey<FormState>();
  final loginformKey = GlobalKey<FormState>();
  bool isinvalid = false;
  int currentActiveTab = 0;
  int currentImagePage = 0;
  late PageController imagePageController;
  late PageController singleRecipePageController;
  int currentSingleRecipe = 0;
  bool isSearchBarClicked = false;
  Map<String, dynamic> manageReaction = {};
  Map<String, dynamic> countReaction = {};
  Map<String, dynamic> shareRecipeCount = {};
  List<XFile>? imageFile;
  bool hasimages = false;
  String message = "";
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  XFile? profile;
  RegExp passwordRegex = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
  );
  RegExp nameRegex = RegExp(
    r'^[A-Za-z\s]+$',
  );
  RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
  );
  String baseURL = "http://10.0.2.2:8000";
  List<RecipeItem> _items = [];
  List<RecipeItem> get items => _items;
  bool isLoading = true;
  String email = "dstha221@gmail.com";
  double progress = 0;
  List<RecipeItem> _searchItems = [];
  List<RecipeItem> get searchItems => _searchItems;
  List<Comment> _comments = [];
  List<Comment> get comments => _comments;
  List<RecipeItem> specificUser=[];
  bool isUserBack=true;
  void initialize() {
    pageController = PageController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameNode = FocusNode();
    passwordNode = FocusNode();
    emailNode = FocusNode();
    imagePageController = PageController();
    singleRecipePageController = PageController();
    searchController = TextEditingController();
    searchNode = FocusNode();
    titlecontroller = TextEditingController();
    descriptionController = TextEditingController();
    hastagController = TextEditingController();
    ingredientsController = TextEditingController();
    stepsController = TextEditingController();
    titlenode = FocusNode();
    descriptionNode = FocusNode();
    ingredientsNode = FocusNode();
    stepsNode = FocusNode();
    hastagnode = FocusNode();
  }

  void disppose() {
    searchNode.unfocus();
    nameNode.unfocus();
    emailNode.unfocus();
    passwordNode.unfocus();
    pageController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    emailNode.dispose();
    nameNode.dispose();
    imagePageController.dispose();
    singleRecipePageController.dispose();
    searchController.dispose();
    titlenode.dispose();
    descriptionNode.dispose();
    ingredientsNode.dispose();
    stepsNode.dispose();
    hastagnode.dispose();
    titlecontroller.dispose();
    descriptionController.dispose();
    hastagController.dispose();
    ingredientsController.dispose();
    stepsController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }

  void setCurrentPage(int val) {
    currentPage = pageController.page!.round();
    notifyListeners();
  }

  void login() async {
    try {
      final response = await http.post(Uri.parse(baseURL + "/login"), body: {
        "email": emailController.text,
        "password": passwordController.text
      });
      final data = jsonDecode(response.body);
      debugPrint(data['message']);
      if (data['statusCode'] == 200) {
        showmessage(data['message']);
        debugPrint(response.body.toString());
      } else if (data['statusCode'] == 400) {
        showmessage(data['message'],
            bgColor: Colors.red, textcolor: Colors.white);
      } else {
        showmessage(
            "Something went wrong. Please try again.Message: ${response.body}",
            bgColor: Colors.red,
            textcolor: Colors.white);
      }
    } on Exception catch (e) {
      debugPrint("Exception occured while login in" + e.toString());
      showmessage("Exception occured while login in" + e.toString());
    }
    emailNode.unfocus();
    passwordNode.unfocus();
    nameController.clear();
    emailController.clear();
  }

  void signin() async {
    try {
      final response = await http.post(Uri.parse(baseURL + "/signup"), body: {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text
      });
      final data = jsonDecode(response.body);
      debugPrint(data['message']);
      if (data['statusCode'] == 200) {
        showmessage(data['message']);
        debugPrint(response.body.toString());
      } else if (data['statusCode'] == 400) {
        showmessage(data['message'],
            bgColor: Colors.red, textcolor: Colors.white);
      } else {
        showmessage(
            "Something went wrong. Please try again.Message: ${response.body}",
            bgColor: Colors.red,
            textcolor: Colors.white);
      }
    } on Exception catch (e) {
      debugPrint("Exception occured while sign in" + e.toString());
      showmessage("Exception occured while sign in" + e.toString());
    }
    nameNode.unfocus();
    passwordNode.unfocus();
    emailNode.unfocus();
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }

  void handleCurrentActivePage(int index) {
    currentActiveTab = index;
    debugPrint(currentActiveTab.toString());
    notifyListeners();
  }

  void handleCurrentImagePage(int index) {
    currentImagePage = imagePageController.page!.round();
    notifyListeners();
  }

  void handleCurrentSingleRecipe(int index) {
    currentSingleRecipe = singleRecipePageController.page!.round();
    notifyListeners();
  }

  bool checkIsVideo(String url) {
    String urlExt = url.split(".").last.toLowerCase();
    if (urlExt == "mp4") {
      return true;
    } else {
      return false;
    }
  }

  void skipByDuration(Duration duration,
      VideoPlayerController videoPlayerController, String type) {
    final newPosition;
    if (type == "next") {
      newPosition = videoPlayerController.value.position + duration;
    } else {
      newPosition = videoPlayerController.value.position - duration;
    }

    final maxDuration = videoPlayerController.value.duration;

    // Ensure newPosition is within the valid range
    if (newPosition >= Duration.zero && newPosition <= maxDuration) {
      videoPlayerController.seekTo(newPosition);
    }
    notifyListeners();
  }

  bool getReaction(String id) => manageReaction[id] ? true : false;
  int getReactionCount(String id) {
    debugPrint(id);
    if (countReaction.containsKey(id)) {
      return countReaction[id];
    } else {
      return 0;
    }
  }

  int getShareReactionCount(String id) {
    if (shareRecipeCount.containsKey(id)) {
      return shareRecipeCount[id];
    } else {
      return 0;
    }
  }

  void likeRecipie(String id, String userId, AnimationController controller,
      {bool isShare = false}) async {
    debugPrint("id = " + id);
    try {
      final response =
          await http.post(Uri.parse(baseURL + "/like-recipe"), body: {
        "reactorId": userId,
        "recipeId": id,
      });
      final data = jsonDecode(response.body);
      if (data['statusCode'] != 200) {
        showmessage(data['message'], bgColor: Colors.red);
        if (data['statusCode'] == 400) {
          controller.reverse();
        }
        handleReactChangeUi(int.parse(id), false);
      } else {
        showmessage(data['message']);
        handleReactChangeUi(int.parse(id), true);
        controller.forward();
      }
      debugPrint(data.toString());
    } on Exception catch (e) {
      showmessage("Exception has occured: " + e.toString());
    }

    notifyListeners();
  }

  // void shareRecipie(String id) {
  //   try {
  //     if (shareRecipeCount.containsKey(id)) {
  //       shareRecipeCount[id] += 1;
  //     } else {
  //       shareRecipeCount[id] = 1;
  //     }
  //   } on Exception catch (e) {
  //     showmessage("Exception occured : " + e.toString());
  //   }
  //   loadRecipe();
  //   notifyListeners();
  // }

  void handleupopUpButton(int index) {}
  void clearField() {
    searchController.clear();
    searchNode.unfocus();
  }

  void searchRecipe(String q) async {
    _searchItems.clear();
    final response = await http.get(
      Uri.parse(baseURL + "/search-recipe?q=${q}"),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final recipedata = data['recipe'];
      debugPrint(recipedata.toString());
      for (var item in recipedata) {
        _searchItems.add(RecipeItem.fromJson(item));
      }
    }
    notifyListeners();
  }

  void clearCreateRecipieField() {
    titlenode.unfocus();
    hastagnode.unfocus();
    ingredientsNode.unfocus();
    descriptionNode.unfocus();
    stepsNode.unfocus();
    notifyListeners();
  }

  void pickImage(ImageSource s, {bool isProfile = false}) async {
    try {
      final ImagePicker picker = ImagePicker();
      if (isProfile) {
        profile = await picker.pickImage(source: s);
      } else {
        imageFile = (await picker.pickMultiImage());
        if (imageFile!.isEmpty) {
          showmessage("No image selected");
        } else {
          handleImage();
          hasimages = true;
          debugPrint(imageFile.toString());
        }
      }
    } on Exception catch (e) {
      showmessage("Exception occured : " + e.toString());
      debugPrint("Exception occured : " + e.toString());
    }
    notifyListeners();
  }

  List image = [];
  void handleImage() async {
    if (imageFile!.isNotEmpty) {
      for (var img in imageFile!) {
        image.add(
            await Dio.MultipartFile.fromFile(img.path, filename: img.path));
      }
      debugPrint("image ha" + image.toString());
    }
    notifyListeners();
  }

  void postRecipe(BuildContext context) async {
    debugPrint("image" + image.toString());
    try {
      handleImage();
      Dio.FormData formData = await Dio.FormData.fromMap({
        "image": image,
        "title": titlecontroller.text,
        "description": descriptionController.text,
        "ingredients": ingredientsController.text,
        "steps": stepsController.text,
        "hastags": hastagController.text,
        "email": email
      });
      debugPrint(formData.fields.asMap().toString());
      var response;
      var dio = Dio.Dio();
      response = await dio.post(baseURL + "/upload-recipe",
          data: formData,
          onSendProgress: (count, total) {
            progress = count / total;
            notifyListeners();
            debugPrint(
                "count: " + count.toString() + " total: " + total.toString());
          },
          queryParameters: {"query": "test"},
          options: Dio.Options(
            validateStatus: (status) {
              if (status == 200) {
                debugPrint("success: " + status.toString());
                return true;
              } else {
                return false;
              }
            },
          ));
      final responseData = response.data;

      if (responseData['statusCode'] == 200) {
        showmessage(responseData['message']);
      } else {
        showmessage(responseData['message'], bgColor: Colors.red);
      }
    } on Exception catch (e) {
      showmessage("Exception occured : " + e.toString());
      debugPrint("Exception occured : " + e.toString());
    }
    image.clear();
    progress = 0;
    titlecontroller.clear();
    descriptionController.clear();
    hastagController.clear();
    stepsController.clear();
    ingredientsController.clear();
    titlenode.unfocus();
    descriptionNode.unfocus();
    stepsNode.unfocus();
    ingredientsNode.unfocus();
    hastagnode.unfocus();
    Navigator.pop(context);
  }

  void deleteSelectedImage(int index) {
    imageFile!.removeAt(index);
    if (imageFile!.isEmpty) {
      hasimages = false;
    }
    notifyListeners();
  }

  void loadRecipe() async {
    try {
      isLoading = true;
      _items = [];
      final response = await http.get(Uri.parse(baseURL + "/get-recipe"));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final recipedata = data['recipe'];

        for (var item in recipedata) {
          _items.add(RecipeItem.fromJson(item));
        }
        debugPrint(recipedata.toString());
        showmessage("Recipe loaded successfully");
        Future.delayed(Duration(seconds: 2), () {
          toggleLoading();
        });
      } else {
        showmessage("Something went wrong.");
      }
    } on Exception catch (e) {
      debugPrint("exception occured : " + e.toString());
      showmessage("exception occured : " + e.toString(), bgColor: Colors.red);
    }
    bool isReact = isAlreadyReact(20, 29);
    debugPrint("isReact : " + isReact.toString());
    notifyListeners();
  }

  void toggleLoading() {
    isLoading = false;
    notifyListeners();
  }

  bool isAlreadyReact(
    int userId,
    int recipeId,
  ) {
    for (var item in _items) {
      for (var userReaction in item.reaction!) {
        final user = userReaction.user;
        if (userId == user.pk && recipeId == userReaction.recipeId) {
          debugPrint("User $userId has reacted to recipe $recipeId");
          return true;
        }
      }
    }
    debugPrint("User $userId has not reacted to recipe $recipeId");
    return false;
  }

  void handleReactChangeUi(int id, bool up) {
    for (var data in _items) {
      if (data.pk == id) {
        if (up) {
          data.totalReact = 1 + data.totalReact!;
        } else
          data.totalReact = data.totalReact! - 1;
        notifyListeners();
      }
    }
  }

  void loadComments(int pk) async {
    _comments.clear();
    final response = await http.get(Uri.parse(baseURL + "/loadComment?pk=$pk"));
    final data = jsonDecode(response.body);
    if (data['statusCode'] == 200) {
      final comment = data['comments'];
      for (var item in comment) {
        _comments.add(Comment.fromJson(item));
        showmessage(
          data['message'],
        );
      }
    }
    if (data['statusCode'] == 404) {
      showmessage("${data['message']}", bgColor: Colors.red);
    } else {
      showmessage(
        "${data['message']}",
      );
    }
    notifyListeners();
  }

  Map<String, bool> showMoreMap = {};

  bool isShowMore(String text) {
    if (showMoreMap.containsKey(text)) {
      return showMoreMap[text]!;
    }
    return text.length > 150;
  }

  void toggleShowMore(String text) {
    if (showMoreMap.containsKey(text)) {
      showMoreMap[text] = !showMoreMap[text]!;
    } else {
      showMoreMap[text] = false;
    }
    notifyListeners();
  }

  void postComment(int pk, int userId, ScrollController controller) async {
    debugPrint(pk.toString());
    if (textEditingController.text.isNotEmpty &&
        textEditingController.text.trim().isNotEmpty) {
      final response =
          await http.post(Uri.parse(baseURL + "/comment-recipe"), body: {
        "recipeId": pk.toString(),
        "userId": userId.toString(),
        "comment": textEditingController.text
      });
      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        showmessage(data['message']);
        final lastComment = data['comment'];
        _comments.add(Comment.fromJson(lastComment));
        increaseCommentCount(pk);
        if (controller.hasClients) {
          controller.animateTo(
            controller.position.maxScrollExtent + 70,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        notifyListeners();
        textEditingController.clear();
      } else {
        showmessage(data['message'], bgColor: Colors.red);
      }
    } else {
      return;
    }
    focusNode.unfocus();
  }

  void increaseCommentCount(int recipePk) {
    for (var recipe in _items) {
      if (recipe.pk == recipePk) {
        if (recipe.totalComment != null) {
          recipe.totalComment = 1 + recipe.totalComment!;
        }
        notifyListeners();
      }
    }
  }

  void changeProfile(int userId) async {
    final file = await Dio.MultipartFile.fromFile(profile!.path,
        filename: profile!.path);
    Dio.FormData formData = await Dio.FormData.fromMap({
      "image": file,
      "userId": userId,
    });
    var response;
    final dio = Dio.Dio();
    response = await dio.post(baseURL + "/change-profile", data: formData);
    if (response.data['statusCode'] == 200) {
      showmessage("Profile changed successfully");
    } else {
      showmessage("Something went wrong.Please try again", bgColor: Colors.red);
    }
    profile = null;
    notifyListeners();
  }

  void shareRecipe(String recipeId, String userId) async {
    final response = await http.post(Uri.parse(baseURL + "/share-recipe"),
        body: {
          "recipeId": recipeId,
          "userId": userId,
          "title": "this is itle"
        });
    final data = await jsonDecode(response.body);
    if (data['statusCode'] == 200) {
      showmessage(data['message']);
    } else {
      showmessage(data['message'], bgColor: Colors.red);
    }
    loadRecipe();
    notifyListeners();
  }
}
