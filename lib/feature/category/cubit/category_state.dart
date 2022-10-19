part of 'category_cubit.dart';

@immutable
class CategoryState extends Equatable {
  final List categoryData;
  final bool iscategoryDataFailure;
  final bool iscategoryDataLoading;
  final bool iscategoryDataSuccess;
  final String errorMsg;
  // final String sponser_name;
  CategoryState({
    required this.categoryData,
    this.iscategoryDataFailure = false,
    this.iscategoryDataLoading = true,
    this.iscategoryDataSuccess = false,
    this.errorMsg='',
    // this.sponser_name=''
  });
  @override
  List<Object> get props {
    return [
      categoryData,
      iscategoryDataFailure,
      iscategoryDataLoading,
      iscategoryDataSuccess
      ,errorMsg
      // sponser_name
    ];
  }

  CategoryState copyWith(
      {List? categoryData,
        bool? iscategoryDataFailure,
        bool? iscategoryDataLoading,
        bool? iscategoryDataSuccess,
        String? errorMsg,
        // String? sponser_name,
        }) {
    return CategoryState(
      categoryData: categoryData ?? this.categoryData,
      iscategoryDataFailure: iscategoryDataFailure ?? this.iscategoryDataFailure,
      iscategoryDataLoading: iscategoryDataLoading ?? this.iscategoryDataLoading,
      iscategoryDataSuccess:iscategoryDataSuccess??this.iscategoryDataSuccess,
      errorMsg:errorMsg??this.errorMsg,
      // sponser_name:sponser_name??this.sponser_name,
       );
  }

  @override
  bool get stringify => true;
}
