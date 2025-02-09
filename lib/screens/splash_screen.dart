import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:needed_app/screens/worker_signup.dart';

import '../variables/colors.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 6000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkerSignup()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
            child: Center(
              child: Image.asset(
                "assets/Images/app_icon.png",
                height: 200,
                width: 200,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "Needed",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: blueColor)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  'Find, Book, and Relax. We Handle the Rest!',
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: blueColor.withOpacity(0.9),
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
