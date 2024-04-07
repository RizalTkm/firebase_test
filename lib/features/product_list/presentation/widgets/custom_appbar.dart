import 'package:firesbase_test/features/login/presentation/page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../login/presentation/bloc/auth/cubit/auth_cubit.dart';

class CustomappbarWidget extends StatelessWidget {
  const CustomappbarWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is UnauthenticatedState) {
            return LoginScreen();
          }
          return AppBar(
            title: Center(child: Text(title)),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).SignOut();
                    },
                    child: const Icon(Icons.logout)),
              )
            ],
          );
        },
      ),
    );
  }
}
