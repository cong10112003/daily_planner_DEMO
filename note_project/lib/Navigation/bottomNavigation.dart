import 'package:flutter/material.dart';
import 'package:note_project/Calender/calender.dart';
import 'package:note_project/Notes/notes.dart';
import 'package:note_project/Setting/settings.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int currentIndex = 0;
  List pages = const [
    Notes(),
    Calender(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(67, 121, 242, 1),
              blurRadius: 25,
              offset: const Offset(8, 20))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(67, 121, 242, 1),
            selectedItemColor: const Color.fromRGBO(255, 165, 0, 1),
            unselectedItemColor: Colors.white,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.note), label: "Notes"),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Calender"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        ),
      ),
      body: pages[currentIndex],
    );
  }
}
