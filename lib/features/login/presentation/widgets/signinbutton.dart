import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, required this.onpressed, required this.label});

  final VoidCallback onpressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), ),
        child: ElevatedButton(onPressed: onpressed, child: Text(label),style: ElevatedButton.styleFrom(backgroundColor: Colors.red),));
  }
}
