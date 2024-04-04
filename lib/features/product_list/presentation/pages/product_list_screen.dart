import 'package:firesbase_test/config/routes/routenames.dart';
import 'package:firesbase_test/features/login/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key, this.uid});

  final String? uid;

  var productItems = ['pant', 'shirt', 'sari'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: [
          InkWell(
              onTap: () {
                BlocProvider.of<AuthCubit>(context).SignOut().whenComplete(() {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      NavRoutes.loginroute, (route) => false);
                });
              },
              child: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productItems.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/200/300'),
                    ),
                    title: Text(productItems[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
