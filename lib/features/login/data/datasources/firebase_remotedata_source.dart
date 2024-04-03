import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signinUser({required LoginEntity userCred});

  Future<String> getCurrentUSerId();

  Future<void> getCreateCurrentUser(LoginEntity userCred);

  Future<bool> issignIn();

  Future<void> signup(LoginEntity usercred);
  Future<void> signout();
}
