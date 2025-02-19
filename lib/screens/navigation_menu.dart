import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:needed_app/customWidgets/blueButton.dart';
import 'package:needed_app/screens/admin_screen.dart';
import 'package:needed_app/screens/home.dart';
import 'package:needed_app/screens/logIn_screen.dart';
import 'package:needed_app/screens/messages.dart';
import 'package:needed_app/screens/profile.dart';
import 'package:needed_app/screens/services.dart';
import 'package:needed_app/variables/colors.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Home(),
    const Services(),
    const Messages(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: blueColor,
          iconTheme: IconThemeData(color: white),
          title: Text(
            'Needed',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: white, fontSize: 22),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: blueColor),
                  image: const DecorationImage(
                    image: AssetImage("assets/Images/worker.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(
                color: Colors.black,
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(height: 20),
              buildDrawerItem(label: "Account Information"),
              buildDrawerItem(label: "Previous Bookings"),
              buildDrawerItem(label: "Current Bookings"),
              buildDrawerItem(label: "Settings"),
              buildDrawerItem(label: "FAQ's"),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.black,
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(height: 30),
              Center(
                  child: CustomButton(
                      height: 50,
                      width: 160,
                      color: blueColor,
                      opacity: 0.5,
                      fontSize: 18,
                      text: "Log Out",
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LogInScreen()),
                        );
                      })),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {

          },
          elevation: 5,
          backgroundColor: blueColor,
          child: Icon(
            Icons.question_mark,
            color: white,
            size: 30,
          ),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomAppBar(
            color: blueColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomAppBarItem(icon: Icons.home, page: 0, label: "Home"),
                _bottomAppBarItem(icon: Icons.group, page: 1, label: "Services"),
                _bottomAppBarItem(
                    icon: Icons.message, page: 2, label: "Messages"),
                _bottomAppBarItem(icon: Icons.person, page: 3, label: "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItem({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget _bottomAppBarItem(
      {required IconData icon, required int page, required String label}) {
    bool isSelected = _selectedIndex == page;
    return GestureDetector(
      onTap: () => _onItemTapped(page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: isSelected ? 30 : 25,
              color: isSelected ? white : Colors.grey[300]),
          Text(
            label,
            style: TextStyle(
                color: isSelected ? white : Colors.grey[300],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
