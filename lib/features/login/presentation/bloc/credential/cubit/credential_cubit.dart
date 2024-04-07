import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firesbase_test/features/login/domain/entities/login_entity.dart';
import 'package:firesbase_test/features/login/domain/usecases/getcurrent_uid.dart';
import 'package:firesbase_test/features/login/domain/usecases/login_usecase.dart';
import 'package:firesbase_test/features/login/domain/usecases/signup_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  CredentialCubit(
      {required this.getCurrentUidUseCase,
      required this.loginUsecase,
      required this.signUpUseCase})
      : super(CredentialInitial());

  final LoginUsecase loginUsecase;
  final SignUpUseCase signUpUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

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
      final cred = await loginUsecase.signIn(loginEntity: usercred);
      if (cred != null) {
        emit(CredentialSuccesstate());
      } else {
        emit(CredentialFailure());
      }
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
