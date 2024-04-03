import 'package:firesbase_test/features/login/data/model/login_model.dart';
import 'package:firesbase_test/features/login/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:firesbase_test/features/login/presentation/bloc/credential/cubit/credential_cubit.dart';
import 'package:firesbase_test/features/login/presentation/widgets/circularprogressIndicator.dart';
import 'package:firesbase_test/features/product_list/presentation/pages/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/signinbutton.dart';

class SignUpscreen extends StatelessWidget {
  SignUpscreen({
    super.key,
  });

  final usernamecontroller = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<CredentialCubit, CredentialState>(
          listener: (context, state) {
            if(state is CredentialSuccesstate){
              BlocProvider.of<AuthCubit>(context).loggedIn();
            } else if(state is CredentialFailure){

              showflutterToast('Invalid username of password');
            }

            
          },
          builder: (context, credstate) {
            if( credstate is CredentialLoading){
              return const CircularProgressIndicatorWidget();
            } 
             if (credstate is CredentialSuccesstate){ 
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, authstate) {
                   
                   if(authstate is AuthenticatedState ){
                    return  ProductListScreen(uid: authstate.uid,);
                   } else {
                    return _signupForm(context);
                   }

                  },
                );
            } 
            return _signupForm(context);
          },
        ),
      ),
    );
  }


  Widget _signupForm(BuildContext context){

    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: usernamecontroller,
                  decoration: const InputDecoration(labelText: 'User name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      suffixIcon: Icon(Icons.remove_red_eye)),
                ),
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

  showflutterToast(String message) async {
    await Fluttertoast.showToast(msg: message, textColor: Colors.red);
  }
}
