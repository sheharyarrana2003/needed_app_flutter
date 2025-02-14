import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:needed_app/firebaseoptions.dart';
import 'package:needed_app/screens/logIn_screen.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/customWidgets/textField.dart';
import 'package:needed_app/screens/navigation_menu.dart';
import 'package:needed_app/screens/pendingScreen.dart';
import 'package:needed_app/variables/colors.dart';

class WorkerSignup extends StatefulWidget {
  const WorkerSignup({super.key});

  @override
  State<WorkerSignup> createState() => _WorkerSignupState();
}

class _WorkerSignupState extends State<WorkerSignup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();

  File? file;
  final ImagePicker imagePicker = ImagePicker();
  String? workerType;
  bool isLoading = false;

  List<String> types = [
    "Plumber",
    "Electrician",
    "Carpenter",
    "Painter",
    "Mason",
    "Labour"
  ];

  Future<void> _selectedImage() async {
    final XFile? pickedFile =
    await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

      if (image != null) {
        img.Image resizedImage = img.copyResize(image, width: 400);
        final resizedFile = File(pickedFile.path)
          ..writeAsBytesSync(img.encodeJpg(resizedImage));

        setState(() {
          file = resizedFile;
        });
      }
    }
  }

  Future<void> _signUpWorker() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: "${_phoneController.text}@neededapp.com",
            password: _passController.text);

        String userId = userCredential.user!.uid;

        await Firebaseoptions.workerCollections.doc(userId).set({
          "uid":userId,
          "name": _nameController.text.toString(),
          "phone": _phoneController.text.toString(),
          "cnic": _cnicController.text.toString(),
          "category": workerType.toString(),
          "status": "pending",
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PendingScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign up failed: $e")),
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Worker Signup',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: blueColor,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 65,
                      backgroundImage: file != null ? FileImage(file!) : null,
                      child: file == null
                          ? Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: _selectedImage,
                        icon: const Icon(Icons.add_a_photo),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              buildTextField("Name", _nameController, Icons.person, (value) {
                if (value == null || value.isEmpty) return "Enter name";
                return null;
              }),
              const SizedBox(height: 16),
              buildTextField("Phone Number", _phoneController, Icons.phone,
                      (value) {
                    if (value == null || value.isEmpty) return "Enter phone number";
                    return null;
                  }),
              const SizedBox(height: 16),
              buildTextField("CNIC", _cnicController, Icons.numbers, (value) {
                if (value == null || value.isEmpty) return "Enter CNIC";
                return null;
              }),
              const SizedBox(height: 16),
              buildTextField("Password", _passController, Icons.lock, (value) {
                if (value == null || value.isEmpty) return "Enter password";
                return null;
              }),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: workerType,
                items: types.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    workerType = newValue;
                  });
                },
                decoration: InputDecoration(labelText: "Category"),
                validator: (value) =>
                value == null ? "Select a category" : null,
              ),
              const SizedBox(height: 20),
              Center(
                child: isLoading
                    ? CircularProgressIndicator()
                    : CustomButton(
                  height: 50,
                  width: 160,
                  color: blueColor,
                  text: "Sign Up",
                  opacity: 0.5,
                  fontSize: 18,
                  onTap: _signUpWorker,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ", style: TextStyle(fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LogInScreen()),
                        );
                      },
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: blueColor,
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
    );
  }
}