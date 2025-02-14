import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:needed_app/firebaseoptions.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Future<Map<String, dynamic>?> getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
    await Firebaseoptions.workerCollections.doc(uid).get();

    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No user data found'));
          }

          var userData = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 20),
                ProfileInfoRow(label: "Name", value: userData['name'] ?? 'N/A'),
                ProfileInfoRow(label: "Category", value: userData['category'] ?? 'N/A'),
                ProfileInfoRow(label: "CNIC", value: userData['cnic'] ?? 'N/A'),
                ProfileInfoRow(label: "Phone", value: userData['phone'] ?? 'N/A'),
                ProfileInfoRow(label: "Address", value: "Johar Town"),
                ProfileInfoRow(label: "Rating", value: "5.0"),
                ProfileInfoRow(label: "Experience", value: "1 Year"),
                ProfileInfoRow(label: "Description", value: "Quality Work"),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
