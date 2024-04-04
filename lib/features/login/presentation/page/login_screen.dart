// lib/login_form.dart

import 'package:another_flushbar/flushbar.dart';
import 'package:firesbase_test/config/routes/routenames.dart';
import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';
import 'package:firesbase_test/features/login/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:firesbase_test/features/login/presentation/bloc/credential/cubit/credential_cubit.dart';
import 'package:firesbase_test/features/login/presentation/widgets/signinbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final usernamecontroller = TextEditingController();
  final passwordController = TextEditingController();

  final ValueNotifier<bool> isobscurepassword = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernamecontroller,
              decoration: const InputDecoration(labelText: 'User name'),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder(
                valueListenable: isobscurepassword,
                builder: (context, value, child) {
                  return TextFormField(
                    controller: passwordController,
                    obscureText: isobscurepassword.value,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: InkWell(
                            onTap: () {
                              isobscurepassword.value =
                                  !isobscurepassword.value;
                            },
                            child: isobscurepassword.value
                                ? const Icon(Icons.visibility_sharp)
                                : const Icon(Icons.visibility_off))),
                  );
                }),
            const SizedBox(height: 24),
            SignInButton(
                onpressed: () {
                  submitSign(context);
                },
                label: 'Sign in'),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, NavRoutes.signuproute);
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitSign(BuildContext context) async {
    if (usernamecontroller.text.isEmpty) {
      showflutterToast('Please enter username');
      return;
    }
    if (passwordController.text.isEmpty) {
      showflutterToast('Please enter password ');
      return;
    }

    BlocProvider.of<CredentialCubit>(context)
        .submitSignin(
            usercred: LoginEntity(
                username: usernamecontroller.text,
                password: passwordController.text))
        .whenComplete(() {
      BlocProvider.of<AuthCubit>(context).loggedIn().then((value) {
        if (value) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              NavRoutes.productListroute, (route) => false);
        } else {
          Flushbar(
            message: "Invalid Credential",
            backgroundColor: Colors.red,
          );
        }
      });
    });
  }

  showflutterToast(String message) async {
    await Fluttertoast.showToast(msg: message, textColor: Colors.red);
  }
}
