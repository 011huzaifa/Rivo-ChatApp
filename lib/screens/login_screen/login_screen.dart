import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/core/components/app_buttons.dart';
import 'package:chatapp/core/components/app_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  //tap to go to register page
  final void Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  void login(BuildContext context) async {
    //auth service
    AuthService authService = AuthService();

    //login
    try {
      await authService.signInWithEmailPassowrd(
        _emailController.text,
        _pwController.text,
      );
    } catch (e) {
      showDialog(
        context: (context),
        builder: (_) {
          return AlertDialog(title: Text(e.toString()));
        },
      );
    }
  }

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
            //sign in with google
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: BorderSide(width: 1.4, color: Theme.of(context).colorScheme.primary),
                shadowColor: Colors.transparent,
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                minimumSize: Size(double.infinity, 45)
              ),
              onPressed: () {},
              icon: Image.asset(
                "assets/images/google_logo.png",
                scale: 1,
                width: 20,
              ),
              label: Text("Sign in with Google"),
            ),
            Text(
              "Sing in with email",
              style: Theme.of(context).textTheme.bodyMedium,
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
            AppButtons(
              buttonLabel: "Login",
              onPressed: () {
                login(context);
              },
            ),

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
