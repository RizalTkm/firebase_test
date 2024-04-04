

import 'package:firesbase_test/features/product_list/domain/entities/product_details.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  @override
  String? productname;
  @override
  String? measurement;
  @override
  String? price;

  ProductDetailsModel({this.productname, this.measurement, this.price});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    productname = json['productname'];
    measurement = json['measurement'];
    price = json['price'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productname'] = productname;
    data['measurement'] = measurement;
    data['price'] = price;
    return data;
  }
}