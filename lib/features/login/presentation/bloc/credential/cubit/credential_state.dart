part of 'credential_cubit.dart';

abstract class CredentialState extends Equatable {
  const CredentialState();
}

final class CredentialInitial extends CredentialState {
  @override
  List<Object?> get props => [];
}

final class CredentialSuccesstate extends CredentialState {

  final uid ;
  CredentialSuccesstate(this.uid);
  @override
  List<Object?> get props => [uid];
}

final class CredentialFailure extends CredentialState {
  @override
  List<Object?> get props => [];
}

final class CredentialLoading extends CredentialState {
  @override
  List<Object?> get props => [];
}
