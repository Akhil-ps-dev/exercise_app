import 'dart:async';
import 'package:audioplayer/audioplayer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/screens/exercise_hub.dart';
import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercises exercises;

  final int seconds;

  ExerciseScreen({required this.exercises, required this.seconds});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late bool _isCompleted = false;
  late int _elapsedSeconds = 0;

  late Timer timer;

  
  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (t) {
        if (t.tick == widget.seconds) {
          t.cancel();
          setState(() {
            _isCompleted = true;
          });
        }

        setState(() {
          _elapsedSeconds = t.tick;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              imageUrl: widget.exercises.gif,
              placeholder: (context, url) => Image(
                image: AssetImage("assets/placeholder.png"),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          _isCompleted != true
              ? SafeArea(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text("$_elapsedSeconds/${widget.seconds} s"),
                  ),
                )
              : Container(),
          Container(),
          SafeArea(
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
