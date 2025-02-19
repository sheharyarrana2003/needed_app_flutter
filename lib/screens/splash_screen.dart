import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:needed_app/firebaseoptions.dart';
import 'package:needed_app/screens/admin_screen.dart';
import 'package:needed_app/screens/logIn_screen.dart';
import 'package:needed_app/screens/navigation_menu.dart';
import 'package:needed_app/screens/pendingScreen.dart';
import 'package:needed_app/screens/rejectedScreen.dart';
import '../variables/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 6));

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
    } else {
      if (user.email == "admin@neededapp.com") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminVerificationPage()),
        );
        return;
      }

      try {
        DocumentSnapshot userDoc = await Firebaseoptions.workerCollections
            .doc(user.uid)
            .get();

        String status = userDoc["status"] ?? "pending";

        if (status == "approved") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavigationMenu()),
          );
        } else if (status == "pending") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PendingScreen()),
          );
        } else if (status == "rejected") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RejectedScreen()),
          );
        } else {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LogInScreen()),
          );
        }
      } catch (e) {
        print("Error fetching user status: $e");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LogInScreen()),
        );
      }
    }
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
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Needed",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color: blueColor,
              ),
            ),
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
