import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductQrWidget extends StatelessWidget {
  const ProductQrWidget({super.key, this.snapshotdata});

  final dynamic snapshotdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: QrImageView(
          data:
              "${"Name :" + ' ' + snapshotdata['productname'].toString() + '\n' + "Size :" " " + snapshotdata["measurement"].toString()}\nPrice :"
                      " " +
                  snapshotdata["price"].toString() +
                  "\n" +
                  "Link :" +
                  " " +
                  snapshotdata["imageurls"][0].toString(),
          version: QrVersions.auto,
          size: 200,
        ),
      ),
    );
  }
}
