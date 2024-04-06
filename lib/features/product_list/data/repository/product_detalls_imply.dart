import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firesbase_test/features/product_list/data/models/product_model.dart';

import 'package:firesbase_test/features/product_list/domain/repository/product_repository.dart';



class ProductRepoImply extends ProductRepository {
  @override
  Stream<List<ProductDetailsModel>> getProductList() async* {
    final firbaseinstance = FirebaseFirestore.instance;
    final productCOllectionRef = firbaseinstance.collection('Products');

    // yield* productCOllectionRef.snapshots().map<ProductDetailsModel>((querySnapshot) {});
  }

  @override
  Future submitNewProduct(
      ProductDetailsModel   productDetailsModel,) async {
    final firbaseinstance = FirebaseFirestore.instance;

   final productCOllectionRef = firbaseinstance.collection('Products');

    // final imageurls = await  Future.wait(imagefiles.map((image)  {
    //   return uploadImageTofirebase(image);
    // }).toList());

   await  productCOllectionRef.add(productDetailsModel.todocument());
  }

  @override
  Future<String> uploadImageTofirebase(File imagefile) async {
    final firestorageref = FirebaseStorage.instance.ref();
    final uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final refimagetoupload = firestorageref.child('images').child(uniqueName);

    await refimagetoupload.putFile(imagefile);

    final imageurl = await firestorageref.getDownloadURL();

    return imageurl;
  }
}
