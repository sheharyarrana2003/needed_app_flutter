import 'package:flutter/material.dart';
import 'package:needed_app/variables/colors.dart';

class AdminVerificationPage extends StatefulWidget {
  const AdminVerificationPage({super.key});

  @override
  State<AdminVerificationPage> createState() => _AdminVerificationPageState();
}

class _AdminVerificationPageState extends State<AdminVerificationPage> {
  List<Map<String, String>> workers = [
    {
      "name": "Ali Khan",
      "type": "Plumber",
      "phone": "0321-1234567",
      "address": "House #123, Street 4, Lahore"
    },
    {
      "name": "Usman Ahmed",
      "type": "Electrician",
      "phone": "0300-9876543",
      "address": "Street 7, Karachi"
    },
    {
      "name": "Shoaib Malik",
      "type": "Carpenter",
      "phone": "0345-5678901",
      "address": "Gulberg, Islamabad"
    },
    {
      "name": "Ali Khan",
      "type": "Plumber",
      "phone": "0321-1234567",
      "address": "House #123, Street 4, Lahore"
    },
    {
      "name": "Usman Ahmed",
      "type": "Electrician",
      "phone": "0300-9876543",
      "address": "Street 7, Karachi"
    },
    {
      "name": "Shoaib Malik",
      "type": "Carpenter",
      "phone": "0345-5678901",
      "address": "Gulberg, Islamabad"
    },
    {
      "name": "Ali Khan",
      "type": "Plumber",
      "phone": "0321-1234567",
      "address": "House #123, Street 4, Lahore"
    },
    {
      "name": "Usman Ahmed",
      "type": "Electrician",
      "phone": "0300-9876543",
      "address": "Street 7, Karachi"
    },
    {
      "name": "Shoaib Malik",
      "type": "Carpenter",
      "phone": "0345-5678901",
      "address": "Gulberg, Islamabad"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: blueColor,
        iconTheme: IconThemeData(color: white),
        title: const Text(
          "Verification Panel",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pending Verifications",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: workers.length,
                itemBuilder: (context, index) {
                  final worker = workers[index];
                  return Card(
                    color: Colors.grey.shade200,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      title: Text(
                        worker["name"]!,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Type: ${worker["type"]}"),
                          Text("Phone: ${worker["phone"]}"),
                          Text("Address: ${worker["address"]}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle,
                                color: Colors.green, size: 40),
                            onPressed: () {
                              setState(() {
                                workers.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("${worker["name"]} Accepted"),
                                    backgroundColor: Colors.green),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel,
                                color: Colors.red, size: 40),
                            onPressed: () {
                              setState(() {
                                workers.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("${worker["name"]} Rejected"),
                                    backgroundColor: Colors.red),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
