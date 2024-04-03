




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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = this.productname;
    data['measurement'] = this.measurement;
    data['price'] = this.price;
    return data;
  }

 
}