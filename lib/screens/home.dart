import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:needed_app/firebaseoptions.dart';
import 'package:needed_app/screens/detailScreen.dart';
import 'package:needed_app/screens/serachFilters.dart';
import 'package:needed_app/variables/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: "Search..",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: blueColor, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide:
                          const BorderSide(color: Colors.black, width: 2),
                        ),
                        suffixIcon: const Icon(Icons.search),
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchFilters()),
                        );
                      },
                      icon: Icon(
                        Icons.filter_list_rounded,
                        color: blueColor,
                        size: 27,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firebaseoptions.workerCollections.snapshots(),
                  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return const Center(
    child: Text("No workers available",
    style: TextStyle(fontSize: 16)));
    }
    else{
    final workers = snapshot.data!.docs;
    final currentUser = _auth.currentUser;

    final filteredWorkers = workers.where((worker) {
    final workerData =
    worker.data() as Map<String, dynamic>;
    return workerData['uid'] != currentUser?.uid &&
    workerData['status'] == "approved";
    }).toList();

    if (filteredWorkers.isEmpty) {
    return const Center(
    child: Text("No  workers available",
    style: TextStyle(fontSize: 16)));
    }

    return ListView.builder(
    itemCount: filteredWorkers.length,
    itemBuilder: (context, index) {
    final workerData =
    filteredWorkers[index].data() as Map<String, dynamic>;
    final workerName = workerData['name'] ?? "Unknown";
    final category = workerData['category'] ?? "No Category";
    final phoneNumber =
    workerData['phone'] ?? "No Phone Number";

    return Card(
    color: white,
    elevation: 2,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: const BorderSide(
    color: Colors.black, width: 2),
    ),
    child: ListTile(
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => DetailScreen(
    name: workerName,
    profession: category,
    description: "Quality Work",
    status: "Available",
    address: "Johar Town",
    reviews: 5.0,
    contact: phoneNumber,
    experience: "1 Year",
    ),
    ),
    );
    },
    leading: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.asset(
    'assets/Images/worker.jpg', // Dummy Image
    width: 50,
    height: 50,
    fit: BoxFit.fill,
    ),
    ),
    title: Text(
    workerName,
    style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),
    subtitle: Text(
    category,
    style: const TextStyle(color: Colors.grey),
    ),
    trailing: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(
    5,
    (starIndex) => const Icon(
    Icons.star,
    color: Colors.amber,
    size: 18,
    ),
    ),
    ),
    const SizedBox(height: 5),
    Text(
    "Available",
    style: TextStyle(
    color: Colors.green.shade700,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    );
    },
    );
    }
                  },

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
