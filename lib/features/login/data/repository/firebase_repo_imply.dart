import 'package:firesbase_test/features/login/data/datasources/firebase_remotedata_source.dart';
import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';
import 'package:firesbase_test/features/login/domain/repository/login_repositoy.dart';

class FirebaseRepositoryImply implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDatasource;

  FirebaseRepositoryImply({required this.remoteDatasource});

  @override
  Future<void> signinUser({required LoginEntity userCred}) async {
    remoteDatasource.signinUser(userCred: userCred);
  }

  @override
  Future<bool> isSignIn() async {
    return await remoteDatasource.issignIn();
  }

  @override
  Future<void> signup({required LoginEntity userCred}) async {
   await  remoteDatasource.signup(userCred);
  }
  
  @override
  Future<void> getCreateCurrentUser(LoginEntity user) async {

    await remoteDatasource.getCreateCurrentUser(user);
    
  }
  
  @override
  Future<String> getCurrentUId() async {
  
    return  await remoteDatasource.getCurrentUSerId();
  }
  
  @override
  Future<void> signout() async{
    
    await remoteDatasource.signout();
    
  }
}
