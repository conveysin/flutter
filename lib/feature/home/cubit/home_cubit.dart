import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:getinforme/Model/DepartmentModel.dart';
import '../../../Model/Home.dart';
import '../../../data/data_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
    HomeState(
      departmentData:<DepartmentData>[],
       ),
  );

  final DataHelper _dataHelper = DataHelperImpl.instance;
  bool isFetching = false;


  Future<void> fetchHomeData(String villageID, String userID) async {
    emit(state.copyWith(isHomedataLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.executeHome(villageID,userID);
    dailyQuoteResponse.fold((l) {
      print('HomeLoading>>>>Failed');
      emit(state.copyWith(isHomedataLoading: false,isHomedataFailure: true,errorMsg:l.errorMessage));
    }, (r) {
      if(r.status.toString() == '404'){
        print('HomeLoading>>>>Success');
        emit(state.copyWith(isHomedataLoading: false));
        emit(state.copyWith(isHomedataLoading: false,isHomedataFailure: true, departmentData: r.data!.data,errorMsg:r.msg,sponser_name:r.data?.sponserName,));

      }else{
        print('HomeLoading>>>>Success');
        emit(state.copyWith(isHomedataLoading: false));
        emit(state.copyWith(isHomedataLoading: false,isHomedataFailure: false, departmentData: r.data!.data,errorMsg:r.msg,sponser_name:r.data?.sponserName,));
      }


    });
  }




}
