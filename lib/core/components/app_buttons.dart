import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  final String? buttonLabel;
  final VoidCallback onPressed;
  const AppButtons({super.key, this.buttonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        onPressed();
      },
      style: FilledButton.styleFrom(
        minimumSize: Size(double.infinity, 43),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        textStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      child: Text("Login"),
    );
  }
}
