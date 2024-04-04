




class ProductDetailsEntity {

  String? productname;
  String? measurement;
  String? price;

  ProductDetailsEntity({this.productname, this.measurement, this.price});

  ProductDetailsEntity.fromJson(Map<String, dynamic> json) {
    productname = json['productname'];
    measurement = json['measurement'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productname'] = productname;
    data['measurement'] = measurement;
    data['price'] = price;
    return data;
  }

 
}