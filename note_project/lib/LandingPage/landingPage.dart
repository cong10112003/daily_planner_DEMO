import 'package:flutter/material.dart';
import 'package:note_project/Calender/calender.dart';
import 'package:note_project/Login/LoginPage/loginPage.dart';
import 'package:note_project/Navigation/bottomNavigation.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  int selectPage = 0;

  PageController? controller = PageController();

  List infoArr = [
    {
      "title": "Boost Your Productivity",
      "sub_title":
          "Plan tasks, set reminders, and stay on track to achieve more in less time.",
    },
    {
      "title": "Master Your Day",
      "sub_title":
          "Manage tasks, prioritize goals, and improve your work-life balance effortlessly.",
    },
    {
      "title": "Your Personal Time Manager",
      "sub_title":
          "Break down tasks, create schedules, and monitor your progress with ease.",
    },
    {
      "title": "Streamline Your Schedule",
      "sub_title":
          "Create task lists, set deadlines, and optimize your daily routine for maximum efficiency.",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    controller?.addListener(() {
      selectPage = controller?.page?.round() ?? 0;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(67, 121, 242, 2),
      body: SafeArea(
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/image/logo.png')),
            ),
          ),
          PageView.builder(
              controller: controller,
              itemCount: infoArr.length,
              itemBuilder: (context, index) {
                var iObj = infoArr[index] as Map? ?? {};

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    Text(
                      iObj["title"].toString(),
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 235, 0, 2),
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: media.width * 0.06,
                    ),
                    Text(
                      iObj["sub_title"].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                );
              }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(14, 150, 14, 0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      "Let's get Started",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Bottomnavigation()));
                    },
                  ),
                ),
              ),
              SizedBox(
                height: media.width * 0.15,
              ),
            ],
          )
        ]),
      ),
    );
  }
}
