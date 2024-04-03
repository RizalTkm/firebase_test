import 'package:firesbase_test/features/login/domain/repository/login_repositoy.dart';

class GetCurrentUidUseCase{


  final FirebaseRepository firebaseRepository;

  GetCurrentUidUseCase({required this.firebaseRepository});


  Future<String>getCurrentUid()async {

  return await  firebaseRepository.getCurrentUId();
  }

}