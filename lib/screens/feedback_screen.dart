import 'package:flutter/material.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/customWidgets/textField.dart';
import 'package:needed_app/screens/navigation_menu.dart';
import 'package:needed_app/variables/colors.dart';

class FeedbackScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String address;
  final String type;
  const FeedbackScreen({super.key, required this.name, required this.phone, required this.address, required this.type});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _commentsController = TextEditingController();
  String selectedAns = "Yes😊";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: blueColor,
          iconTheme: IconThemeData(color: white),
          title: Text(
            'Worker Feedback',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: white, fontSize: 22),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Worker Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                buildRowTexts(label: "Type", value: widget.type),
                buildRowTexts(label: "Name", value: widget.name),
                buildRowTexts(label: "Address", value: widget.address),
                buildRowTexts(label: "Contact", value: widget.phone),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Comments",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                buildTextField(
                    "Enter your thoughts", _commentsController, Icons.comment,
                    (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter your Comments";
                  }
                  return null;
                }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Are you satisfy with the work?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                buildRadioButton(
                    title: "Yes😊",
                    value: "Yes😊",
                    groupValue: selectedAns,
                    onChanged: (value) {
                      setState(() {
                        selectedAns = value!;
                      });
                    }),
                buildRadioButton(
                    title: "No😔",
                    value: "No😔",
                    groupValue: selectedAns,
                    onChanged: (value) {
                      setState(() {
                        selectedAns = value!;
                      });
                    }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Rate the Worker",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.amber.shade600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CustomButton(
                      height: 50,
                      width: 161,
                      color: blueColor,
                      text: "Submit",
                      opacity: 0.2,
                      fontSize: 24,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Feedback given successfully!"),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationMenu()));
                        });
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRowTexts({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(value, style: TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }

  Widget buildRadioButton({
    required String title,
    required String value,
    required String groupValue,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.1),
      child: Row(
        children: [
          Radio<String>(
            activeColor: blueColor,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
