import 'package:chatapp/auth/login_or_register.dart';
import 'package:chatapp/core/components/app_buttons.dart';
import 'package:chatapp/core/components/app_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  //tap to go to register page
  final void Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        margin: EdgeInsets.all(30),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Icon(
              Icons.message,
              size: 45,
              color: Theme.of(context).colorScheme.primary,
            ),
            //welcome message
            Text(
              "Welcome back! you've been missed",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            //text fields
            AppTextfield(
              controller: _emailController,
              hintText: "Enter your email",
              labelText: "Email",
              obscureText: false,
            ),
            AppTextfield(
              controller: _pwController,
              hintText: "Enter your password",
              labelText: "Password",
              obscureText: true,
            ),
            //login Button
            AppButtons(buttonLabel: "Login", onPressed: () {}),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an accont? "),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register Now",
                    style: TextStyle(fontWeight: FontWeight(600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
