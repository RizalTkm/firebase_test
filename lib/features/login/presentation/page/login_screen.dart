// lib/login_form.dart

import 'package:firesbase_test/config/routes/routenames.dart';
import 'package:firesbase_test/features/login/presentation/widgets/signinbutton.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const  Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration:const  InputDecoration(labelText: 'User name'),
            ),
          const   SizedBox(height: 16),
            TextFormField(

              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password', suffixIcon: Icon(Icons.remove_red_eye)),
              
            ),
           const  SizedBox(height: 24),

           SignInButton(onpressed: (){}, label: 'Sign in'),
         
           const  SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, NavRoutes.signuproute);
              },
              child:  const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
