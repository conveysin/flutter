part of 'pilot_bloc.dart';

@immutable
class PilotState extends Equatable {
  List<DistrictData> districtData;
  List<MandalData> mandalData;
  List<VillageData> villageData;
   List<DepartmentData> departmentData;
   SignupData? signupData;
  final bool? isOtpValid;
  final bool? isEmailValid;
  final bool? isSubmitting;
  final bool? isSuccess;
  final bool? isFailure;
  String errormessage;
  final bool isMobile;
  final bool isName;
  final bool isPassword;
  final bool isResnd;
  final bool isOtp;
  final String? name;
  final String? email;
  final bool isUsernameReadOnly;
  final bool isUserExist;
  final bool isLoading;
  String districtID;
  String mandalID;
  String villageID;
  String departmentID;
  final bool isPilotPostLoading;
  final bool isPilotPostSuccess;
  final bool isPilotPostFailure;
  final bool isOTPSuccess;
  final bool isOTPFailure;
  final int? postID;


  bool get isFormValid => (isMobile);

  PilotState({
    required this.departmentData,
    required this.districtData,
     this.signupData,
    required this.mandalData,
    required this.villageData,
    this.isLoading = false,
    this.isSubmitting= false,
    this.isSuccess,
    this.isFailure,
    this.errormessage = '',
    this.isMobile = false,
    this.isName = false,
    this.isPassword = false,
    this.isOtp = false,
    this.isUsernameReadOnly = false,
    this.isUserExist = false,
    this.isOtpValid,
    this.isEmailValid,
    this.isResnd = false,
    this.email = '',
    this.name = '',
    this.districtID = '',
    this.mandalID = '',
    this.villageID = '',
    this.departmentID = '',
    this.isPilotPostLoading=false,
    this.isPilotPostSuccess=false,
    this.isPilotPostFailure=false,
  this.isOTPSuccess = false,
   this.isOTPFailure= false,
   this.postID= 0,
  });

  factory PilotState.empty() {
    return PilotState(
        departmentData:[],
        districtData: [],
 //       signupData:,
        mandalData: [],
        villageData: [],
        isOtpValid: false,
        isEmailValid: false,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        isMobile: false,
        isName: false,
        isPassword: false,
        isResnd: false,
        isUserExist: false,
        isLoading: false,
        errormessage: '',
        districtID: '',
        mandalID: '',
        villageID: '',
        departmentID: '',
        isPilotPostLoading: false,
        isPilotPostFailure: false,
        isPilotPostSuccess: false,
      isOTPSuccess : false,
        isOTPFailure :false,
        postID :0
    );
  }

  factory PilotState.loading(bool isPartial) {
    return PilotState(
        districtData: [],
      departmentData: [],
     // signupData: ,
        mandalData: [],
        villageData: [],
        isLoading: true,
        isOtpValid: true,
        isEmailValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFailure: false,
        isResnd: false,
      postID: 0,
     );
  }

  factory PilotState.failure(String errorMessage, bool isPartial) {
    return PilotState(
      departmentData: [],
      mandalData: [],
      districtData: [],
     // signupData: [],
      villageData: [],
      isOtpValid: false,
      isEmailValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isResnd: false,
      postID: 0,
    );
  }

  factory PilotState.socialLoginFailure(String errorMessage) {
    return PilotState(
      departmentData: [],
      districtData: [],
     // signupData: [],
      mandalData: [],
      villageData: [],
      isOtpValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      postID: 0,
    );
  }

  factory PilotState.success(bool? isUserExist) {
    return PilotState(
      departmentData: [],
        districtData: [],
     // signupData: [],
        mandalData: [],
        villageData: [],
        isOtpValid: true,
        isEmailValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFailure: false,
        isResnd: false,
        isUserExist: isUserExist!,
      );
  }

  PilotState update({
    bool? isMobile,
    bool? isName,
    bool? isPassword,
    bool? isPasswordValid,
    bool? isOtpValid,
    bool? isEmailValid,
    int?postID,
  }) {
    return copyWith(
      isOtpValid: isOtpValid,
      isEmailValid: isEmailValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  PilotState copyWith({
    List<DistrictData>? disctrictData,
    List<DepartmentData>? departmentData,
    SignupData? signupData,
    List<MandalData>? mandalData,
    List<VillageData>? villageData,
    bool? isOtpValid,
    bool? isEmailValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isMobile,
    bool? isName,
    bool? isPassword,
    bool? isResnd,
    bool? isUsernameReadOnly,
    bool? isLoading,
    String? districtID,
    String? mandalID,
    String? villageID,
    String? departmentID,
    bool? isPilotPostLoading,
    bool? isPilotPostFailure,
    bool? isPilotPostSuccess,
    bool? isOTPSuccess,
    bool? isOTPFailure,
    String? errormessage,
    int?postID
  }) {
    return PilotState(
      departmentData: departmentData ?? this.departmentData,
      districtData: disctrictData ?? this.districtData,
      signupData: signupData ?? this.signupData,
      mandalData: mandalData ?? this.mandalData,
      villageData: villageData ?? this.villageData,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isMobile: isMobile ?? this.isMobile,
      isName: isName ?? this.isName,
      isPassword: isPassword ?? this.isPassword,
      isUsernameReadOnly: isUsernameReadOnly ?? this.isUsernameReadOnly,
      isOtpValid: isOtpValid ?? this.isOtpValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isResnd: isResnd ?? this.isResnd,
      isLoading: isLoading ?? this.isLoading,
      districtID: districtID ?? this.districtID,
      mandalID: mandalID ?? this.mandalID,
      villageID: villageID ?? this.villageID,
      departmentID: departmentID ?? this.departmentID,
      isPilotPostLoading: isPilotPostLoading ?? this.isPilotPostLoading,
      isPilotPostSuccess: isPilotPostSuccess ?? this.isPilotPostSuccess,
      isPilotPostFailure: isPilotPostFailure ?? this.isPilotPostFailure,
      isOTPFailure: isOTPFailure ?? this.isOTPFailure,
      isOTPSuccess: isOTPSuccess ?? this.isOTPSuccess,
      errormessage: errormessage ?? this.errormessage,
      postID: postID ?? this.postID,
    );
  }

  @override
  String toString() {
    return '''PilotState {
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      errormessage: $errormessage,
      isPilotPostLoading :$isPilotPostLoading
isPilotPostFailure:$isPilotPostFailure
isPilotPostSuccess:$isPilotPostSuccess
isOTPSuccess:$isOTPSuccess
isOTPFailure:$isOTPFailure
     
    }''';
  }

  @override
  List<Object> get props => [
        districtData,
    departmentData,
        mandalData,
        villageData,
        isOtpValid!,
        isSubmitting!,
        isSuccess!,
        isFailure!,
        isMobile,
        isName,
        isPassword,
        isUsernameReadOnly,
        isResnd,
        isUserExist,
        districtID,
        mandalID,
        villageID,
    departmentID,
    isPilotPostLoading,
    isPilotPostFailure,
    isPilotPostSuccess,
    isOTPFailure,
    isOTPSuccess,
    errormessage
      ];

  @override
  bool get stringify => true;
}
