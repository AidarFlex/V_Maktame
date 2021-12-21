part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  const AuthLoading();
  @override
  List<Object> get props => [];
}

class AuthSingedUp extends AuthState {
  const AuthSingedUp();
  @override
  List<Object> get props => [];
}

class AuthSingedIn extends AuthState {
  const AuthSingedIn();
  @override
  List<Object> get props => [];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
  @override
  List<Object> get props => [message];
}
