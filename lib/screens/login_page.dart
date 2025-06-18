import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/models/user_model.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/screens/signup_page.dart';
import 'package:notes_app/widgets/common_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String errorMessage = "";
  bool isPasswordVisible = false;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Hive User Box
  final Box<UserModel> userBox = Hive.box<UserModel>('userBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black26),
                ),
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/Notes_App_Logo.jpg',
                  width: 40,
                ),
              ),
              Text(
                "Notes App",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
              ),
              SizedBox(height: 16),
              CommonTextField(
                hintText: "Enter Username",
                controller: userNameController,
              ),
              SizedBox(height: 16),
              CommonTextField(
                hintText: "Enter password",
                obscureText: !isPasswordVisible,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    icon: Icon(Icons.visibility_off)),
                controller: passwordController,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  final storedUser = userBox.get('user');

                  if (storedUser != null &&
                      storedUser.username == userNameController.text.trim() &&
                      storedUser.password == passwordController.text.trim()) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid credentials')));
                  }
                },
                child: Text(
                  'Log in',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: "Don't Have an Account ? ",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Register Now",
                      style: const TextStyle(color: Colors.blue, fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
