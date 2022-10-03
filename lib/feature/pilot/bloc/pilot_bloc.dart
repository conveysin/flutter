import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:getinforme/Model/DistrictModel.dart';
import 'package:getinforme/Model/MandalModel.dart';
import 'package:getinforme/Model/SignupModel.dart';
import 'package:getinforme/Model/VillageModel.dart';


import '../../../Model/DepartmentModel.dart';
import '../../../data/data_helper.dart';
import '../../../utility/validators.dart';
import 'pilot_event.dart';



part 'pilot_state.dart';


class PilotBloc extends Bloc<PilotEvent, PilotState> {
  PilotBloc() : super(PilotState.empty());
  final DataHelper _dataHelper = DataHelperImpl.instance;

  @override
  Stream<PilotState> mapEventToState(
      PilotEvent event,
      ) async* {
    if (event is MobileChanged){
      if (Validators.isValidMobile(event.mobile)) {
        yield state.copyWith(
          isMobile: true, );
      }
      else{
        yield state.copyWith(
          isMobile: false, );
      }
    }

    if (event is NameChanged){
      if (Validators.isValidName(event.name)) {
        yield state.copyWith(
          isName: true, );
      }
      else{
        yield state.copyWith(
          isName: false, );
      }
    }

    if (event is PasswordChanged){
      if (Validators.isValidPassword(event.password)) {
        yield state.copyWith(
          isPassword: true, );
      }
      else{
        yield state.copyWith(
          isPassword: false, );
      }
    }

    if (event is OtpChanged) {
      print('${Validators.isValidOtp(event.otp)}');
      yield state.update(isOtpValid: Validators.isValidOtp(event.otp));
    }

    if (event is EmailChanged)
      yield state.update(isEmailValid: Validators.isValidEmail(event.email));

    if (event is SignUpWithCredentialsClicked) {

      if (!state.isMobile) {
        if (Validators.isValidMobile(event.mobile)) {
          yield state.copyWith(
              isMobile: true);
        }
      } 
    } else
      UnimplementedError();

    if (event is ResendClicked) {

      //yield* _resendOtp(event);

    } else
      UnimplementedError();
    if (event is LoginWithCredentialsOtp) {

     // yield* _loginWithOtp(event);

    }
    else  if (event is getLanguages) {

      // yield* _loginWithOtp(event);

    }else
      UnimplementedError();
  }





  Future<void> fetchDistrict() async {
    emit(state.copyWith(isLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getDistrictList();
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isLoading: false,isFailure: true,errormessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(isLoading: false,disctrictData: r.data));
    });
  }



  Future<void> fetchMandal(String districtID) async {
    emit(state.copyWith(isLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getMandalList(districtID);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isLoading: false,isFailure: true,errormessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(isLoading: false,mandalData: r.data));
    });
  }

  Future<void> fetchVillage(String districtID,String mandalID) async {
    emit(state.copyWith(isLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getVillageList(districtID,mandalID);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isLoading: false,isFailure: true,errormessage: l.errorMessage));
    }, (r) {
      emit(state.copyWith(isLoading: false,villageData: r.data));
    });
  }

  Future<void> add_posts(String userId,var districtID,var mandalID,var villageID,String departmentId,String content_english, content_telgu,String userType) async {
    emit(state.copyWith(isSubmitting: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.add_posts(userId,districtID,mandalID,villageID,departmentId,content_english,content_telgu,userType);
    dailyQuoteResponse.fold((l) {
      print("LL_BLOCK>>"+l.errorMessage);
      print("LL_BLOCK>>"+l.errorCode.toString());
      emit(state.copyWith(isSubmitting: false,isPilotPostFailure: true,errormessage: l.errorMessage.toString()));
      emit(state.copyWith(isSubmitting: false,isPilotPostFailure: false,errormessage: null));
    }, (r) async {
      print('Post>>${r.data?.postId}');
      emit(state.copyWith(isSubmitting: false,errormessage: r.msg!,isPilotPostSuccess: true,postID: r.data?.postId));
      emit(state.copyWith(isSubmitting: false,errormessage: r.msg!,isPilotPostSuccess: false));
    });
  }

  Future<void> resendOtp(String userId) async {
    emit(state.copyWith(isSubmitting: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.resendOtp(userId);
    dailyQuoteResponse.fold((l) {
      print("LL_BLOCK>>"+l.errorMessage);
      print("LL_BLOCK>>"+l.errorCode.toString());
      emit(state.copyWith(isSubmitting: false,isOTPFailure: true,errormessage: l.errorMessage.toString()));
      emit(state.copyWith(isSubmitting: false,isOTPFailure: false,errormessage: null));
    }, (r) async {
      emit(state.copyWith(isSubmitting: false,errormessage: r.msg!));
    });
  }

  Future<void> verifyOtp(String userId,String otp) async {
    emit(state.copyWith(isSubmitting: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.verifyOtp(userId,otp);
    dailyQuoteResponse.fold((l) {
      print("LL_BLOCK>>"+l.errorMessage);
      print("LL_BLOCK>>"+l.errorCode.toString());
      emit(state.copyWith(isSubmitting: false,isOTPFailure: true,errormessage: l.errorMessage.toString()));
       emit(state.copyWith(isSubmitting: false,isOTPFailure: false,errormessage: null));
    }, (r) async {
      if(r.data!=null && r.data!.villageId!=null) {
        print('VillageID>>>>${r.data!.villageId}');
        await _dataHelper.cacheHelper.saveVillage(r.data!.villageId!);
      }
      emit(state.copyWith(isSubmitting: false,errormessage: r.msg!,isOTPSuccess: true));
    });
  }
  Future<void> fetchdepartmentData(String villageID, String userID) async {
    emit(state.copyWith(isLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.postDeparrtment(userID,villageID);
    dailyQuoteResponse.fold((l) {
      print('HomeLoading>>>>Failed');
      emit(state.copyWith(isLoading: false,isFailure: true,errormessage:l.errorMessage));
    }, (r) {
      print('HomeLoading>>>>Success');
      emit(state.copyWith(isLoading: false));
      emit(state.copyWith(isLoading: false,isFailure: false, departmentData: r.data!.data,errormessage:r.msg,));

    });
  }

  Future<void> sendPushnotification(String districtID,String mandalID,String villageID,int postId) async {
    emit(state.copyWith(isSubmitting: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.sendPushnotification(districtID,mandalID,villageID,postId.toString());
    dailyQuoteResponse.fold((l) {
      //emit(state.copyWith(isSubmitting: false,isPilotPostFailure: true,errormessage: l.errorMessage.toString()));
     // emit(state.copyWith(isSubmitting: false,isPilotPostFailure: false,errormessage: null));
    }, (r) async {
     // emit(state.copyWith(isSubmitting: false,errormessage: r.,isPilotPostSuccess: true));
   //   emit(state.copyWith(isSubmitting: false,errormessage: r.msg!,isPilotPostSuccess: false));
    });
  }



}

