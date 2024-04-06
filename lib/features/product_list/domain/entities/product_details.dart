import 'dart:io';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProductDetailsEntity extends Equatable {
  String? productname;
  String? measurement;
  String? price;
  List<String> imageUrls;

  ProductDetailsEntity({required this.productname, required this.measurement,required this.price,required this.imageUrls});

  @override
  List<Object?> get props => [productname, measurement, price];
}
