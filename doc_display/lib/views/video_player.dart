import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:video_player/video_player.dart';


class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  TextEditingController controller = TextEditingController();
  late VideoPlayerController _controller;
  String videoPath =
      '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/crepePaper.wmv';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(videoPath))
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(children: <Widget>[
      mat.Material(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      const SizedBox(
        height: 15,
      ),
      TextBox(
          controller: controller,
          header: 'Path to media',
          padding: const EdgeInsetsDirectional.only(start: 30),
          placeholder: videoPath,
          outsideSuffix: Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? mat.Icons.pause
                        : mat.Icons.play_arrow,
                  ),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      videoPath = controller.text;
                    }
                    controller.text = videoPath;
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  }))),
    ]);
  }
  // Widget build(BuildContext context) {
  //   return mat.Material(
  //     title: 'Video Demo',
  //     home: Scaffold(
  //       body: Center(
  //         child: _controller.value.isInitialized
  //             ? AspectRatio(
  //                 aspectRatio: _controller.value.aspectRatio,
  //                 child: VideoPlayer(_controller),
  //               )
  //             : Container(),
  //       ),
  //       floatingActionButton: FloatingActionButton(
  //         onPressed: () {
  //           setState(() {
  //             _controller.value.isPlaying
  //                 ? _controller.pause()
  //                 : _controller.play();
  //           });
  //         },
  //         child: Icon(
  //           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }
}
