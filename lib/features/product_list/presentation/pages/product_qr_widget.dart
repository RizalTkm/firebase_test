<<<<<<< HEAD
=======

>>>>>>> 793232f37b8a1e68e25e6f81a357892f9d9fd31a
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductQrWidget extends StatelessWidget {
<<<<<<< HEAD
  const ProductQrWidget({super.key, this.qrdata});

  final String? qrdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImageView(
          data: qrdata.toString(),
          size: 200,
          version: QrVersions.auto,
        ),
      ),
    );
=======
   const ProductQrWidget({super.key,  this.snapshotdata});

  final dynamic snapshotdata  ;
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(
      child: QrImageView(data: snapshotdata['productname']+ snapshotdata["measurement"]+snapshotdata["price"],size: 200,),
    ),);
>>>>>>> 793232f37b8a1e68e25e6f81a357892f9d9fd31a
  }
}
