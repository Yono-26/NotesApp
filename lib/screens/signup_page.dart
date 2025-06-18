import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/screens/login_page.dart';

import '../models/user_model.dart';
import '../widgets/common_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
            SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: 'Enter Your Name',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Name';
                }
                return null;
              },
              controller: userNameController,
            ),
            SizedBox(
              height: 16,
            ),
            CommonTextField(
              hintText: 'Enter Your Password',
              obscureText: !isPasswordVisible,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(Icons.visibility_off)),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
              controller: passwordController,
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  backgroundColor: Colors.amber,
                ),
                onPressed: () {
                  final user = UserModel(username: userNameController.text.trim(), password: passwordController.text.trim());
                  userBox.put('user', user);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Registered !')));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 16),
            RichText(
              text: TextSpan(
                text: "Already Have a Account ? ",
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: "Login Now",
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
