import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firesbase_test/features/login/domain/usecases/getcurrent_uid.dart';
import 'package:firesbase_test/features/login/domain/usecases/issignin_usecase.dart';
import 'package:firesbase_test/features/login/domain/usecases/signout_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.isSignInUseCase,
      required this.getCurrentUidUseCase,
      required this.signOutUseCase})
      : super(AuthInitial());

  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final SignOutUseCase signOutUseCase;

  Future<void> Appstarted() async {
    try {
      final isSignin = await isSignInUseCase.isSignin();

      if (isSignin) {
        final uid = await getCurrentUidUseCase.getCurrentUid();
        emit(AuthenticatedState(uid: uid));
      } else {
        emit(UnauthenticatedState());
      }
    } on SocketException catch (_) {
      emit(UnauthenticatedState());
    }
  }

  Future<void> SignOut() async {
    try {
      await signOutUseCase.signOut();

      emit(UnauthenticatedState());
    } catch (e) {
      emit(UnauthenticatedState());
    }
  }

  Future<bool> loggedIn() async {
    bool isloggedIn = false;

    try {
      final uid = await getCurrentUidUseCase.getCurrentUid();

      emit(AuthenticatedState(uid: uid));

      return uid != '' ? true : false;
    } catch (e) {
      isloggedIn = false;
      emit(UnauthenticatedState());
      return isloggedIn;
    }
  }
}
