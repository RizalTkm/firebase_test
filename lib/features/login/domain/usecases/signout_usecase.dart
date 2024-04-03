import 'package:firesbase_test/features/login/domain/repository/login_repositoy.dart';

class SignOutUseCase{

  final FirebaseRepository firebaseRepository;

  SignOutUseCase({required this.firebaseRepository});


  Future<void> signOut()async {

      await firebaseRepository.signout();
  }

}