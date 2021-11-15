part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class LoginEvent extends AuthEvent {


  final UserAuthModel userAuthModel;

  LoginEvent(
      {required this.userAuthModel});
  @override
  List<Object?> get props => [this.userAuthModel];
}

class RegisterEvent extends AuthEvent {
  final UserAuthModel userAuthModel;

  RegisterEvent(
      {required this.userAuthModel});

  @override
  List<Object?> get props => [this.userAuthModel];
}
