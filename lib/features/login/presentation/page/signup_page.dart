import 'package:another_flushbar/flushbar.dart';
import 'package:firesbase_test/config/routes/routenames.dart';
import 'package:firesbase_test/features/login/data/model/login_model.dart';
import 'package:firesbase_test/features/login/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:firesbase_test/features/login/presentation/bloc/credential/cubit/credential_cubit.dart';
import 'package:firesbase_test/features/login/presentation/widgets/circularprogressIndicator.dart';
import 'package:firesbase_test/features/product_list/presentation/pages/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/signinbutton.dart';

// ignore: must_be_immutable
class SignUpscreen extends StatelessWidget {
  SignUpscreen({
    super.key,
  });

  final usernamecontroller = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  // bool isobscurepassword = true;

  final ValueNotifier<bool> isobscurepassword = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, state) {
            if (state is CredentialSuccesstate) {
              Future.delayed(const Duration(seconds: 1), () {
                showflutterToast("User registration successful");
                Navigator.of(context).pushNamedAndRemoveUntil(
                    NavRoutes.loginroute, (route) => false);
              });
            } else if (state is CredentialFailure) {
              showflutterToast('Invalid username or password');
            }
          },
          builder: (context, credstate) {
            if (credstate is CredentialLoading) {
              return const CircularProgressIndicator();
            }
            if (credstate is CredentialFailure ||
                credstate is CredentialInitial) {
              return _signupForm(context);
            }
            return _signupForm(context);
          },
        ),
      ),
    );
  }

  Widget _signupForm(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
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
                        isobscurepassword.value = !isobscurepassword.value;
                      },
                      child: isobscurepassword.value
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.remove_red_eye_rounded)),
                ),
              );
            }),
        const SizedBox(height: 24),
        TextFormField(
          controller: confirmpasswordcontroller,
          decoration: const InputDecoration(
            labelText: 'confirm Password',
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SignInButton(
            onpressed: () {
              submitUsersignup(context);
              //Smallwidgets.circularProgressIndicator();
            },
            label: 'Sign up'),
        const SizedBox(height: 16),
      ],
    );
  }

  //functions

  submitUsersignup(BuildContext context) {
    if (usernamecontroller.text.isEmpty) {
      showflutterToast('Please enter username');
      return;
    }
    if (passwordController.text.isEmpty) {
      showflutterToast('Please enter password ');
      return;
    }

    if (passwordController.text != confirmpasswordcontroller.text) {
      showflutterToast('Password does not match');
      return;
    }

    BlocProvider.of<CredentialCubit>(context).submitSignUp(
        usercred: loginModel(
            username: usernamecontroller.text,
            password: passwordController.text));
  }

  showflutterToast(
    String message,
  ) async {
    await Fluttertoast.showToast(msg: message, textColor: Colors.red);
  }
}
