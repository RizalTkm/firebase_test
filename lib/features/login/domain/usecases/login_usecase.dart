import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';
import 'package:firesbase_test/features/login/domain/repository/login_repositoy.dart';

class LoginUsecase{

  final FirebaseRepository firebaseRepository;

  LoginUsecase({required this.firebaseRepository});


  Future<void> signIn({required LoginEntity loginEntity})async {


     await  firebaseRepository.signinUser(userCred: loginEntity); 

     

  }


  
}  