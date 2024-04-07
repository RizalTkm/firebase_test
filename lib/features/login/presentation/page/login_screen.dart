// lib/login_form.dart

import 'package:another_flushbar/flushbar.dart';
import 'package:firesbase_test/config/routes/routenames.dart';
import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';
import 'package:firesbase_test/features/login/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:firesbase_test/features/login/presentation/bloc/credential/cubit/credential_cubit.dart';
import 'package:firesbase_test/features/login/presentation/widgets/circularprogressIndicator.dart';
import 'package:firesbase_test/features/login/presentation/widgets/signinbutton.dart';
import 'package:firesbase_test/features/product_list/presentation/pages/product_list_screen.dart';
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
        child: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context,state){
             if(state is CredentialSuccesstate){
              BlocProvider.of<AuthCubit>(context).loggedIn();
             } 

             if(state is CredentialFailure){
              showflutterToast("Invalid credental");
             }
            
          },
          builder: (context, state) {
            if (state is CredentialLoading) {
              return const CircularProgressIndicatorWidget();
            } 
            if(state is CredentialSuccesstate){
              return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if(state is AuthenticatedState){
                    return ProductListScreen();
                  }else{
                    return BuildSignPage(context);
                  }
                },
              );
            }

            return BuildSignPage(context);
          },
        ),
      ),
    );
  }

  Future<void> submitSign(BuildContext context, uid) async {}

  showflutterToast(String message) async {
    await Fluttertoast.showToast(msg: message, textColor: Colors.red);
  }


  Widget BuildSignPage( BuildContext context){

    return Column(
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
                                      ? Icon(Icons.visibility_sharp)
                                      : Icon(Icons.visibility_off))),
                        );
                      }),
                  const SizedBox(height: 24),
                  SignInButton( label: 'Sign in',
                      onpressed: () async {
                        if (usernamecontroller.text.isEmpty) {
                          showflutterToast('Please enter username');
                          return;
                        }
                        if (passwordController.text.isEmpty) {
                          showflutterToast('Please enter password ');
                          return;
                        }
                        await BlocProvider.of<CredentialCubit>(context)
                            .submitSignin(
                                usercred: LoginEntity(
                                    username: usernamecontroller.text,
                                    password: passwordController.text));

                                      

                                      Navigator.of(context).pushNamedAndRemoveUntil(NavRoutes.productListroute, (route) => false);
                                      
                                    
                      }),
                      
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, NavRoutes.signuproute);
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              );
  }
}
