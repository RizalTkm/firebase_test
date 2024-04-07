import 'dart:html';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductQrWidget extends StatelessWidget {
  const ProductQrWidget({super.key, required this.qrdata});

  final String qrdata ;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(
      child: QrImageView(data: qrdata,size: 200,),
    ),);
  }
}