
abstract class AuthEvent {}

class ShowLogin extends AuthEvent {}

class ShowRegistration extends AuthEvent {}

class ShowForgotPassword extends AuthEvent {}

class Login extends AuthEvent {}

class Registration extends AuthEvent {}

class ForgotPassword extends AuthEvent {}