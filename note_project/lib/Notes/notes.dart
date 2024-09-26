import 'package:flutter/material.dart';
import 'package:note_project/Notes/addNotes.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  "assets/image/darkmode.png",
                  width: 35,
                  height: 35,
                ),
              ),
              SizedBox(width: 285),
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: const NetworkImage(
                      "https://i.ytimg.com/vi/bD-VM10PWdw/maxresdefault.jpg"),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color.fromRGBO(67, 121, 242, 1),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "September 25, 2024",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  Text("Today",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addnotes()));
                },
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(67, 121, 242, 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                      child: Text(
                    "+ New task",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromRGBO(67, 121, 242, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tittle",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset("assets/image/clock.png")),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "Date/time",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  Text(
                    "Description",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
