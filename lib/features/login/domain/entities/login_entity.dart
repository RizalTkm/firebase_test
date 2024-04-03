import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? username;
  final String? password;
  final String? uid;

  LoginEntity({this.username, this.password,this.uid});

  @override

  List<Object?> get props => [username, password];
}
