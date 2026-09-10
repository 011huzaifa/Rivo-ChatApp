import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 25, bottom: 2, right: 25, top: 8),
        padding: EdgeInsets.only(bottom: 10, top: 12, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(spacing: 10, children: [Icon(Icons.person), Text(text)]),
      ),
    );
  }
}
