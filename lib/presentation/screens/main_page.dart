import 'package:charterer/presentation/screens/add_charterer_screen.dart';
import 'package:charterer/presentation/screens/call_screen.dart';
import 'package:charterer/presentation/screens/contact_screen.dart';
import 'package:charterer/presentation/screens/home_screen.dart';
import 'package:charterer/presentation/screens/notification_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const HomeScreen(),
    const NotificationScreen(),
    const AddCharterer(),
    const CallScreen(),
    const ContactScreen(),
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 34, 51),
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 16,
          unselectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 45, 42, 55),
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(color: Colors.blue),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.message_sharp), label: "Messages"),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: "Notifications"),
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.add_circle_sharp, size: 50, color: Colors.blue),
                label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt), label: "Contacts"),
          ],
        ),
      ),
    );
  }
}
