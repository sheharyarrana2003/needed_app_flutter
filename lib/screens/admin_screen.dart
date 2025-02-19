import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:needed_app/firebaseoptions.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/screens/login_screen.dart';

class AdminVerificationPage extends StatefulWidget {
  const AdminVerificationPage({super.key});

  @override
  State<AdminVerificationPage> createState() => _AdminVerificationPageState();
}

class _AdminVerificationPageState extends State<AdminVerificationPage> {
  void updateStatus(String userId, String status) {
    Firebaseoptions.workerCollections.doc(userId).update({'status': status});
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LogInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 86, 161, 0.9),
        title: const Text(
          "Verification Panel",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomButton(
              height: 40,
              width: 100,
              color: Colors.red,
              text: "Logout",
              opacity: 0.9,
              fontSize: 16,
              onTap: _logout,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firebaseoptions.workerCollections
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var workers = snapshot.data!.docs;
          return workers.isEmpty
              ? const Center(
            child: Text(
              "No pending verifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(14.0),
            itemCount: workers.length,
            itemBuilder: (context, index) {
              var worker = workers[index];
              return Card(
                elevation: 3,
                shadowColor: Colors.grey.withOpacity(0.2),
                color: Colors.grey.shade200,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              worker['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Category: ${worker["category"]}",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              "Phone: ${worker["phone"]}",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              "Address: Johar Town",
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => updateStatus(worker.id, 'approved'),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => updateStatus(worker.id, 'rejected'),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
