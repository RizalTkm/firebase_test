import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';

class loginModel extends LoginEntity{

  final String? username;
  final String? password;
  final String? uid;

  loginModel( { this.username,  this.password,this.uid,}):super(username: username,password: password);




  factory loginModel.fromsnapShot(DocumentSnapshot snapshot){

    return loginModel(
      username: snapshot.get('username'),
      password: snapshot.get('password'),
      uid: snapshot.get('uid')
      
    );

  }

  Map<String,dynamic> toDocument(){
    return {
      "username":username,
      
    };
  }
}