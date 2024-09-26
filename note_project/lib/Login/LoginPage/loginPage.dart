import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_project/Login/ForgotPassword/forgotPassword.dart';
import 'package:note_project/Login/SignUpPage/signUp.dart';
import 'package:note_project/Navigation/bottomNavigation.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  @override
  void dispose() {
    txtEmail.dispose();
    txtPassword.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    if (txtEmail.text.isEmpty || txtPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(txtEmail.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email không đúng định dạng')),
      );
      return;
    } else {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => Bottomnavigation()),
          (Route<dynamic> route) => false,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(67, 121, 242, 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Welcom to Daily Planner",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 235, 0, 2),
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Login to continute",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 235, 0, 2),
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: SingleChildScrollView(
                child: SafeArea(
                    child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: txtEmail,
                        focusNode: _focusEmail,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(67, 121, 242, 1)),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                          floatingLabelStyle:
                              TextStyle(color: Color.fromRGBO(67, 121, 242, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: txtPassword,
                        focusNode: _focusPassword,
                        obscureText: true,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(67, 121, 242, 1)),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color:
                                  Colors.black), // Label color when not focused
                          floatingLabelStyle: TextStyle(
                              color: Color.fromRGBO(
                                  67, 121, 242, 1)), // Label color when focused
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Forgotpassword()));
                            },
                            child: Text(
                              "Forgot password ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(188, 134, 13, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color?>(
                                Color.fromRGBO(67, 121, 242, 2)),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            handleLogin();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You're new ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              "Sign up",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(188, 134, 13, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(222, 60, 0, 1),
                          ),
                          child: Text(
                            'Login with Office 365',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
