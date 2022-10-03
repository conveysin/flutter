import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:getinforme/Model/PostModel.dart';
import 'package:getinforme/Model/ProfileModel.dart';
import 'package:getinforme/Model/SettingModel.dart';
import 'package:getinforme/Model/VerifyOtpModel.dart';
import 'package:getinforme/Model/VillageModel.dart';
import 'package:getinforme/data/api/api_client.dart';



import '../../Model/DepartmentModel.dart';
import '../../Model/DistrictModel.dart';



import '../../Model/LanguageList.dart';

import '../../Model/LoginModel.dart';
import '../../Model/MandalModel.dart';


import '../../Model/PilotPostModel.dart';
import '../../Model/ResendOtp.dart';
import '../../Model/SendPushNotificationModel.dart';
import '../../Model/SignupModel.dart';


import '../../Model/VerifyUserOtp.dart';
import '../../core/exceptions/custom_exception.dart';

class ApiEndPoints {

  static const String BASE_URL =
      "https://conveys.in/master/rest_apis/ApiController/";
//      "https://master.conveys.com/rest_apis/ApiController/";

  /* static const String BASE_URL =
      "http://sanproinfotech.com/projects/informee/rest_apis/ApiController/";*/

  static const String API_KEY = "";

  //GetInfoUrl
  static final String setting = 'settings';
  static final String signupUrl = 'user_signup';
  static final String loginUrl = 'user_login';
  static final String getDistrictUrl = 'district';
  static final String getMandalUrl = 'mandal';
  static final String getVillageUrl = 'village';
  static final String otpVerify = 'verify_otp';
  static final String resend_otp = 'resend_otp';
  static final String forget_password = 'forget_password';
  static final String departmentList = 'department';
  static final String user_profile = 'user_profile';
  static final String post = 'posts';
  static final String contact_us = 'contact_us';
  static final String edit_profile = 'edit_profile';
  static final String like_posts = 'like_posts';
  static final String post_view = 'post_view';
  static final String add_posts = 'add_posts';
  static final String sendPushnotification = 'sendPushnotification';
  static final String change_password = 'change_password';
  static final String post_department = 'post_department';
}

abstract class ApiHelper {
  Future<Either<CustomException, LoginModel>> executeLogin(
      String mobile, String password, String device_id);

  Future<Either<CustomException, SignupModel>> executeSignup(
      String name,
      String mobile,
      String password,
      String confirmPassword,
      var district,
      var mandal,
      var village, String device_id);

  Future<Either<CustomException, ResendOtp>> resendOtp(
      var userId);

  Future<Either<CustomException, DistrictModel>> getDistrictList();

  Future<Either<CustomException, MandalModel>> getMandalList(String districtID);

  Future<Either<CustomException, VillageModel>> getVillageList(
      String districtID, String mandalID);

  Future<Either<CustomException, Language>> executeLanguages();

  Future<Either<CustomException, SettingModel>> getSetting(String userID);
  Future<Either<CustomException, VerifyUserOtp>> verifyOtp(String user_id,String otp);
  Future<Either<CustomException, VerifyOtpModel>> forget_password(String mobile);
  Future<Either<CustomException, DepartmentModel>> executeHome(String villageId, String userID);
  Future<Either<CustomException, DepartmentModel>> postDeparrtment(String userID,String villagrID);
  Future<Either<CustomException, ProfileModel>> getProfileInfo(String userId);
  Future<Either<CustomException, PostModel>> getPostList(String departmentId, String villageID,String userID);
  Future<Either<CustomException, VerifyOtpModel>> contact_us(String contact_us, String user_id);
  Future<Either<CustomException, VerifyOtpModel>> like_posts(String post_id, String user_id);
  Future<Either<CustomException, VerifyOtpModel>> post_view(String post_id, String user_id);
  Future<Either<CustomException, PilotPostModel>> add_posts(String user_id,String districtId,String mandalId,String villageId,
      String departmentId,String content_english, String content_telgu,String user_type);
  Future<Either<CustomException, VerifyOtpModel>> edit_profile(String user_id,String name,String district,String mandal,String village);
  Future<Either<CustomException, VerifyOtpModel>> sendPushnotification(String district_id,String mandal_id,String village_id,String post_id);
  Future<Either<CustomException, VerifyOtpModel>> changePassword(String user_id,
      String old_password,
  String new_password,
      String confirm_password);


}
//Model Change

class ApiHelperImpl extends ApiHelper {
  ApiHelperImpl(this._api);

  final ApiClient _api;

