import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/controller/constraints.dart';
import 'package:frontend/utils/smalltext.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../provider/myProvider.dart';

class videoplayer extends StatefulWidget {
  const videoplayer({super.key, required this.url});
  final String url;
  @override
  State<videoplayer> createState() => _videoplayerState();
}

class _videoplayerState extends State<videoplayer> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    try {
      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse('https://download.samplelib.com/mp4/sample-5s.mp4'))
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            videoPlayerController.play();
          });
        });
    } on Exception catch (e) {
      debugPrint("Exception has occurred" + e.toString());
    }
    super.initState();
  }

  @override
  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
        final p = Provider.of<myProvider>(context, listen: false);

    return Container(
        child: videoPlayerController.value.isInitialized
            ? Stack(
  alignment: Alignment.center,
  children: [
    AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: VideoPlayer(videoPlayerController),
    ),
    GestureDetector(
      onTap: () {
        if (videoPlayerController.value.isPlaying) {
          videoPlayerController.pause();
          setState(() {
            
          });
        } else {
          videoPlayerController.play();
          setState(() {
            
          });
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround  ,
        children: [
          InkWell(onTap: (){
            p.skipByDuration(
              Duration(seconds: 10), videoPlayerController,"back");
          },child: Icon(Icons.skip_previous,color: constraints.colorWhite ,size: 30,),),
          Container(
            // color: Colors.black.withOpacity(0.2),
            // width: videoPlayerController.value.aspectRatio,
            child: Center(
              child: Icon(
                videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 60.0,
                color: Colors.white,
              ),
            ),
          ),
         InkWell(onTap: (){
            p.skipByDuration(
              Duration(seconds: 10), videoPlayerController,"next");
         },child: Icon(Icons.skip_next,color: constraints.colorWhite ,size: 30,),),
        ],
      ),
    ),
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: videoPlayerController.value.position.inMilliseconds /
                videoPlayerController.value.duration.inMilliseconds,
                
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(constraints.primaryColor),
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              smalltext(
                text: videoPlayerController.value.position.toString().split('.')[0],
                weight: FontWeight.bold,
                color: constraints.colorWhite,
              ),
              smalltext(
                color: constraints.colorWhite,
                text: (videoPlayerController.value.duration - videoPlayerController.value.position).toString().split('.')[0],
                weight: FontWeight.bold,
              ),
            ],
           )
        ],
      ),
    ),
  ],
)

            : Container());
  }
}
