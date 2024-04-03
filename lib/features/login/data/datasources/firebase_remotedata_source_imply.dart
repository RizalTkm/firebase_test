import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firesbase_test/features/login/data/datasources/firebase_remotedata_source.dart';
import 'package:firesbase_test/features/login/data/model/login_model.dart';
import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';

class FirebaseRDataSourceImply implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRDataSourceImply({ required this.firestore, required this.auth});

  @override
  Future<void> signinUser({required LoginEntity userCred}) async {
    await auth.signInWithEmailAndPassword(
        email: userCred.username!, password: userCred.password!);
  }

  @override
  Future<String> getCurrentUSerId() async {
    return  auth.currentUser!.uid;
  }

  @override
  Future<void> getCreateCurrentUser(LoginEntity userCred) async {
    final userCollection = firestore.collection("users");

    final uid = await getCurrentUSerId();

    userCollection.doc(uid).get().then((userDoc) {
      final newuser = loginModel(
              username: userCred.username,
              password: userCred.password,
              uid: userCred.uid)
          .toDocument();

      if (!userDoc.exists) {
        userCollection.doc(uid).set(newuser);
      }
    });
  }

  @override
  Future<bool> issignIn() async {
    final status = auth.currentUser?.uid.isNotEmpty;

    return status!;
  }

  @override
  Future<void> signup(LoginEntity usercred) async {
    await auth.createUserWithEmailAndPassword(
        email: usercred.username!, password: usercred.password!);
  }
  
  @override
  Future<void> signout()async  {
  
  await auth.signOut();
  }
}
