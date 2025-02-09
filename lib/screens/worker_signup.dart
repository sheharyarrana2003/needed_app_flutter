import 'package:flutter/material.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/customWidgets/textField.dart';
import 'package:needed_app/screens/navigation_menu.dart';
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
  String? workerType;
  List<String> types = [
    "Plumber",
    "Electrician",
    "Carpenter",
    "Painter",
    "Mason",
    "Labour"
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: blueColor,
          title: const Center(
            child: Text(
              'Worker Signup',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 2.0, color: blueColor),
                      left: BorderSide(width: 2.0, color: blueColor),
                      right: BorderSide(width: 2.0, color: blueColor),
                      bottom: BorderSide(width: 2.0, color: blueColor),
                    ),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage("assets/Images/worker.jpg"),
                      fit: BoxFit.fill, // Change to contain, fill, etc.
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: buildTextField("Name", _nameController, Icons.person,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Name";
                  }
                  return null;
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: buildTextField(
                    "Phone Number", _phoneController, Icons.phone, (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Number";
                  }
                  return null;
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: buildTextField("CNIC", _cnicController, Icons.numbers,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter CNIC";
                  }
                  return null;
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(11),
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
                  decoration: InputDecoration(
                    labelText: "Category",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a category";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: buildTextField(
                    "Password", _passController, Icons.password, (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Password";
                  }
                  return null;
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: CustomButton(
                      height: 50,
                      width: 160,
                      color: blueColor,
                      text: "Sign Up",
                      opacity: 0.5,
                      fontSize: 18,
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavigationMenu()));
                      })),
            ]),
          ),
        ),
      ),
    );
  }
}
