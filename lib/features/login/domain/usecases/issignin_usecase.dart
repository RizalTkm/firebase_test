import 'package:firesbase_test/features/login/domain/repository/login_repositoy.dart';

class IsSignInUseCase {

final FirebaseRepository firebaseRepository;

  IsSignInUseCase({required this.firebaseRepository});


Future<bool> isSignin()async {

  return firebaseRepository.isSignIn();
}

}