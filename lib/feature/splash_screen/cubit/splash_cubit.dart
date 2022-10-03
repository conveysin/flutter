import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getinforme/Model/SettingModel.dart';


import '../../../data/data_helper.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.empty());

  final DataHelper _dataHelper = DataHelperImpl.instance;


  Future<void> fetchSetting(String userID) async {
    emit(state.copyWith(isLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getSetting(userID);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isLoading: false,isFailure: true,errormessage: l.errorMessage));
    }, (r) async {
      await _dataHelper.cacheHelper.saveLogo(r.data![0].logo.toString());
      await _dataHelper.cacheHelper.setEditor(r.data![0].is_editor);
      print('EDITOR_STATUS>>>${_dataHelper.cacheHelper.getEditor()}');
      emit(state.copyWith(isLoading: false,settingData: r.data));
    });
  }



  Future<void> getLoggedInStatus() async {
    try {
      final result = await _dataHelper.cacheHelper.isLogin();
      if (result.isNotEmpty) {
        emit(state.copyWith(isLoading: false,isLoggedIn:result == "1" ? true : false));
      } else
        emit(state.copyWith(isLoading: false,isLoggedIn:false));
    } catch (e) {
      emit(state.copyWith(isLoading: false,isLoggedIn: false));
    }
  }
}
