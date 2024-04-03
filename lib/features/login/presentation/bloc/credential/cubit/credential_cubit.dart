import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';
import 'package:firesbase_test/features/login/domain/usecases/login_usecase.dart';
import 'package:firesbase_test/features/login/domain/usecases/signup_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  CredentialCubit({required this.loginUsecase, required this.signUpUseCase})
      : super(CredentialInitial());

  final LoginUsecase loginUsecase;
  final SignUpUseCase signUpUseCase;

  Future<void> submitSignUp({required LoginEntity usercred}) async {

    emit(CredentialLoading());
    try {
      signUpUseCase.signup(usercred);
      emit(CredentialSuccesstate());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitSignin({required LoginEntity usercred}) async {

    emit(CredentialLoading());
    try {
      loginUsecase.signIn(loginEntity: usercred);
      emit(CredentialSuccesstate());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
