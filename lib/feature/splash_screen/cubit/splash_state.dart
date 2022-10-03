part of 'splash_cubit.dart';

 class SplashState extends Equatable {
  List<SettingData> settingData;
  final bool? isSuccess;
  final bool? isFailure;
  final bool? isLoading;
  String? errormessage;
  final bool isLoggedIn;


  @override
  List<Object> get props => [
    settingData,
    isSuccess!,
    isFailure!,
    isLoading!,
    isLoggedIn
  ];

  SplashState({
    required this.settingData,
    this.isSuccess,
    this.isFailure,
    this.isLoading,
    this.errormessage,
    required this.isLoggedIn,
  });

  factory SplashState.empty() {
    return SplashState(
        settingData: [],
        isSuccess: false,
        isFailure: false,
        isLoading: false,
      errormessage: '',
        isLoggedIn: false
    );
  }
  SplashState copyWith({
    List<SettingData>? settingData,
    bool? isSuccess,
    bool? isFailure,
    bool? isLoading,
    bool? isLoggedIn,
    String? errormessage,
  }) {
    return SplashState(
      settingData: settingData ?? this.settingData,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isLoading: isLoading ?? this.isLoading,
      errormessage: errormessage ?? this.errormessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }


  @override
  bool get stringify => true;
}




