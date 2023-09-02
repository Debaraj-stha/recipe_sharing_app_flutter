// import 'dart:async';
// import 'dart:convert';
// import 'dart:isolate';
// import 'dart:ui';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_all/homepage.dart';
// import 'package:flutter_all/login.dart';
// import 'package:flutter_all/loginWithPhone.dart';
// import 'package:flutter_all/signUp.dart';
// import 'package:flutter_all/model/airline.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:number_paginator/number_paginator.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:http/http.dart' as http;
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class slidePannel extends StatefulWidget {
//   const slidePannel({super.key});

//   @override
//   State<slidePannel> createState() => _slidePannelState();
// }

// class _slidePannelState extends State<slidePannel> {
//   @override
//   bool isChecked = false;
//   int groupValue = 0;
//   @override
//   Future<void> _handleSignIn() async {
//     GoogleSignIn _googleSignIn = GoogleSignIn();
//     try {
//       var result = await _googleSignIn.signIn();
//       // print(result);
//     } catch (error) {
//       // print(error);
//     }
//   }

//   Future<void> facebookLogin() async {
//     final LoginResult result = await FacebookAuth.instance.login(
//       permissions: [
//         'public_profile',
//         'email',
//         'pages_show_list',
//         'pages_messaging',
//         'pages_manage_metadata'
//       ],
//     ).then((value) async {
//       await FacebookAuth.instance.getUserData().then((data) {
//         // print(data);
//       });
//       throw Exception("n");
//     });
//     // print(LoginResult);
// // or
// // FacebookAuth.i.login(
// //   permissions: ['public_profile', 'email', 'pages_show_list', 'pages_messaging', 'pages_manage_metadata'],
// // )
//   }
//   // ReceivePort receiverPort=ReceivePort();
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();

//   //    IsolateNameServer.registerPortWithName(receiverPort.sendPort, "download");
//   //     receiverPort.listen((message) {
//   //       print(message.progress);
//   //     });
//   //  FlutterDownloader.registerCallback(downloadCallBack );
//   // }
//   // void downloadFile()async{
//   //   String url="https://www.pexels.com/video/couple-walking-together-8465759/";
//   //   final status=await Permission.storage.request();
//   //   if(status.isGranted){
//   //     final baseStorage=await getExternalStorageDirectory();
//   //     final id=FlutterDownloader.enqueue(url: url, savedDir:baseStorage!.path,fileName:  "${DateTime.now()}download",openFileFromNotification: true,showNotification: true);

//   //   }
//   // }
//   //  static downloadCallBack(id,status,progress){
//   //   SendPort? sendport=IsolateNameServer.lookupPortByName("download");
//   //   sendport?.send(progress);
//   // }
//   final PageController pageController=PageController();
//    void initState() {
//     // TODO: implement initState
//     super.initState();
//   currentPage=1;
//   Timer(Duration(microseconds: 0), () {
// isLogin(context);
//    });
  
//         _pages=List.generate((passenger.length /itemPerPage).ceil(),(index)=>passenger.sublist(index*itemPerPage,(index+1)*itemPerPage));
//     fetchdata();
     
//   }
//   int limit = 5;
//   List<Products> passenger = [];
//    final int itemPerPage=2;
//        late int currentPage;
//        late List<List<Products>> _pages=[];
//   late int totalPage;
//   Future<bool> fetchdata({bool isRefresh = false}) async {
//     if (isRefresh) {
//       limit = limit + 5;
//     } else {
//       if (limit >= 20) {
//         refreshController.loadNoData();
//         return false;
//       }
//     }
//     final response = await http
//         .get(Uri.parse("https://fakestoreapi.com/products?limit=$limit"));
//     if (response.statusCode == 200) {
//       final result = productsFromJson(response.body);
//       if (isRefresh) {
//         passenger = result;
//       } else {
//         passenger.addAll(result);
//       }
//       print(passenger.length);
// _pages = List.generate((passenger.length / itemPerPage).ceil(), (index) {
//   final start = index * itemPerPage;
//   final end = (index + 1) * itemPerPage;
//   final sublistEnd = end < passenger.length ? end : passenger.length;
//   return passenger.sublist(start, sublistEnd);
// });


//         print("page" + _pages.toString());
//       limit += 5;
//     // =  pageControllerPageController(initialPage: currentPage);
//       setState(() {});
//         print(_pages);
//       return true;
//     } else {
//       return true;
//     }
//   }

//   final RefreshController refreshController =
//       RefreshController(initialRefresh: true);
//      void isLogin(BuildContext context)async{
//       final auth=FirebaseAuth.instance;
//       final user=await auth.currentUser;
//       if(user!=null){
//         Navigator.push(context,MaterialPageRoute(builder: (context)=>homepage()));
//       }
//       else{
//                 Navigator.push(context,MaterialPageRoute(builder: (context)=>homepage()));

//       }
//      }
//   @override
 
//   // instantiate the controller in your state
// final NumberPaginatorController _controller = NumberPaginatorController();

// void handlePageChange(int page){
//   setState(() {
//     currentPage=page;
//   });
// }
//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("SlidingUpPanelExample"),
//       ),
//       body: SlidingUpPanel(
//         minHeight: 100,
//         maxHeight: MediaQuery.of(context).size.height / 1.8,
//         panel: Column(
//           children: [
//             Container(
//                 height: 100,
//                 child: Center(
//                   child: Text(
//                     "slide up me",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                   ),
//                 )),
//             Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8)),
//                 ),
//                 child: Container(
//                   height: 300,
//                   child: SmartRefresher(
//                     enablePullUp: true,
//                     controller: refreshController,
//                     onRefresh: () async {
//                       final res = await fetchdata(isRefresh: true);
//                       if (res) {
//                         refreshController.refreshCompleted();
//                       } else {
//                         refreshController.refreshFailed();
//                       }
//                     },
//                     onLoading: () async {
//                       final res = await fetchdata();
//                       if (res) {
//                         refreshController.loadComplete();
//                       } else {
//                         refreshController.loadFailed();
//                       }
//                     },
//                     child: ListView.builder(
//                       itemBuilder: (context, i) {
//                         return ListTile(
//                           title: Text(passenger[i].title),
//                           subtitle: Text(passenger[i].description),
//                         );
//                       },
//                       itemCount: passenger.length,
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//         body: Column(
//           children: [
//             Text(passenger.length.toString()),
//             Container(
//               height: 100,
//               color: Colors.red,
//               child: PageView.builder(
//               itemCount: _pages.length,
//               controller: pageController,
//               onPageChanged: (int c){
//                 setState(() {
//                   currentPage=c+1;
//                   print(currentPage);
//                 });
//               },
//               physics: NeverScrollableScrollPhysics(),
//               itemBuilder: (BuildContext context, int index) {
//                 final page = _pages[index];
//                 print("called09");
//                 return ListView.builder(
//                   itemCount: page.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final product = page[index];
//                     print(product);
//                     print("called");
//                     return ListTile(
//                       title: Text(product.title),
//                       subtitle: Text(product.description),
//                       leading: Image.network(product.image),
//                       trailing: Text('\$${product.price}'),
//                     );
//                   },
//                 );
//               },
//             ),
//             ),
//             NumberPaginator(
//               controller: _controller,
//               config: NumberPaginatorUIConfig(
//                 buttonSelectedBackgroundColor: Colors.blue,
//                 buttonSelectedForegroundColor: Colors.white,
//                 buttonUnselectedBackgroundColor: Colors.black,
//                 buttonUnselectedForegroundColor: Colors.white,
//                 buttonShape: BeveledRectangleBorder()
//               ),
//               numberPages: _pages.length|4,
//               initialPage: 0,
//               // numberPagesVisible: 5,
//               // currentPage:currentPage,
//               // initialPage: (currentPage - 1).clamp(0, _pages.length - 1),
//               onPageChange: (int c){
//                 pageController.nextPage(duration: Duration(seconds: 1), curve:Curves.easeIn);
//                 setState(() {
//                   currentPage=c+1;
//                   print(currentPage);
//                 });
//               }
//             ),
//             Row(
//               children: [
//                 Checkbox(
//                   value: isChecked,
//                   onChanged: (newValue) {
//                     setState(() {
//                       isChecked = newValue!;
//                     });
//                   },
//                 ),
//                 Text("checkbox")
//               ],
//             ),
//             Row(
//               children: [
//                 Radio(
//                   value: 1,
//                   groupValue: groupValue,
//                   onChanged: (val) {
//                     setState(() {
//                       groupValue = val!;
//                     });
//                   },
//                 ),
//                 Text("1")
//               ],
//             ),
//             Row(
//               children: [
//                 Radio(
//                   value: 2,
//                   groupValue: groupValue,
//                   onChanged: (val) {
//                     setState(() {
//                       groupValue = val!;
//                     });
//                   },
//                 ),
//                 Text("2")
//               ],
//             ),
//             loginWithPhone(),
//             SignUp(),
//             Login(),
//             TextButton(
//                 onPressed: () {
//                   facebookLogin();
//                 },
//                 child: Text("Facebook login")),
//             TextButton(
//                 onPressed: () {
//                   _handleSignIn();
//                 },
//                 child: Text("Google login")),
//             TextButton(
//                 onPressed: () async {
//                   await FacebookAuth.instance.logOut();
// // or FacebookAuth.i.logOut();
//                 },
//                 child: Text("facebook logout")),
//             Center(
//               child: Text("This is the Widget behind the sliding panel"),
//             ),
//             Container(
//               height: 300,
//               child: ListView.builder(
//                 itemBuilder: (context, i) {
//                   return Dismissible(
//                     key: Key(i.toString()),
//                     child: ListTile(
//                       title: Text("item $i"),
//                     ),
//                     secondaryBackground: Container(
//                       color: Colors.red,
//                       child: Icon(Icons.delete),
//                     ),
//                     background: Container(
//                       color: Colors.green,
//                       child: Icon(Icons.restore),
//                     ),
//                     onDismissed: (direction) {
//                       if (direction == DismissDirection.endToStart) {
//                         //removed logiuc for item
//                         print("item removed");
//                       } else {
//                         //restore logic for item
//                         print("item restore");
//                       }
//                     },
//                   );
//                 },
//                 itemCount: 10,
//                 physics: NeverScrollableScrollPhysics(),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

 
// }