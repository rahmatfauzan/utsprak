import 'package:flutter/material.dart';
import 'package:utsprak/home.dart';
import 'package:utsprak/listgrid.dart';
import 'package:utsprak/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyBottomNavBar(),
    );
  }
}


class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomePage(),
    const ListMovieGrid(),
    const Profile()
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      //buat footer
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF4F88F7),//Color(0xFF393434),
        fixedColor: const Color(0xFFFFFFFF),
        unselectedItemColor: const Color(0xFF233269),
        onTap: onTappedBar,
        currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
              label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Movie'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile'
            )
          ],
      )
    );
  }
}

