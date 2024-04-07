import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';

abstract class FirebaseRepository {
  Future<dynamic> signinUser({required LoginEntity userCred});
  Future<bool> isSignIn();
  Future<void> signup({required LoginEntity userCred});
  Future<void> getCreateCurrentUser(LoginEntity user);
  Future<String> getCurrentUId();

  Future<void> signout();
}
