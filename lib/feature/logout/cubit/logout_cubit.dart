import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../Model/Home.dart';
import '../../../data/data_helper.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit()
      : super(
    LogoutState(

       ),
  );

  final DataHelper _dataHelper = DataHelperImpl.instance;
  bool isFetching = false;



  Future<void> contact_us(String message, String userId) async {
    emit(state.copyWith(isContactusLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.contact_us(message, userId);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isContactusLoading: false,isContactusFailure: true,errorMsg:l.errorMessage));
    }, (r) {
      emit(state.copyWith(isContactusLoading: false,isContactusFailure: false, isContactusSuccess: true));
    });
  }




}
