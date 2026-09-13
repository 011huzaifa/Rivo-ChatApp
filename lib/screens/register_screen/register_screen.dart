import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/core/components/app_buttons.dart';
import 'package:chatapp/core/components/app_textfield.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _confirmPwController = TextEditingController();

  //tap to go to login page
  final void Function()? onTap;
  RegisterScreen({super.key, required this.onTap});

  void register(BuildContext context) async {
    //auth service
    final auth = AuthService();

    //singup
    if (_pwController.text == _confirmPwController.text) {
      try {
        await auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Password don't match!")),
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
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 45,
              color: Theme.of(context).colorScheme.primary,
            ),
            // register text
            Text(
              "Welcome! Create an account",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            //sign up with google
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
              label: Text("Sign up with Google"),
            ),
            Text(
              "Sing up with email",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            //Text fields
            AppTextfield(
              controller: _emailController,
              labelText: "Email",
              hintText: "Enter your email",
            ),
            AppTextfield(
              controller: _pwController,
              labelText: "Password",
              hintText: "Enter your password",
              obscureText: true,
            ),
            AppTextfield(
              controller: _confirmPwController,
              labelText: "Confirm Password",
              hintText: "Confirm your password",
              obscureText: true,
            ),
            AppButtons(
              onPressed: () => register(context),
              buttonLabel: "Register",
            ),
            //login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an accont? "),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login Now",
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
