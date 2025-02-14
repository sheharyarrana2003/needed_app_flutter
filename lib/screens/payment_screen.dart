import 'package:flutter/material.dart';
import 'package:needed_app/screens/feedback_screen.dart';
import 'package:needed_app/variables/colors.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "Cash on Delivery";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: blueColor,
        iconTheme: IconThemeData(color: white),
        title: Text(
          'Payment Details',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FeedbackScreen()));
          },
          child: Container(
            height: 60,
            color: blueColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Proceed Further",
                  style: TextStyle(
                      color: white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Your Details",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            buildRowTexts(label: "Name", value: "Jamal Khan", icon: Icons.edit),
            buildRowTexts(
                label: "Address", value: "Johar Town", icon: Icons.edit),
            buildRowTexts(
                label: "Contact", value: "12345678901", icon: Icons.edit),
            SizedBox(
              height: 20,
            ),
            Text(
              "Worker Details",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            buildRowTexts(label: "Type", value: "Plumber"),
            buildRowTexts(label: "Name", value: "Ishfaq Mian"),
            buildRowTexts(label: "Address", value: "Johar Town"),
            buildRowTexts(
                label: "Contact", value: "12345678901", icon: Icons.call),
            SizedBox(
              height: 20,
            ),
            Text(
              "Paymnent Method",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            buildPaymentMethod(
                path: "assets/Images/jazz.png", label: "Jazz cash"),
            buildPaymentMethod(
                path: "assets/Images/easy.png", label: "easypaisa"),
            buildPaymentMethod(
                path: "assets/Images/cash.png", label: "Cash on Delivery"),
          ],
        ),
      ),
    );
  }

  Widget buildRowTexts(
      {required String label, required String value, IconData? icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(value, style: TextStyle(fontSize: 16, color: Colors.grey)),
        Icon(
          icon,
          size: 24,
          color: icon == Icons.call ? Colors.green.shade700 : blueColor,
        )
      ],
    );
  }

  Widget buildPaymentMethod({required String path, required String label}) {
    return Row(
      children: [
        buildRadioButton(
            title: label,
            value: label,
            groupValue: selectedMethod,
            onChanged: (value) {
              setState(() {
                selectedMethod = value!;
              });
            }),
        SizedBox(
          width: 30,
        ),
        Image.asset(
          path,
          height: 40,
          width: 40,
        )
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
