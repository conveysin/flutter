import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../Model/DistrictModel.dart';
import '../../../Model/Home.dart';
import '../../../Model/MandalModel.dart';
import '../../../Model/ProfileModel.dart';
import '../../../Model/VillageModel.dart';
import '../../../data/data_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : super(
    ProfileState(
profileData: new ProfileModel(),
      villageData: [],
      mandalData: [],
      districtData: []
       ),
  );

  final DataHelper _dataHelper = DataHelperImpl.instance;
  bool isFetching = false;
  Card? cardlist;
  String? slider;
  List<Card>? list = List.empty(growable: true);
  List<String>? sliderlist = List.empty(growable: true);



  Future<void> getProfileInfo(String userId) async {
    emit(state.copyWith(isProfiledataLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getProfileInfo(userId);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isProfiledataLoading: false,isProfiledataFailure: true,isEditProfiledataSuccess:false,errorMsg:l.errorMessage));
    }, (r) {
      emit(state.copyWith(isProfiledataLoading: false,isProfiledataFailure: false,isProfiledataSuccess :true,isEditProfiledataSuccess:false, profileData: r));
    });
  }
  Future<void> fetchDistrict(String userId) async {
    emit(state.copyWith(isProfiledataLoading: false));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getDistrictList();
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isProfiledataLoading: false,isEditProfiledataSuccess:false,isProfiledataSuccess:false,errorMsg: l.errorMessage));
    }, (r) {
      getProfileInfo(userId);
      emit(state.copyWith(isProfiledataLoading: false,isEditProfiledataSuccess:false,isProfiledataSuccess:false,isProfiledataFailure: false,disctrictData: r.data));
    });
  }



  Future<void> fetchMandal(String districtID) async {
    emit(state.copyWith(isProfiledataLoading: false));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getMandalList(districtID);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isProfiledataLoading: false,isEditProfiledataSuccess:false,isProfiledataSuccess:false,errorMsg: l.errorMessage));
    }, (r) {
      emit(state.copyWith(isProfiledataLoading: false,isEditProfiledataSuccess:false,isProfiledataSuccess:false,mandalData: r.data));
    });
  }

  Future<void> fetchVillage(String districtID,String mandalID) async {
    emit(state.copyWith(isProfiledataLoading: false));
    final dailyQuoteResponse = await _dataHelper.apiHelper.getVillageList(districtID,mandalID);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isProfiledataLoading: false,isEditProfiledataSuccess:false,isProfiledataSuccess:false,errorMsg: l.errorMessage));
    }, (r) {
      emit(state.copyWith(isProfiledataLoading: false,isEditProfiledataSuccess:false,isProfiledataSuccess:false,villageData: r.data));
    });
  }

  Future<void> editProfile(String userId,String name, String district,String mandal,String village) async {
    emit(state.copyWith(isProfiledataLoading: true));
    final dailyQuoteResponse = await _dataHelper.apiHelper.edit_profile(userId,name,district,mandal,village);
    dailyQuoteResponse.fold((l) {
      emit(state.copyWith(isProfiledataLoading: false,isProfiledataFailure: true,isProfiledataSuccess:false,errorMsg:l.errorMessage));
    }, (r) async {
      await _dataHelper.cacheHelper.saveVillage(village);
      getProfileInfo(userId);
      emit(state.copyWith(isProfiledataLoading: false,isProfiledataFailure: false, isProfiledataSuccess:false,isEditProfiledataSuccess: true));
    });
  }

}
