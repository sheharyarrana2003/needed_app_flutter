import 'package:flutter/material.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/screens/payment_screen.dart';
import 'package:needed_app/variables/colors.dart';

class Detailscreen extends StatelessWidget {
  const Detailscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: blueColor,
        iconTheme: IconThemeData(color: white),
        title: Text(
          'Worker Profile',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDCE6FF),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: blueColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Ishfaq Mian",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Plumber",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: blueColor, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRowText("Description", "Quality Work"),
                  buildRowText("Status", "Available", color: blueColor),
                  buildRowText("Address", "Johar town"),
                  buildRowTextWithIcon("Reviews", "3.0"),
                  buildRowText("Contact", "12345678901"),
                  buildRowText("Experience", "1 Year"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              color: blueColor,
              height: 50,
              width: 160,
              text: "Book Now",
              opacity: 0.4,
              fontSize: 18,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              color: blueColor,
              height: 50,
              width: 160,
              text: "Schdule",
              opacity: 0.4,
              fontSize: 18,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget buildRowText(String label, String value,
      {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRowTextWithIcon(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
