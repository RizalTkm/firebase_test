import 'package:firesbase_test/features/product_list/domain/entities/product_details.dart';

abstract class ProductRepository {


  Future<dynamic> submitNewProduct();

  Future<List<ProductDetailsEntity>> getProductList();

}