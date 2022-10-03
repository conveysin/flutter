
import 'package:equatable/equatable.dart';

abstract class PilotEvent extends Equatable {
  const PilotEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordClicked extends PilotEvent{}

class MobileChanged extends PilotEvent{
  MobileChanged(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}
class NameChanged extends PilotEvent{
  NameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}
class EmailChanged extends PilotEvent{
  EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}
class PasswordChanged extends PilotEvent{
  PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}
class ConfirmPasswordChanged extends PilotEvent{
  ConfirmPasswordChanged(this.confirmpassword);
  final String confirmpassword;

  @override
  List<Object> get props => [confirmpassword];
}
class OtpChanged extends PilotEvent{
  OtpChanged(this.otp);
  final String otp;

  @override
  List<Object> get props => [otp];
}
class ResendOtpClicked extends PilotEvent{
  ResendOtpClicked(this.number);
  final String number;

  @override
  List<Object> get props => [number];
}
class PasswordVisiblilityChanged extends PilotEvent{
  PasswordVisiblilityChanged(this.isVisible);
  final bool isVisible;

  @override
  List<Object> get props => [isVisible];
}

class SignUpWithCredentialsClicked extends PilotEvent{
  SignUpWithCredentialsClicked(this.mobile,this.password,this.name,this.confirmpassword);
  final String mobile;
  final String password;
  final String name;
  final String confirmpassword;
  @override
  List<Object> get props => [mobile,password,name,confirmpassword];
}




class ResendClicked extends PilotEvent{
  ResendClicked(this.userId);
   var userId;

  @override
  List<Object> get props => [userId];
}
class getLanguages extends PilotEvent{
  getLanguages();
}




class LoginWithCredentialsOtp extends PilotEvent{
  LoginWithCredentialsOtp(this.mobile,this.otp);
  final String mobile;
  final String otp;

  @override
  List<Object> get props => [mobile,otp];
}
class UpdateLanguage extends PilotEvent{
  UpdateLanguage(this.mobile,this.otp);
  final String mobile;
  final String otp;

  @override
  List<Object> get props => [mobile,otp];
}
