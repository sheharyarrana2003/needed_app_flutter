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
      appBar: AppBar(
        title: const Text("Verification Panel"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
        stream: Firebaseoptions.workerCollections.where('status', isEqualTo: 'pending').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var workers = snapshot.data!.docs;
          return workers.isEmpty
              ? const Center(child: Text("No pending verifications"))
              : ListView.builder(
            itemCount: workers.length,
            itemBuilder: (context, index) {
              var worker = workers[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: ListTile(
                  title: Text(worker['name']),
                  subtitle: Text(worker['category']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => updateStatus(worker.id, 'approved'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () => updateStatus(worker.id, 'rejected'),
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
