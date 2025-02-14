import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/screens/payment_screen.dart';
import 'package:needed_app/variables/colors.dart';

class DetailScreen extends StatelessWidget {

  final String name;
  final String profession;
  final String description;
  final String status;
  final String address;
  final double reviews;
  final String contact;
  final String experience;

  const DetailScreen({
    super.key,
    required this.name,
    required this.profession,
    required this.description,
    required this.status,
    required this.address,
    required this.reviews,
    required this.contact,
    required this.experience,
  });

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
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    profession,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                  buildRowText("Description", description),
                  buildRowText("Status", status, color: blueColor),
                  buildRowText("Address", address),
                  buildRowTextWithIcon("Reviews", reviews.toString()),
                  buildRowText("Contact", contact),
                  buildRowText("Experience", experience),
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
                    MaterialPageRoute(builder: (context) => PaymentScreen(name: name, phone: contact, address: address, type: profession )));
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              color: blueColor,
              height: 50,
              width: 160,
              text: "Schedule",
              opacity: 0.4,
              fontSize: 18,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }

  Widget buildRowText(String label, String value, {Color color = Colors.black}) {
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
