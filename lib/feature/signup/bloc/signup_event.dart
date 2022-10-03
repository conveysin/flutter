
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordClicked extends SignupEvent{}

class MobileChanged extends SignupEvent{
  MobileChanged(this.mobile);
  final String mobile;

  @override
  List<Object> get props => [mobile];
}
class NameChanged extends SignupEvent{
  NameChanged(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}
class EmailChanged extends SignupEvent{
  EmailChanged(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}
class PasswordChanged extends SignupEvent{
  PasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}
class ConfirmPasswordChanged extends SignupEvent{
  ConfirmPasswordChanged(this.confirmpassword);
  final String confirmpassword;

  @override
  List<Object> get props => [confirmpassword];
}
class OtpChanged extends SignupEvent{
  OtpChanged(this.otp);
  final String otp;

  @override
  List<Object> get props => [otp];
}
class ResendOtpClicked extends SignupEvent{
  ResendOtpClicked(this.number);
  final String number;

  @override
  List<Object> get props => [number];
}
class PasswordVisiblilityChanged extends SignupEvent{
  PasswordVisiblilityChanged(this.isVisible);
  final bool isVisible;

  @override
  List<Object> get props => [isVisible];
}

class SignUpWithCredentialsClicked extends SignupEvent{
  SignUpWithCredentialsClicked(this.mobile,this.password,this.name,this.confirmpassword);
  final String mobile;
  final String password;
  final String name;
  final String confirmpassword;
  @override
  List<Object> get props => [mobile,password,name,confirmpassword];
}




class ResendClicked extends SignupEvent{
  ResendClicked(this.userId);
   var userId;

  @override
  List<Object> get props => [userId];
}
class getLanguages extends SignupEvent{
  getLanguages();
}




class LoginWithCredentialsOtp extends SignupEvent{
  LoginWithCredentialsOtp(this.mobile,this.otp);
  final String mobile;
  final String otp;

  @override
  List<Object> get props => [mobile,otp];
}
class UpdateLanguage extends SignupEvent{
  UpdateLanguage(this.mobile,this.otp);
  final String mobile;
  final String otp;

  @override
  List<Object> get props => [mobile,otp];
}
