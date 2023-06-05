import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}

class AuthInitialState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthCodeSentState extends AuthState{}

class AuthVerifiedState extends AuthState{}

class AuthLoggedInState extends AuthState{
  final User currentUser;
  AuthLoggedInState(this.currentUser);
}

class AuthLoggedOutState extends AuthState{}

class AuthErrorState extends AuthState{
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}