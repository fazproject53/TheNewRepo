import 'package:celepraty/Models/Methods/method.dart';
import 'package:celepraty/Models/Variables/Variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class viewData extends StatefulWidget {
  const viewData({Key? key}) : super(key: key);

  @override
  State<viewData> createState() => _viewDataState();
}

class _viewDataState extends State<viewData> {
  late VideoPlayerController _videoPlayerController;
  bool clicked = false;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
        'assets/video/don.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.setLooping(true);
        _videoPlayerController.play();
        _videoPlayerController.setVolume(1.0);

      });


  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: black.withOpacity(0.30),
        appBar: drowAppBar('', context,color:black.withOpacity(0.02) ),
    body: Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: getSize(context).height/9),
                  height: 400.h,child: _videoPlayerController.value.isInitialized ? VideoPlayer(_videoPlayerController) : Container()),

              VideoProgressIndicator(
                _videoPlayerController,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                    backgroundColor: pink,
                    bufferedColor: black,
                    playedColor: purple),
              )
            ],
          ),
          onTap: (){setState(() {
            clicked? _videoPlayerController.play(): _videoPlayerController.pause();
            clicked = clicked? false: true;
          });},
        ),
        clicked? Padding(
          padding:  EdgeInsets.only(right: 70.w),
          child: IconButton(onPressed: (){
          }, icon: Icon(playViduo, size:120,color: white,),),
        ): const SizedBox()
      ],
    ), );
  }
}
