import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tele/views/screens/patient/TransactionHistoryScreen.dart';
import 'package:tele/views/screens/patient/chats_list_screen_appointment.dart';
import 'package:tele/views/screens/patient/contact_us_screen.dart';
import 'package:tele/views/screens/home_screen.dart';
import 'package:tele/views/screens/notification_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItem = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  final List<Widget> screens = [
    HomeScreen(),
    // Center(child: Text("Notification Screen")),
    //  ChatsListScreenAppointment(),
    NotificationScreen(),
    TransactionHistoryScreen(),
    ContactUsScreen(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _selectedItem,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        // showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home".tr(),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: "Chat",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "notifications".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.loop),
            label: "transaction".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: "contact".tr(),
          ),
        ],
      ),
    );
  }
}