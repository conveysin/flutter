import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../Model/CategoryModel.dart';
import '../../../Model/DistrictModel.dart';
import '../../../Model/Home.dart';
import '../../../Model/MandalModel.dart';
import '../../../Model/ProfileModel.dart';
import '../../../Model/VillageModel.dart';
import '../../../data/data_helper.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(
    CategoryState(
categoryData: new CategoryModel()
      // villageData: [],
      // mandalData: [],
      // districtData: []
       ),
  );

  final DataHelper _dataHelper = DataHelperImpl.instance;
  bool isFetching = false;
  Card? cardlist;
  String? slider;
  List<Card>? list = List.empty(growable: true);
  List<String>? sliderlist = List.empty(growable: true);



  Future<void> getSampleText(String userId) async {
    emit(state.copyWith(iscategoryDataLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getSampleText();
    // print(dailyQuoteResponse);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: true,isEditcategoryDataSuccess:false,errorMsg:l.errorMessage));
    }, (r) {
      emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: false,iscategoryDataSuccess :true,isEditcategoryDataSuccess:false, categoryData: r));
    });
  }
  // Future<void> fetchDistrict(String userId) async {
  //   emit(state.copyWith(iscategoryDataLoading: false));
  //   final dailyQuoteResponse = await _dataHelper.apiHelper.getDistrictList();
  //   dailyQuoteResponse.fold((l) {
  //     emit(state.copyWith(iscategoryDataLoading: false,isEditcategoryDataSuccess:false,iscategoryDataSuccess:false,errorMsg: l.errorMessage));
  //   }, (r) {
  //     getProfileInfo(userId);
  //     emit(state.copyWith(iscategoryDataLoading: false,isEditcategoryDataSuccess:false,iscategoryDataSuccess:false,iscategoryDataFailure: false,disctrictData: r.data));
  //   });
  // }



  // Future<void> fetchMandal(String districtID) async {
  //   emit(state.copyWith(iscategoryDataLoading: false));
  //   final dailyQuoteResponse = await _dataHelper.apiHelper.getMandalList(districtID);
  //   dailyQuoteResponse.fold((l) {
  //     emit(state.copyWith(iscategoryDataLoading: false,isEditcategoryDataSuccess:false,iscategoryDataSuccess:false,errorMsg: l.errorMessage));
  //   }, (r) {
  //     emit(state.copyWith(iscategoryDataLoading: false,isEditcategoryDataSuccess:false,iscategoryDataSuccess:false,mandalData: r.data));
  //   });
  // }

  // Future<void> fetchVillage(String districtID,String mandalID) async {
  //   emit(state.copyWith(iscategoryDataLoading: false));
  //   final dailyQuoteResponse = await _dataHelper.apiHelper.getVillageList(districtID,mandalID);
  //   dailyQuoteResponse.fold((l) {
  //     emit(state.copyWith(iscategoryDataLoading: false,isEditcategoryDataSuccess:false,iscategoryDataSuccess:false,errorMsg: l.errorMessage));
  //   }, (r) {
  //     emit(state.copyWith(iscategoryDataLoading: false,isEditcategoryDataSuccess:false,iscategoryDataSuccess:false,villageData: r.data));
  //   });
  // }

  // Future<void> editProfile(String userId,String name, String district,String mandal,String village) async {
  //   emit(state.copyWith(iscategoryDataLoading: true));
  //   final dailyQuoteResponse = await _dataHelper.apiHelper.edit_profile(userId,name,district,mandal,village);
  //   dailyQuoteResponse.fold((l) {
  //     emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: true,iscategoryDataSuccess:false,errorMsg:l.errorMessage));
  //   }, (r) async {
  //     await _dataHelper.cacheHelper.saveVillage(village);
  //     getProfileInfo(userId);
  //     emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: false, iscategoryDataSuccess:false,isEditcategoryDataSuccess: true));
  //   });
  // }

}
