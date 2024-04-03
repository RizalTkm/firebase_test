import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';
import 'package:firesbase_test/features/login/domain/repository/login_repositoy.dart';

class SignUpUseCase{

  final FirebaseRepository firebaseRepository;

  SignUpUseCase({required this.firebaseRepository});



Future<void> signup(LoginEntity loginEntity)async {

  firebaseRepository.signup(userCred: loginEntity);
}

}