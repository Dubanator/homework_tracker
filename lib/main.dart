import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './pages/login_screen.dart';
import './pages/main_screen.dart';
import './pages/course_detail.dart';
import './pages/course_new_screen.dart';
import './pages/homework_new_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

void main() => runApp(HomeworkTrackerApp());

class HomeworkTrackerApp extends StatefulWidget {
  @override
  _HomeworkTrackerAppState createState() {
    return _HomeworkTrackerAppState();
  }
}

class _HomeworkTrackerAppState extends State<HomeworkTrackerApp> {
  FirebaseUser user;
  bool gotUser = false;

  _HomeworkTrackerAppState() {
    _auth.currentUser().then((newUser) {
      setState(() {
        user = newUser;
        gotUser = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget firstScreen = Scaffold();

    if (gotUser) {
      if (user != null) {
        firstScreen = MainScreen();
      } else {
        firstScreen = LoginScreen();
      }
    }

    return MaterialApp(
      home: firstScreen,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginScreen(),
        '/main': (BuildContext context) => MainScreen(),
        '/course-detail': (BuildContext context) => CourseDetail(),
        '/course-creation': (BuildContext context) => CourseNewScreen(),
        '/homework-creation': (BuildContext context) => HomeworkNewScreen()
      },
      theme: ThemeData.dark(),
    );
  }
}
