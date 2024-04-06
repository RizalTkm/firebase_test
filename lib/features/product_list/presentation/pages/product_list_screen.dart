import 'package:firesbase_test/config/routes/routenames.dart';

import 'package:firesbase_test/features/product_list/presentation/widgets/productcard.dart';
import 'package:flutter/material.dart';


import '../widgets/custom_appbar.dart';


// ignore: must_be_immutable
class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key, this.uid});

  final String? uid;

  var productItems = ['pant', 'shirt', 'sari'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(onPressed: (){
        Navigator.of(context).pushNamed(NavRoutes.prouctCreateroute);
      }, icon: const Icon(Icons.add), label: const Text("Add product")),
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50), child: CustomappbarWidget(title: 'Home',)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
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
                return ProductTile(
                    productName: productItems[index],
                    ProductPrice: "500",
                    productsize:'18' ,
              
                    imageUrl:
                        'https://www.shutterstock.com/image-photo/one-tree-perfect-grass-field-76166707');
              },
            ),
          ),
        ],
      ),
    );
  }
}


