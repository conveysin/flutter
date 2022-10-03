import 'dart:convert';

import '../../core/cache_client.dart';






abstract class CacheKeys {
  static final String token = 'token';
  //User Data
  static final String userInfo = 'userInfo';

  static final String isLogin = 'islogin';
  static final String profile = 'profile';
  static final String config = 'config';
  static final String logo = 'Logo';
  static final String villageID = 'villageID';
  static final String userType = 'UserType';
  static final String is_editor = 'is_editor';
}

abstract class CacheHelper {
  Future<String> getAccessToken();

  Future saveAccessToken(String token);

  Future<String> getUserInfo();

  Future saveUserInfo(String userInfo);
  Future<String> isLogin();

  Future setLogin(String token);
  Future<String> getProfileData();

  Future saveProfileData(String userInfo);

  Future<String> getConfigScreenData();
  Future saveConfigScreenData(String configData);

  Future<String> getLogo();
  Future saveLogo(String logo);

  Future<String> getVillage();
  Future saveVillage(String villageID);


  Future<String> isUserType();

  Future setUserType(String token);

  Future<bool> getEditor();
  Future setEditor(bool isEditor);

}

class CacheHelperImpl extends CacheHelper {
  CacheHelperImpl(this._cache);

  final CacheClient _cache;



  @override
  Future<String> getProfileData() {
    return _cache.getString(CacheKeys.profile);
  }

  @override
  Future saveProfileData(String token) {
    return _cache.putString(CacheKeys.profile, token);
  }

  @override
  Future<String> isLogin() {
    return _cache.getString(CacheKeys.isLogin);
  }

  @override
  Future setLogin(String islogin) {
    return _cache.putString(CacheKeys.isLogin, islogin);
  }
  @override
  Future<String> getAccessToken() {
    return _cache.getString(CacheKeys.token);
  }

  @override
  Future<String> getUserInfo() {
    return _cache.getString(CacheKeys.userInfo);
  }

  @override
  Future saveAccessToken(String token) {
    return _cache.putString(CacheKeys.token, token);
  }

  @override
  Future saveUserInfo(String userInfo) {

    return _cache.putString(CacheKeys.userInfo, userInfo);
  }

  @override
  Future saveConfigScreenData(String configData) {
    return _cache.putString(CacheKeys.config, configData);
  }

  @override
  Future<String> getConfigScreenData() {
    return _cache.getString(CacheKeys.config);
  }

  @override
  Future<String> getLogo() {
    return _cache.getString(CacheKeys.logo);
  }

  @override
  Future saveLogo(String logo) {
    return _cache.putString(CacheKeys.logo, logo);
  }


  @override
  Future<String> getVillage() {
    return _cache.getString(CacheKeys.villageID);
  }

  @override
  Future saveVillage(String villageID) {
    return _cache.putString(CacheKeys.villageID, villageID);
  }

  @override
  Future<String> isUserType() {
    return _cache.getString(CacheKeys.userType);
  }

  @override
  Future setUserType(String userType) {
    return _cache.putString(CacheKeys.userType, userType);
  }

  @override
  Future<bool> getEditor() async {
    bool? result= await _cache.getBool(CacheKeys.is_editor);
    if(result == null){
      result = false;
    }
    return result!;
  }

  @override
  Future setEditor(bool is_editor) {
    return _cache.putBool(CacheKeys.is_editor, is_editor);
  }



  // static Future<void> setFlowSubscriptionPref(SubscriptionAdd subData) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String subJson = jsonEncode(subData);
  //   await prefs.setString(sharePreferenceSubscriptionKey, subJson);
  // }

  // static Future<SubscriptionAdd?> getFlowSubscriptionPref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? subscription =
  //       prefs.getString(sharePreferenceSubscriptionKey) ?? null;
  //   if (subscription == null || subscription == "null") {
  //     return null;
  //   } else {
  //     return SubscriptionAdd.fromJson(jsonDecode(subscription));
  //   }
  // }


}
