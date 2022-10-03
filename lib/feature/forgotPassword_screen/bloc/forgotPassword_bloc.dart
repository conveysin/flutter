import 'dart:async';
import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:getinforme/feature/forgotPassword_screen/changePassword.dart';

import '../../../data/data_helper.dart';
import '../../../utility/validators.dart';
import 'forgotPassword_event.dart';


part 'forgotPassword_state.dart';


class ForgotPasswordBloc extends Bloc<ForgotPassword_Event, ForgotPassword_State> {
  ForgotPasswordBloc() : super(ForgotPassword_State.empty());
  final DataHelper _dataHelper = DataHelperImpl.instance;

  @override
  Stream<ForgotPassword_State> mapEventToState(
    ForgotPassword_Event event,
  ) async* {
    if (event is MobileChanged){
      if (Validators.isValidMobile(event.mobile)) {
        yield state.copyWith(
          isMobile: true, );
      }
      else{
        yield state.copyWith(
          isMobile: false );
      }
    }

    if (event is PasswordChanged){
      if (Validators.isValidPassword(event.password)) {
        yield state.copyWith(
          isPassword: true );
      }
      else{
        yield state.copyWith(
          isPassword: false );
      }
    }


    if (event is ForgotPasswordClicked) {
      if (!state.isMobile) {
        if (Validators.isValidMobile(event.mobile)) {
          yield state.copyWith(
               isMobile: true);
        }

      } else {
        if (state.isMobile)
          yield* _forgotPassword(event);
      }
    } else
      UnimplementedError();
  }

  Stream<ForgotPassword_State> _forgotPassword(
      ForgotPasswordClicked event) async* {
    print('mobile');
    yield ForgotPassword_State.loading(true);
    final response = await _dataHelper.apiHelper.forget_password(
        event.mobile);
    yield ForgotPassword_State.loading(false);
    yield* response.fold((l) async* {
      yield ForgotPassword_State.failure(l.errorMessage,false);
    },  (r) async* {
     // await _dataHelper.cacheHelper.saveAccessToken(r.data.otp.toString());

      yield ForgotPassword_State.success(true);
      });
  }

  Future<void> ChangePassword(String userID,String oldPassword,String newPassword,String confirmPassword) async {
    emit(state.copyWith(isSubmitting: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.changePassword(userID,oldPassword,newPassword,confirmPassword);
    dailyQuoteResponse.fold((l) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>Failed");
      emit(state.copyWith(isSubmitting: false,isSuccess: false, isFailure:true,errorMessage: l.errorMessage.toString()));
    }, (r) async {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>Changed");
       emit(state.copyWith(isSubmitting: false,isSuccess: true,isFailure:false,errorMessage:r.msg.toString()));
    });
  }


}

