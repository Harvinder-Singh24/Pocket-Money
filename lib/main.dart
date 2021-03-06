import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:pmoney/Main/home.dart';
import 'package:pmoney/Services/shared_pref_ser.dart';
import 'Verification/main_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pmoney/Services/scroll_glow.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.lato().fontFamily,
          primarySwatch: Colors.blue,
        ),
        home:
            ScrollConfiguration(behavior: MyBehavior(), child: const MyHome()),
      ),
    );
  }
}

SharedPref pref = SharedPref();

class MyHome extends StatefulWidget {
  const MyHome({key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();

    pref.read_data("number").then((value) => {
          if (value == null)
            {
              Timer(
                  const Duration(seconds: 6),
                  () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Main_verify())))
            }
          else
            {
              Timer(
                  const Duration(seconds: 6),
                  () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (scontext) => Home())))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 300.w,
              height: 300.h,
              child: Lottie.asset('assest/anim/animation.json'),
            ),
          ),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Pocket Money',
                textStyle: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
