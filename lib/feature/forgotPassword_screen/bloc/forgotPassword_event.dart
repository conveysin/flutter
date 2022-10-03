

import 'package:equatable/equatable.dart';

abstract class ForgotPassword_Event extends Equatable {
  const ForgotPassword_Event();

  @override
  List<Object> get props => [];
}
class PasswordChanged extends ForgotPassword_Event{
  PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}
class ConfirmPasswordChanged extends ForgotPassword_Event{
  ConfirmPasswordChanged(this.confirmpassword);
  final String confirmpassword;

  @override
  List<Object> get props => [confirmpassword];
}
class NameChanged extends ForgotPassword_Event{
  NameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

class MobileChanged extends ForgotPassword_Event {
  MobileChanged(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}

class ForgotPasswordClicked extends ForgotPassword_Event {
  ForgotPasswordClicked(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}





