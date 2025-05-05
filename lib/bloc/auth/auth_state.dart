part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginState extends AuthState {}

class RegistrationState extends AuthState {}

class ForgotPasswordState extends AuthState {}
