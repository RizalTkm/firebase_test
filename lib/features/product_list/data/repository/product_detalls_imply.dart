import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firesbase_test/features/product_list/data/models/product_model.dart';

import 'package:firesbase_test/features/product_list/domain/repository/product_repository.dart';

class ProductRepoImply extends ProductRepository {
  @override
  Stream<QuerySnapshot> getProductList() async* {
    final firbaseinstance = FirebaseFirestore.instance;
    final productCOllection = firbaseinstance
        .collection('Products')
        .orderBy("productname")
        .startAt(["rizal"]).endAt(["rizal" + "\uf8ff"]).snapshots();

    // yield* productCOllectionRef.snapshots().map<ProductDetailsModel>((querySnapshot) {});
    yield* productCOllection;
  }

  @override
  Future submitNewProduct(
    ProductDetailsModel productDetailsModel,
  ) async {
    final firbaseinstance = FirebaseFirestore.instance;

    final productCOllectionRef = firbaseinstance.collection('Products');

    // final imageurls = await  Future.wait(imagefiles.map((image)  {
    //   return uploadImageTofirebase(image);
    // }).toList());

    await productCOllectionRef.add(productDetailsModel.todocument());
  }

  @override
  Future<String> uploadImageTofirebase(File imagefile) async {
    final firestorageref = FirebaseStorage.instance.ref();
    final uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
    final refimagetoupload = firestorageref.child('images').child(uniqueName);

    await refimagetoupload.putFile(imagefile).then((p0) => null);

    final imageurl = await refimagetoupload.getDownloadURL();

    return imageurl;
  }
}
