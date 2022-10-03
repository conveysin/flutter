part of 'forgotPassword_bloc.dart';

@immutable
class ForgotPassword_State extends Equatable {
  ForgotPassword_State(
      {this.isSubmitting,
        this.isSuccess,
        this.isFailure,
        this.errorMessage,
        this.isMobile = false,
        this.isPassword = false,
        this.isOtp = false,
        this.isUsernameReadOnly = false,
        this.isUserExist=false,
        this.isOtpValid,
        this.isEmailValid,
        this.isResnd = false,
        this.email = '',
        this.name = ''});
  factory ForgotPassword_State.empty() {
    return ForgotPassword_State(
        isOtpValid: false,
        isEmailValid: false,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isMobile: false,
        isPassword: false,
        isResnd: false,
        isUserExist:false,
        errorMessage: '');
  }
  factory ForgotPassword_State.loading(bool isPartial) {
    return ForgotPassword_State(
        isOtpValid: true,
        isEmailValid: true,
        isSubmitting: isPartial,
        isSuccess: false,
        isFailure: false,
        isResnd: false,
        errorMessage: '');
  }
  factory ForgotPassword_State.failure(String errorMessage, bool isPartial) {
    return ForgotPassword_State(
      isOtpValid: false,
      isEmailValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isResnd: false,
      errorMessage: errorMessage,
    );
  }

  factory ForgotPassword_State.socialLoginFailure(String errorMessage) {
    return ForgotPassword_State(
      isOtpValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }

  factory ForgotPassword_State.success(bool? isUserExist) {
    return ForgotPassword_State(
        isOtpValid: true,
        isEmailValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        isResnd: false,
        isUserExist:isUserExist!,
        errorMessage: '');
  }

  final bool? isOtpValid;
  final bool? isEmailValid;
  final bool? isSubmitting;
  final bool? isSuccess;
  final bool? isFailure;

  final String? errorMessage;
  final bool isMobile;
  final bool isPassword;
  final bool isResnd;
  final bool isOtp;
  final String? name;
  final String? email;
  final bool isUsernameReadOnly;
  final bool isUserExist;


  bool get isFormValid => (isMobile);

  ForgotPassword_State update({
    bool? isMobile,
    bool? isPassword,
    bool? isPasswordValid,
    bool? isOtpValid,
    bool? isEmailValid,
    String? errorMessage,
  }) {
    return copyWith(
      isOtpValid: isOtpValid,
      isEmailValid: isEmailValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false, errorMessage: '',
    );
  }

  ForgotPassword_State copyWith({
    bool? isOtpValid,
    bool? isEmailValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isMobile,
    bool? isPassword,
    bool? isResnd,
    bool? isUsernameReadOnly,
    String? errorMessage,
  }) {
    return ForgotPassword_State(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isMobile: isMobile ?? this.isMobile,
      isPassword: isPassword ?? this.isPassword,
      isUsernameReadOnly: isUsernameReadOnly ?? this.isUsernameReadOnly,
      isOtpValid: isOtpValid ?? this.isOtpValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isResnd: isResnd ?? this.isResnd,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return '''ForgotPassword_State {
    
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
     
    }''';
  }

  @override
  List<Object> get props => [
    isOtpValid!,
    isSubmitting!,
    isSuccess!,
    isFailure!,
    isMobile,
    isPassword,
    isUsernameReadOnly,
    isResnd,isUserExist
  ];
}