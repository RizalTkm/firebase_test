import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firesbase_test/features/login/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:firesbase_test/features/login/presentation/bloc/credential/cubit/credential_cubit.dart';
import 'package:firesbase_test/features/login/presentation/page/login_screen.dart';
import 'package:firesbase_test/features/login/presentation/page/signup_page.dart';
import 'package:firesbase_test/features/product_list/presentation/pages/product_list_screen.dart';
import 'package:firesbase_test/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..Appstarted()),
        BlocProvider<CredentialCubit>(create: (_) => di.sl<CredentialCubit>())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/productList': (context) =>  ProductListScreen(),
            '/login': (context) =>  LoginScreen(),
            '/signup':(context)=>  SignUpscreen()
          },
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return  ProductListScreen(uid: snapshot.data?.uid,);
                } else {
                  return  LoginScreen();
                }
              })),
    );
  }
}
