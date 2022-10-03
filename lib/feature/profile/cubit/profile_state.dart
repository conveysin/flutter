part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable {
  final bool isProfiledataFailure;
  final bool isProfiledataLoading;
  final bool isProfiledataSuccess;
  final bool isEditProfiledataSuccess ;
  ProfileModel profileData;
  final String errorMsg;
  List<DistrictData> districtData;
  List<MandalData> mandalData;
  List<VillageData> villageData;
  String districtID;
  String mandalID;
  String villageID;

  ProfileState({
    this.isProfiledataFailure = false,
    this.isProfiledataLoading = true,
    this.isProfiledataSuccess = false,
    this.isEditProfiledataSuccess = false,
    this.errorMsg = '',
    required this.profileData,
    required this.districtData,
    required this.mandalData,
    required this.villageData,
    this.districtID = '',
    this.mandalID = '',
    this.villageID = '',
  });

  @override
  List<Object> get props {
    return [
      isProfiledataFailure,
      isProfiledataLoading,
      isProfiledataSuccess,
      isEditProfiledataSuccess,
      errorMsg,
      profileData,
      mandalData,
      districtData,
      villageData,
      districtID,
      mandalID,
      villageID,
    ];
  }

  ProfileState copyWith({
    List<DistrictData>? disctrictData,
    List<MandalData>? mandalData,
    List<VillageData>? villageData,
    bool? isProfiledataFailure,
    bool? isProfiledataLoading,
    bool? isProfiledataSuccess,
    bool? isEditProfiledataSuccess,
    String? errorMsg,
    ProfileModel? profileData,
    String? districtID,
    String? mandalID,
    String? villageID,
  }) {
    return ProfileState(
      isProfiledataFailure: isProfiledataFailure ?? this.isProfiledataFailure,
      isProfiledataLoading: isProfiledataLoading ?? this.isProfiledataLoading,
      isProfiledataSuccess: isProfiledataSuccess ?? this.isProfiledataSuccess,
      isEditProfiledataSuccess: isEditProfiledataSuccess ?? this.isEditProfiledataSuccess,
      errorMsg: errorMsg ?? this.errorMsg,
      profileData: profileData ?? this.profileData,
      districtData: disctrictData ?? this.districtData,
      mandalData: mandalData ?? this.mandalData,
      villageData: villageData ?? this.villageData,
      districtID: districtID ?? this.districtID,
      mandalID: mandalID ?? this.mandalID,
      villageID: villageID ?? this.villageID,
    );
  }

  @override
  bool get stringify => true;
}
