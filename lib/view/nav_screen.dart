import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home.dart'; // Make sure you have the HomeScreen defined somewhere

class MyNavbarScreen extends StatefulWidget {
  @override
  _MyNavbarScreenState createState() => _MyNavbarScreenState();
}

class _MyNavbarScreenState extends State<MyNavbarScreen> {
  int _currentIndex = 0;

  // Add the appropriate screens here (including HomeScreen, ProfileScreen, etc.)
  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    CameraScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // This will display the appropriate screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black, // Change the selected item label color
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore,color: Colors.black,),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined,color: Colors.black,),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.black,),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: Colors.black,size: 20.h,),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}



class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Explore Screen'),
    );
  }
}

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Camera Screen'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Screen'),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Screen'),
    );
  }
}
