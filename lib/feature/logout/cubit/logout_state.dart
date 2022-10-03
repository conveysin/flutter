part of 'logout_cubit.dart';

@immutable
class LogoutState extends Equatable {
  final bool isContactusFailure;
  final bool isContactusLoading;
  final bool isContactusSuccess;
  final bool? isSubmitting;
  final String errorMsg;
  LogoutState({
    this.isContactusFailure = false,
    this.isContactusLoading = true,
    this.isContactusSuccess = false,
    this.isSubmitting = false,
    this.errorMsg=''
  });
  @override
  List<Object> get props {
    return [
      isContactusFailure,
      isContactusLoading,
      isContactusSuccess,
      isSubmitting!,
      errorMsg
    ];
  }

  LogoutState copyWith(
      {
        bool? isContactusFailure,
        bool? isContactusLoading,
        bool? isContactusSuccess,
        bool? isSubmitting,
        String? errorMsg,
        }) {
    return LogoutState(
      isContactusFailure: isContactusFailure ?? this.isContactusFailure,
      isContactusLoading: isContactusLoading ?? this.isContactusLoading,
      isContactusSuccess:isContactusSuccess??this.isContactusSuccess,
      isSubmitting:isSubmitting??this.isSubmitting,
      errorMsg:errorMsg??this.errorMsg,
       );
  }

  @override
  bool get stringify => true;
}
