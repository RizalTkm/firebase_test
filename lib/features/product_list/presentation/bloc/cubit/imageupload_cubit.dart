import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'imageupload_state.dart';

class ImageuploadCubit extends Cubit<ImageuploadState> {
  ImageuploadCubit() : super(ImageuploadInitial());

  Future<List<File>> UploadImages() async {
    emit(ImageuploadInitial());
    final picker = ImagePicker();
    final List<File> SelectedImages = [];

    try {
      final pickedImages = await picker.pickMultiImage(
          maxHeight: 400, maxWidth: 400, imageQuality: 100);

      if (pickedImages.isNotEmpty) {
        pickedImages.forEach((element) {
          SelectedImages.add(File(element.path));
        });
        emit(Imageuploadsuccess());
        return SelectedImages;
      } else {
        emit(ImageuploadFailure());
        return SelectedImages;
      }
    } catch (e) {
      emit(ImageuploadFailure());
      return SelectedImages;
    }
  }
}
