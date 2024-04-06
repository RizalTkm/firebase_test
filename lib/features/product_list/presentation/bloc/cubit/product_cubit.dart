import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firesbase_test/features/product_list/data/models/product_model.dart';
import 'package:firesbase_test/features/product_list/domain/repository/product_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepository) : super(ProductInitial());

  final ProductRepository productRepository;

  Future<List<String>> uploadImagesTofirebase(List<File> images) async {
    emit(ProductInitial());

    try {
      emit(ProductUploadLoading());

      final imageurls = Future.wait(images.map((image) async {
        return await productRepository.uploadImageTofirebase(image);
      }).toList());

      return imageurls;
    } catch (e) {
      emit(ProductuploadFailure());

      return Future.value(['Image upload failed']);
    }
  }

  Future<void> uploadProductDetails(
      ProductDetailsModel productDetailsModel) async {
    try {
      emit(ProductUploadLoading());
      await productRepository.submitNewProduct(productDetailsModel);
    } catch (e) {
      emit(ProductuploadFailure());
    }
  }
}
