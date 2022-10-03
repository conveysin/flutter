part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  final List<DepartmentData> departmentData;
  final bool isHomedataFailure;
  final bool isHomedataLoading;
  final bool isHomedataSuccess;
  final String errorMsg;
  final String sponser_name;
  HomeState({
    required this.departmentData,
    this.isHomedataFailure = false,
    this.isHomedataLoading = true,
    this.isHomedataSuccess = false,
    this.errorMsg='',
    this.sponser_name=''
  });
  @override
  List<Object> get props {
    return [
      departmentData,
      isHomedataFailure,
      isHomedataLoading,
      isHomedataSuccess
      ,errorMsg,
      sponser_name
    ];
  }

  HomeState copyWith(
      {List<DepartmentData>? departmentData,
      List<String>? slider,
        bool? isHomedataFailure,
        bool? isHomedataLoading,
        bool? isHomedataSuccess,
        String? errorMsg,
        String? sponser_name,
        }) {
    return HomeState(
      departmentData: departmentData ?? this.departmentData,
      isHomedataFailure: isHomedataFailure ?? this.isHomedataFailure,
      isHomedataLoading: isHomedataLoading ?? this.isHomedataLoading,
      isHomedataSuccess:isHomedataSuccess??this.isHomedataSuccess,
      errorMsg:errorMsg??this.errorMsg,
      sponser_name:sponser_name??this.sponser_name,
       );
  }

  @override
  bool get stringify => true;
}
