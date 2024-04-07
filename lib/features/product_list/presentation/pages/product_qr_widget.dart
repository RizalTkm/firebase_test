
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductQrWidget extends StatelessWidget {
   const   ProductQrWidget({super.key,  this.snapshotdata});

  final dynamic snapshotdata  ;
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(
      child: QrImageView(data: snapshotdata['productname']+ snapshotdata["measurement"]+snapshotdata["price"],size: 200,),
    ),);
  }
}