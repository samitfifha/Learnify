import 'package:flutter/material.dart';
import 'package:learnifyflutter/Welcome%20Screens/mainscreen.dart';
import 'package:learnifyflutter/Courses%20Screens/screen2.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Chewielistitem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final object;
  final bool looping;
  Chewielistitem(
      {required this.videoPlayerController,
      this.looping = false,
      required this.object,
      Key? key})
      : super(key: key);

  @override
  State<Chewielistitem> createState() => _ChewielistitemState();
}

class _ChewielistitemState extends State<Chewielistitem> {
  late ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoInitialize: true,
      looping: widget.looping,
      fullScreenByDefault: true,
      allowFullScreen: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.amber),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal, Colors.indigo],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
        title: Text(
          widget.object.title.toString(),
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => Screen2(myObject: widget.object),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Chewie(
                controller: _chewieController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