  @override
  Future<Either<CustomException, SettingModel>> getSetting(userID) async {
    try {
      final response = await _api.get(ApiEndPoints.setting+"/"+userID);
      if (response['status'] == 200) {
        return Right(SettingModel.fromJson(response));
      } else {
        return Left(throw CustomException(
            200,
            response['error'] == null
                ? response['error']['message']
                : response['message'],
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, DistrictModel>> getDistrictList() async {
    try {
      final response = await _api.get(ApiEndPoints.getDistrictUrl);
      if (response['status'] == 200) {
        return Right(DistrictModel.fromJson(response));
      } else {
        return Left(throw CustomException(
            200,
            response['error'] == null
                ? response['error']['message']
                : response['message'],
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, MandalModel>> getMandalList(
      String districtID) async {
    try {
      final response =
          await _api.get(ApiEndPoints.getMandalUrl + "/" + districtID);
      if (response['status'] == 200) {
        return Right(MandalModel.fromJson(response));
      } else {
        return Left(throw CustomException(
            200,
            response['error'] == null
                ? response['error']['message']
                : response['message'],
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VillageModel>> getVillageList(
      String districtID, String mandalID) async {
    try {
      final response = await _api
          .get(ApiEndPoints.getVillageUrl + "/" + districtID + "/" + mandalID);
      if (response['status'] == 200) {
        return Right(VillageModel.fromJson(response));
      } else {
        return Left(throw CustomException(
            200,
            response['error'] == null
                ? response['error']['message']
                : response['message'],
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, SignupModel>> executeSignup(
      String nameTxt,
      String mobileTxt,
      String passwordTxt,
      String confirmPasswordTxt,
      var districtTxt,
      var mandalTxt,
      var villageTxt,String device_id) async {
    try {
      var map = new Map<String, dynamic>();
      map['name'] = nameTxt;
      map['mobile'] = mobileTxt;
      map['password'] = passwordTxt;
      map['confirm_password'] = confirmPasswordTxt;
      map['district'] = districtTxt;
      map['mandal'] = mandalTxt;
      map['village'] = villageTxt;
      map['device_id'] = device_id;

      final response = await _api.post(ApiEndPoints.signupUrl, map);
      if (response['status'] == 200) {
        print('mobilesuccess>>' + mobileTxt);
        return Right(SignupModel.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + mobileTxt);
        print('>>>>> msg>>' + response['msg']);
        return Left(throw CustomException(200,
            response['msg'] != null ? response['msg'] : 'Invalid request', ""));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, LoginModel>> executeLogin(
      String mobile, String password, String device_id) async {
    print('mobile>>' + mobile);
    try {
      var map = new Map<String, dynamic>();
      map['username'] = mobile;
      map['password'] = password;
      map['device_id'] = device_id;

      final response = await _api.post(ApiEndPoints.loginUrl, map);
      if (response['status'] == 200) {
        print('mobilesuccess>>' + mobile);
        return Right(LoginModel.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + mobile);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, Language>> executeLanguages() {
    // TODO: implement executeLanguages
    throw UnimplementedError();
  }


  @override
  Future<Either<CustomException, ResendOtp>> resendOtp(userId) async {
    try {
      var map = new Map<String, dynamic>();
      map['user_id'] = userId;

      final response = await _api.post(ApiEndPoints.resend_otp, map);
      if (response['status'] == 200) {
        print('userIdsuccess>>' + userId);
        return Right(ResendOtp.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + userId);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VerifyUserOtp>> verifyOtp(String user_id, String otp) async {
    try {
      var map = new Map<String, dynamic>();
      map['user_id'] = user_id;
      map['otp'] = otp;

      final response = await _api.post(ApiEndPoints.otpVerify, map);
      if (response['status'] == 200) {
        print('userIdsuccess>>' + user_id);
        return Right(VerifyUserOtp.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + user_id);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VerifyOtpModel>> forget_password(String mobile) async {
    try {
      var map = new Map<String, dynamic>();
      map['mobile'] = mobile;

      final response = await _api.post(ApiEndPoints.forget_password, map);
      if (response['status'] == 200) {
        print('mobilesuccess>>' + mobile);
        return Right(VerifyOtpModel.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + mobile);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, DepartmentModel>> executeHome(String villageID,String userID) async {
    try {
      final response = await _api
          .get(ApiEndPoints.departmentList + "/" + villageID + "/" +userID);
      if (response['status'] == 200) {
        return Right(DepartmentModel.fromJson(response));
      }else if  (response['status'] == 404) {
        return Right(DepartmentModel.fromJson(response));
      } else {
        return Left(throw CustomException(
            404,
            response['error'] == null
                ? response['error']['message']
                : response['message'],
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, ProfileModel>> getProfileInfo(String userId) async {
    try {
      final response = await _api
          .get(ApiEndPoints.user_profile + "/" + userId );
      if (response['status'] == 200) {
        return Right(ProfileModel.fromJson(response));
      } else {
        return Left(throw CustomException(
            200,
            response['error'] == null
                ? response['error']['message']
                : response['message'],
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, PostModel>> getPostList(String departmentId, String villageID, String userID) async {
    try {
      final response = await _api
          .get(ApiEndPoints.post + "/" + departmentId + "/"+villageID+"/"+userID );
      if (response['status'] == 200) {
        return Right(PostModel.fromJson(response));
      }else if  (response['status'] == 404) {
        return Right(PostModel.fromJson(response));
      }  else {
        return Left(throw CustomException(
            200,
            response['error'] == null
                ? response['error']['message']
                : response['message'],
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VerifyOtpModel>> contact_us(String message, String user_id) async {
    try {
      var map = new Map<String, dynamic>();
      map['message'] = message;
      map['user_id'] = user_id;

      final response = await _api.post(ApiEndPoints.contact_us, map);
      if (response['status'] == 200) {
        print('mobilesuccess>>' + message);
        return Right(VerifyOtpModel.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + message);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VerifyOtpModel>> edit_profile(String user_id, String name, String district, String mandal, String village)  async {
    try {
      var map = new Map<String, dynamic>();
      map['user_id'] = user_id;
      map['name'] = name;
      map['district'] = district;
      map['mandal'] = mandal;
      map['village'] = village;

      final response = await _api.post(ApiEndPoints.edit_profile, map);
      if (response['status'] == 200) {
        print('mobilesuccess>>' + user_id);
        return Right(VerifyOtpModel.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + user_id);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VerifyOtpModel>> like_posts(String post_id, String user_id)async {
    try {
      var map = new Map<String, dynamic>();
      map['post_id'] = post_id;
      map['user_id'] = user_id;

      final response = await _api.post(ApiEndPoints.like_posts, map);
      if (response['status'] == 200) {
        print('mobilesuccess>>' + post_id);
        return Right(VerifyOtpModel.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + post_id);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VerifyOtpModel>> post_view(String post_id, String user_id)async {
    try {
      var map = new Map<String, dynamic>();
      map['post_id'] = post_id;
      map['user_id'] = user_id;

      final response = await _api.post(ApiEndPoints.post_view, map);
      if (response['status'] == 200) {
        print('mobilesuccess>>' + post_id);
        return Right(VerifyOtpModel.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + post_id);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, PilotPostModel>> add_posts(String user_id,
      String districtId, String mandalId, String villageId, String departmentId,
     String content_english, String content_telgu, String user_type) async {
    try {
      var map = new Map<String, dynamic>();
      map['user_id'] = user_id;
      map['district_id'] = districtId;
      map['mandal_id'] = mandalId;
      map['village_id'] = villageId;
      map['department_id'] = departmentId;
      map['content_english'] = content_english;
      map['content_telgu'] = content_telgu;
      map['user_type'] = user_type;

      final response = await _api.post(ApiEndPoints.add_posts, map);
      if (response['status'] == 200) {
        print('mobilesuccess>>' + user_id);
        return Right(PilotPostModel.fromJson(response));
      } else {
        print('mobilesuccess ffff>>' + user_id);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VerifyOtpModel>> sendPushnotification(String districtId, String mandalId, String villageId, String postId)  async {
    try {
      var map = new Map<String, dynamic>();
      map['district_id'] = districtId;
      map['mandal_id'] = mandalId;
      map['village_id'] = villageId;
      map['post_id'] = postId;

      final response = await _api.post(ApiEndPoints.sendPushnotification, map);
      if (response['status'] == 200) {
        print('postId>>' + postId);
        return Right(VerifyOtpModel.fromJson(response));
      } else {
        print('postId ffff>>' + postId);
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, VerifyOtpModel>> changePassword(String user_id, String old_password, String new_password, String confirm_password) async {
    try {
      var map = new Map<String, dynamic>();
      map['user_id'] = user_id;
      map['old_password'] = old_password;
      map['new_password'] = new_password;
      map['confirm_password'] = confirm_password;

      final response = await _api.post(ApiEndPoints.change_password, map);
      if (response['status'] == 200) {
        print('status>>' + response['status'].toString());
        return Right(VerifyOtpModel.fromJson(response));
      } else {
        print('status ffff>>' + response['status'].toString());
        return Left(throw CustomException(
            response['status'],
            response['msg'] != null ? response['msg'] : 'Invalid request',
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, DepartmentModel>> postDeparrtment(String userID,String villageID) async {
    try {
      final response = await _api
          .get(ApiEndPoints.post_department  + "/" +userID + "/"+villageID);
      if (response['status'] == 200) {
        return Right(DepartmentModel.fromJson(response));
      }else if  (response['status'] == 404) {
        return Right(DepartmentModel.fromJson(response));
      } else {
        return Left(throw CustomException(
            404,
            response['error'] == null
                ? response['error']['message']
                : response['message'],
            "'"));
      }
    } on CustomException catch (e) {
      return Left(e);
    }
  }
}
