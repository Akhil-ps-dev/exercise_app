//@dart=2.9
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/screens/exercise_hub.dart';
import 'package:fitness_app/screens/exercise_start_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiURL =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  ExerciseHub exerciseHub;

  @override
  void initState() {
    getExercises();

    super.initState();
  }

  void getExercises() async {
    var response = await http.get(apiURL);
    var body = response.body;

    var decodedJson = jsonDecode(body);

    exerciseHub = ExerciseHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Exercise App",
          style: TextStyle(fontFamily: "lato"),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: exerciseHub != null
            ? ListView(
                children: exerciseHub.exercises.map((e) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExerciseStartScreen(exercises: e),
                        ),
                      );
                    },
                    child: Hero(
                      tag: e.id,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),

                              // child: CachedNetWorkImage(
                              //   child: FadeInImage(
                              //     image: NetworkImage(e.thumbnail),
                              //     placeholder:
                              //         AssetImage("assets/placeholder.png"),
                              //     width: MediaQuery.of(context).size.width,
                              //     height: 250,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              child: CachedNetworkImage(
                                imageUrl: e.thumbnail,
                                placeholder: (context, url) => Image(
                                  image: AssetImage("assets/placeholder.png"),
                                  fit: BoxFit.cover,
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                ),
                                errorWidget: (context , url , error) =>
                                Icon(Icons.error),
                                fit: BoxFit.cover,
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                              ),

                              
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF000000),
                                        Color(0x00000000),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center),
                                ),
                              ),
                            ),
                            Container(
                              height: 250,
                              padding: EdgeInsets.only(left: 10, bottom: 10),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                e.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "lato",
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            : LinearProgressIndicator(),
      ),
    );
  }
}
