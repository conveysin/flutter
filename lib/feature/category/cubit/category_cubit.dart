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
categoryData:<CategoryData>[],
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



  // Future<void> getCategoryInfo(String letter) async {
  //   emit(state.copyWith(iscategoryDataLoading: true));
  //   final dailyQuoteResponse = await _dataHelper.apiHelper.getCategoryInfo("");
  //   // print(dailyQuoteResponse);
  //   dailyQuoteResponse.fold((l) {
  //     emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: true,isEditcategoryDataSuccess:false,errorMsg:l.errorMessage));
  //   }, (r) {
  //     emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: false,iscategoryDataSuccess :true,isEditcategoryDataSuccess:false, categoryData: r.data));
  //     // emit(state.copyWith(errorMsg:r.msg.toString(),categoryDatas: r.data));
  //   });
  // }


  Future<void> getCategoryInfo(String letter) async {

    emit(state.copyWith(iscategoryDataLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getCategoryInfo(letter);
    dailyQuoteResponse.fold((l) {
      print('HomeLoading>>>>Failed');
      emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: true,errorMsg:l.errorMessage));
    }, (r) {
      if(r.status.toString() == "404"){
        print('HomeLoading>>>>Success');
        print(r.msg);
        emit(state.copyWith(iscategoryDataLoading: false));
        emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: true, errorMsg:r.msg));
      }else{
        print('HomeLoading>>>>Success');
        print(r.msg);
        emit(state.copyWith(iscategoryDataLoading: false));
        emit(state.copyWith(iscategoryDataLoading: false,iscategoryDataFailure: false, categoryData: r.data,errorMsg:r.msg));
      }

    });
  }

}
