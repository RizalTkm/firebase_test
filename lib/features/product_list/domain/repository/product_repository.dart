import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesbase_test/features/product_list/data/models/product_model.dart';
import 'package:firesbase_test/features/product_list/domain/entities/product_details.dart';

abstract class ProductRepository {
  Future<dynamic> submitNewProduct(
    ProductDetailsModel productDetailsModel,
  );

  Stream<QuerySnapshot> getProductList();

  Future<String> uploadImageTofirebase(File imagefile);
}
