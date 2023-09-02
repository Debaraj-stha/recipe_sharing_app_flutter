import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/pages/accountPage.dart';
import 'package:frontend/pages/discoverPage.dart';
import 'package:frontend/pages/homepage1.dart';
import 'package:frontend/pages/searchPage.dart';
import 'package:frontend/utils/toastmessage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:http/http.dart' as http;

import '../controller/dbcontroller.dart';
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
  List<RecipeItem> specificUserRecipe = [];
  Map<String,dynamic> selectedrecipeforDelete = {};
  bool isUserBack = false;
  List<Follower> followers = [];
  List<Follower> followings = [];
  List<FollowerCount> followerCount = [];
  Map<String, dynamic> followedText = {};
  // final _dbcontroller=new dbController();
  List<RecipeItem> savedRecipe = [];
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
    // _dbcontroller.dispose();
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

  void handleupopUpButton(int index, BuildContext context) {
    switch (index) {
      case 1:
        currentActiveTab = 0;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => homePage1()));

        break;
      case 2:
        currentActiveTab = 1;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => discoverPage()));
        break;
      case 3:
        currentActiveTab = 2;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => searchPage()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => accountPage()));
        break;
      // case 5:

      // // Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage1()));
      // break;
      // case 6:
      // // Navigator.push(context, MaterialPageRoute(builder: (context)=>homePage1()));
      // break;
    }

    notifyListeners();
  }

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
      if (_items.isEmpty) {
        isLoading = true;
        _items = [];
        final response = await http.get(Uri.parse(baseURL + "/get-recipe"));
        final data = jsonDecode(response.body);

        if (response.statusCode == 200) {
          final recipedata = data['recipe'];

          for (var item in recipedata) {
            _items.add(RecipeItem.fromJson(item));
            savedRecipe.add(RecipeItem.fromJson(item));
          }
          // debugPrint(recipedata.toString());
          showmessage("Recipe loaded successfully");
          Future.delayed(Duration(seconds: 2), () {
            toggleLoading();
          });
        } else {
          showmessage("Something went wrong.");
        }
        notifyListeners();
      }
    } on Exception catch (e) {
      debugPrint("exception occured : " + e.toString());
      showmessage("exception occured : " + e.toString(), bgColor: Colors.red);
    }
    bool isReact = isAlreadyReact(20, 29);
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

  void getFollowUser(String userId) async {
    try {
      followers.clear();
      final response = await http
          .get(Uri.parse(baseURL + "/get-follow-user?userId=$userId"));
      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        final followerList = data['followers'];
        debugPrint(followerList.toString());
        for (var follower in followerList) {
          // debugPrint("user: " + follower.toString());
          followers.add(Follower.fromJson(follower));
        }
        notifyListeners();
      } else {
        showmessage(data['message'], bgColor: Colors.red);
      }
    } on Exception catch (e) {
      showmessage("Something went wrong.Message: " + e.toString());
    }
  }

  void getFollowing(String userId) async {
    try {
      followings.clear();
      final response = await http
          .get(Uri.parse(baseURL + "/get-following-user?userId=$userId"));
      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        final followingList = data['followings'];
        // debugPrint("following" + followingList.toString());
        for (var following in followingList) {
          followings.add(Follower.fromJson(following));
        }
        notifyListeners();
      } else {
        showmessage(data['message'], bgColor: Colors.red);
      }
    } on Exception catch (e) {
      showmessage("Something went wrong.Message: " + e.toString());
    }
  }

  void followUser(String follower, String following, String followerId) async {
// following=me
// follower=user
    try {
      debugPrint("f" + follower);
      debugPrint("fol" + following);
      debugPrint("foloowerid" + followerId);
      final response = await http.post(Uri.parse(baseURL + "/follow-user"),
          body: {"follower": follower, "following": following});
      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        showmessage(data['message']);
        // followers.removeWhere((element) => element.id==int.parse(following));
        final followedUser = data['followedUser'];
        followings.add(Follower.fromJson(followedUser));
        handleFollowedText(followerId, "Following");
        debugPrint(followedText.toString());
        notifyListeners();
      } else {
        showmessage(data['message'], bgColor: Colors.red);
      }
    } on Exception catch (e) {
      showmessage("Something went wrong.Message: " + e.toString());
    }
  }

  void unfollowUser(String id) async {
// following=me
// follower=user
    try {
      final response =
          await http.post(Uri.parse(baseURL + "/unfollow-user"), body: {
        "pk": id,
      });
      debugPrint(id);
      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        showmessage(data['message']);
        followings.removeWhere((element) => element.id == int.parse(id));
        notifyListeners();
      } else {
        showmessage(data['message'], bgColor: Colors.red);
      }
    } on Exception catch (e) {
      showmessage("Something went wrong.Message: " + e.toString());
    }
  }

  void getSpecificuserRecipe(String userId) async {
    try {
      final response = await http
          .get(Uri.parse(baseURL + "/get-user-recipe?userId=$userId"));
      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        var recipe = data['recipe'];
        var followerFollowing = data['followerFollowing'];
        for (var item in recipe) {
          specificUserRecipe.add(RecipeItem.fromJson(item));
        }
        debugPrint(followerFollowing.toString());
        followerCount.add(FollowerCount.fromJson(followerFollowing));
        notifyListeners();
      } else {
        showmessage(data['message'], bgColor: Colors.red);
      }
    } on Exception catch (e) {
      showmessage("Something went wrong.Message: " + e.toString());
    }
  }

  void handleisBack() {
    isUserBack = !isUserBack;
    notifyListeners();
  }

  String chnageFollowedText(String id, String text) {
    if (followedText.containsKey(id)) {
      debugPrint("listend if");
      return followedText[id];
    } else {
      followedText[id] = text;
      debugPrint("listednde else");
      return followedText[id];
    }
  }

  void handleFollowedText(String id, String text) {
    followedText[id] = text;
    notifyListeners();
  }

  void saveRecipe(int pk) {
    try {
      RecipeItem item = getRecipeContentFromId(pk);
      // _dbcontroller.insertRecipe(item).then((value){
      //   if(value){
      //     showmessage("Recipe saved successfully");
      //   }
      //   else{
      //      showmessage(" Something went wrong while saving Recipe saved successfully");
      //   }
      // });
      notifyListeners();
    } on Exception catch (e) {
      showmessage(e.toString());
    }
  }

  RecipeItem getRecipeContentFromId(int id) {
    try {
      return _items.firstWhere((item) => item.pk == id);
    } catch (e) {
      return _items[0];
    }
  }

  void getSavedRecipe() async {
    try {
// savedRecipe=await _controller.getRecipe();
      notifyListeners();
    } catch (e) {
      showmessage(e.toString());
    }
  }

  void deleteSavedRecipe(int pk) async {
    try {
// await _controller.deleteRecipe(pk).then((val){
//   if(val){
//     showmessage('recipe deleted successfully ');
//     savedRecipe.removeWhere((element) => element.pk==pk);
//   }
//   else{
//     showmessage("Something went wrong while deleting recipe");
//   }
// })
      notifyListeners();
    } catch (e) {
      showmessage(e.toString());
    }
  }

  void blockUser(String userId, String blockedUserId) async {
    try {
      final response = await http.post(Uri.parse(baseURL + "/block-user"),
          body: {"userId": userId, "blockedUserId": blockedUserId});
      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        showmessage(data['message']);
      } else {
        showmessage(data['message'], bgColor: Colors.red);
      }
    } catch (e) {
      showmessage(e.toString());
    }
  }

  void reportToContent(String contentPk, String reporterId) async {
    try {
      final response = await http.post(Uri.parse(baseURL + "/report-content"),
          body: {"recipeId": contentPk, "reporterId": reporterId});
      final data = jsonDecode(response.body);
      if (data['statusCode'] == 200) {
        showmessage(data['message']);
      } else {
        showmessage(data['message'], bgColor: Colors.red);
      }
    } catch (e) {
      showmessage(e.toString());
    }
  }
  
  bool getSelectedRecipeForDelete(String index)=>selectedrecipeforDelete[index]??false;
  void handleSelectedRecipe(String index,bool value){
    if(selectedrecipeforDelete.containsKey(index)){
      selectedrecipeforDelete[index]=!selectedrecipeforDelete[index];
    }
    else{
      selectedrecipeforDelete[index]=value;
    }
    notifyListeners();
  }
}
