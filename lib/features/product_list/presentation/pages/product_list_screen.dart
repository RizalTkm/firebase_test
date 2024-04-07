import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesbase_test/config/routes/routenames.dart';
import 'package:firesbase_test/features/login/presentation/widgets/circularprogressIndicator.dart';
import 'package:firesbase_test/features/product_list/presentation/pages/product_qr_widget.dart';

import 'package:firesbase_test/features/product_list/presentation/widgets/productcard.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';

// ignore: must_be_immutable
class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key, this.uid});

  final String? uid;
  final TextEditingController searchcontroller = TextEditingController();
  var productitems = [];
  final ValueNotifier<String> searchvalue = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed(NavRoutes.prouctCreateroute);
          },
          icon: const Icon(Icons.add),
          label: const Text("Add product")),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomappbarWidget(
            title: 'Home',
          )),
      body: ValueListenableBuilder(
          valueListenable: searchvalue,
          builder: (context, svalue, _) {
            return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Products')
                    .orderBy("productname")
                    .startAt([searchvalue.value]).endAt(
                        ["${searchvalue.value}\uf8ff"]).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicatorWidget();
                  }
                  if (snapshot.hasData) {
                    productitems = snapshot.requireData.docs;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: searchcontroller,
                            onFieldSubmitted: (value) {
                              searchvalue.value = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Search',
                              prefixIcon: InkWell(
                                child: const Icon(Icons.search),
                                onTap: () {
                                  searchvalue.value = searchcontroller.text;
                                  // final docs = snapshot.requireData.docs;
                                  // if (searchcontroller.text.isNotEmpty) {
                                  //   for (var doc in docs) {
                                  //     if (searchcontroller.text
                                  //         .contains(doc['productname'])) {
                                  //       productitems.add(doc);
                                  //     }
                                  //   }
                                  // }
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: productitems.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ProductQrWidget(
                                      qrdata: 'weqfqfihqef',
                                    ),
                                  ));
                                },
                                child: ProductTile(
                                    productName: productitems[index]
                                            ['productname']
                                        .toString(),
                                    ProductPrice:
                                        productitems[index]["price"].toString(),
                                    productsize: productitems[index]
                                            ["measurement"]
                                        .toString(),
                                    imageUrl: productitems[index]["imageurls"]
                                            [0]
                                        .toString()),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                });
          }),
    );
  }
}
