part of 'imageupload_cubit.dart';

sealed class ImageuploadState extends Equatable {
  const ImageuploadState();

}

final class ImageuploadInitial extends ImageuploadState {

  
  @override
  List<Object> get props => [];
}

final class Imageuploadsuccess extends ImageuploadState {

  
  @override
  List<Object> get props => [];
}


final class ImageuploadFailure extends ImageuploadState {

  
  @override
  List<Object> get props => [];
}
