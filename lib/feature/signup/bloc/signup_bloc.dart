import 'dart:async';
import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:getinforme/Model/DistrictModel.dart';
import 'package:getinforme/Model/MandalModel.dart';
import 'package:getinforme/Model/SignupModel.dart';
import 'package:getinforme/Model/VerifyUserOtp.dart';
import 'package:getinforme/Model/VillageModel.dart';


import '../../../data/data_helper.dart';
import '../../../utility/validators.dart';
import 'signup_event.dart';



part 'signup_state.dart';


class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState.empty());
  final DataHelper _dataHelper = DataHelperImpl.instance;

  @override
  Stream<SignupState> mapEventToState(
      SignupEvent event,
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

  // Future<void> signup(String name,String mobile, String password,String confirmpassword,var districtID,var mandalID,var villageID,String device_id) async {
  Future<void> signup(String name,String mobile,var districtID,var mandalID,var villageID,String device_id) async {
    emit(state.copyWith(isSubmitting: true));
    // final dailyQuoteResponse = await _dataHelper.apiHelper.executeSignup(name,mobile,password,confirmpassword,districtID,mandalID,villageID,device_id);
    final dailyQuoteResponse = await _dataHelper.apiHelper.executeSignup(name,mobile,districtID,mandalID,villageID,device_id);
    dailyQuoteResponse.fold((l) {
      print("LL_BLOCK>>"+l.errorMessage);
      print("LL_BLOCK>>"+l.errorCode.toString());
      emit(state.copyWith(isSubmitting: false,isSignupFailure: true,errormessage: l.errorMessage.toString()));
      emit(state.copyWith(isSubmitting: false,isSignupFailure: false,errormessage: null));
    }, (r) async {
      await _dataHelper.cacheHelper.setLogin('1');
      await _dataHelper.cacheHelper.saveUserInfo(r.data!.userId.toString());
      emit(state.copyWith(isSubmitting: false,errormessage: r.msg!,isSignupSuccess: true,signupData: r.data));
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
        await _dataHelper.cacheHelper.setUserType(r.data!.userType.toString());
      }
      emit(state.copyWith(isSubmitting: false,errormessage: r.msg!,isOTPSuccess: true,verifyOtpData: r.data));
    });
  }

}

