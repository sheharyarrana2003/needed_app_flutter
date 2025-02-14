import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/customWidgets/textField.dart';
import 'package:needed_app/firebaseoptions.dart';
import 'package:needed_app/screens/admin_screen.dart';
import 'package:needed_app/screens/navigation_menu.dart';
import 'package:needed_app/screens/pendingScreen.dart';
import 'package:needed_app/screens/rejectedScreen.dart';
import 'package:needed_app/screens/worker_signup.dart';
import 'package:needed_app/variables/colors.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );

      final String userId = userCredential.user!.uid;

      if (_emailController.text.trim() == "admin@neededapp.com") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminVerificationPage()),
        );
      } else {
        final DocumentSnapshot userDoc = await Firebaseoptions.workerCollections
            .doc(userId)
            .get();

        if (!userDoc.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User not found in database")),
          );
          return;
        }

        final String status = userDoc.get('status') ?? 'pending';

        if (status == 'approved') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavigationMenu()),
          );
        } else if (status == 'pending') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PendingScreen()),
          );
        } else if (status == 'rejected') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RejectedScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                      fontSize: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                buildTextField(
                  "Email",
                  _emailController,
                  Icons.email,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildTextField(
                  "Password",
                  _passController,
                  Icons.lock,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                    height: 50,
                    width: 160,
                    color: blueColor,
                    text: "Log In",
                    opacity: 0.8,
                    fontSize: 18,
                    onTap: _login,
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkerSignup(),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
