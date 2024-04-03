import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firesbase_test/features/login/data/datasources/firebase_remotedata_source.dart';
import 'package:firesbase_test/features/login/data/datasources/firebase_remotedata_source_imply.dart';
import 'package:firesbase_test/features/login/data/repository/firebase_repo_imply.dart';
import 'package:firesbase_test/features/login/domain/repository/login_repositoy.dart';
import 'package:firesbase_test/features/login/domain/usecases/getcurrent_uid.dart';
import 'package:firesbase_test/features/login/domain/usecases/issignin_usecase.dart';
import 'package:firesbase_test/features/login/domain/usecases/login_usecase.dart';
import 'package:firesbase_test/features/login/domain/usecases/signout_usecase.dart';
import 'package:firesbase_test/features/login/domain/usecases/signup_usecase.dart';
import 'package:firesbase_test/features/login/presentation/bloc/auth/cubit/auth_cubit.dart';
import 'package:firesbase_test/features/login/presentation/bloc/credential/cubit/credential_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc

  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
      signOutUseCase: sl.call()));

  sl.registerFactory<CredentialCubit>(() => CredentialCubit(
      loginUsecase: sl.call(), signUpUseCase: sl.call()));

//usecase
//authusecase registration
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(firebaseRepository: sl.call()));
      sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(firebaseRepository: sl.call()));

// credusecase registration
   sl.registerLazySingleton<LoginUsecase>(() => LoginUsecase(firebaseRepository: sl.call()));
   sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(firebaseRepository: sl.call()));
   

  //repository
   sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImply(remoteDatasource: sl.call()));
  
 

  //remotesources

  sl.registerLazySingleton<FirebaseRemoteDataSource>(() => FirebaseRDataSourceImply(firestore: sl.call(), auth: sl.call()));

  //external

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
}
