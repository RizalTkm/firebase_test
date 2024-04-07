import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesbase_test/features/product_list/domain/entities/product_details.dart';

// ignore: must_be_immutable
class ProductDetailsModel extends ProductDetailsEntity {
  ProductDetailsModel(
      {required super.productname,
      required super.measurement,
      required super.price,
      required super.imageUrls});

  factory ProductDetailsModel.fromsnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ProductDetailsModel(
        productname: snapshot.get('productname'),
        measurement: snapshot.get('measurement'),
        price: snapshot.get('price'),
        imageUrls: snapshot.get('imageurls'));
  }

  Map<String, dynamic> todocument() {
    return {
      "productname": productname,
      "measurement": measurement,
      "price": price,
      "imageurls": imageUrls
    };
  }
}
