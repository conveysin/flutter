part of 'category_cubit.dart';

@immutable
class CategoryState extends Equatable {
  final bool iscategoryDataFailure;
  final bool iscategoryDataLoading;
  final bool iscategoryDataSuccess;
  final bool isEditcategoryDataSuccess ;
  // CategoryModel categoryData;
  final List<CategoryData> categoryData;
  final String errorMsg;
  // List<DistrictData> districtData;
  // List<MandalData> mandalData;
  // List<VillageData> villageData;
  // String districtID;
  // String mandalID;
  // String villageID;

  CategoryState({
    this.iscategoryDataFailure = false,
    this.iscategoryDataLoading = true,
    this.iscategoryDataSuccess = false,
    this.isEditcategoryDataSuccess = false,
    this.errorMsg = '',
    required this.categoryData,
    // required this.districtData,
    // required this.mandalData,
    // required this.villageData,
    // this.districtID = '',
    // this.mandalID = '',
    // this.villageID = '',
  });

  @override
  List<Object> get props {
    return [
      iscategoryDataFailure,
      iscategoryDataLoading,
      iscategoryDataSuccess,
      isEditcategoryDataSuccess,
      errorMsg,
      categoryData,
      // mandalData,
      // districtData,
      // villageData,
      // districtID,
      // mandalID,
      // villageID,
    ];
  }

  CategoryState copyWith({
    // List<DistrictData>? disctrictData,
    // List<MandalData>? mandalData,
    // List<VillageData>? villageData,
    bool? iscategoryDataFailure,
    bool? iscategoryDataLoading,
    bool? iscategoryDataSuccess,
    bool? isEditcategoryDataSuccess,
    String? errorMsg,
    List<CategoryData>? categoryData,
    // String? districtID,
    // String? mandalID,
    // String? villageID,
  }) {
    return CategoryState(
      iscategoryDataFailure: iscategoryDataFailure ?? this.iscategoryDataFailure,
      iscategoryDataLoading: iscategoryDataLoading ?? this.iscategoryDataLoading,
      iscategoryDataSuccess: iscategoryDataSuccess ?? this.iscategoryDataSuccess,
      isEditcategoryDataSuccess: isEditcategoryDataSuccess ?? this.isEditcategoryDataSuccess,
      errorMsg: errorMsg ?? this.errorMsg, 
      categoryData: categoryData ?? this.categoryData,
      // districtData: disctrictData ?? this.districtData,
      // mandalData: mandalData ?? this.mandalData,
      // villageData: villageData ?? this.villageData,
      // districtID: districtID ?? this.districtID,
      // mandalID: mandalID ?? this.mandalID,
      // villageID: villageID ?? this.villageID,
    );
  }

  @override
  bool get stringify => true;
}
