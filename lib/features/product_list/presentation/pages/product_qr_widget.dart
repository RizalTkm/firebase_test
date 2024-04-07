import 'package:firesbase_test/features/product_list/presentation/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductQrWidget extends StatelessWidget {
  const ProductQrWidget({super.key, this.snapshotdata});

  final dynamic snapshotdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50), child: CustomappbarWidget(title: "QR code")),
      body: Center(
        child: Column(
          children: [
          const  Padding(
             padding:  EdgeInsets.all(8.0),
             child:   Text("Please scan the QR code for Product Detais"),
           ), 
            Card(elevation: 10,
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
          ],
        ),
      ),
    );
  }
}
