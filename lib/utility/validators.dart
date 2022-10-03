class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final RegExp _usernameRegExp = RegExp(
    r'^(?:\d{10}|[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@\w+\.\w{2,3})$',
  );
  static final RegExp _otpRegExp = RegExp(r'^[1-9][0-9]{3}$');
  static final RegExp _passwordRegExp = RegExp(
    r'^.{8}',
  );

  static final RegExp _loginpasswordRegExp = RegExp(
    r'^.{4,}',
  );
  static final RegExp _nameRegExp =
      RegExp(r'^[a-zA-Z]{2,}(?: [a-zA-Z]+){0,1}$');

  static final RegExp _firstNameRegExp = RegExp(r'^[a-zA-Z]{4,}$');

  static final RegExp _transidRegExp = RegExp(r'^[a-zA-Z][1-9][0-9]{4,}$');

  static final RegExp _lastNameRegExp = RegExp(r'^[a-zA-Z]{3,}$');

  static final RegExp _pincodeRegExp = RegExp(r'^[1-9][0-9]{5}$');

  static final RegExp _mobileRegExp = RegExp(r'^[1-9][0-9]{9}$');
  static final RegExp _pancard = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  static final RegExp _aadharcard = RegExp(r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$');

  static final RegExp _removeZeroDecimal = RegExp(
    r'([.]*0)(?!.*\d)',
  );

  static bool isValidName(String name) {
    return _nameRegExp.hasMatch(name);
  }

  static bool isValidFirstName(String name) {
    return _firstNameRegExp.hasMatch(name);
  }
  static bool isValidTransIsd(String name) {
    return _transidRegExp.hasMatch(name);
  }


  static bool isValidLastName(String name) {
    return _lastNameRegExp.hasMatch(name);
  }

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static bool isValidOtp(String otp) {
    return _otpRegExp.hasMatch(otp);
  }

  static bool isValidUsername(String email) {
    return _usernameRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
  static bool isValidLoginPassword(String password) {
    return _loginpasswordRegExp.hasMatch(password);
  }

  static bool isValidPincode(String pincode) {
    return _pincodeRegExp.hasMatch(pincode);
  }

  static bool isValidMobile(String mobile) {
    return _mobileRegExp.hasMatch(mobile);
  }
  static bool isValidPanCard(String pannumber) {
    return _pancard.hasMatch(pannumber);
  }
  static bool isValidAadharCard(String aadharnumber) {
    return _aadharcard.hasMatch(aadharnumber);
  }

  static String removeZeroDecimal(double num) {
    return num.toString().replaceAll(_removeZeroDecimal, '');
  }
}
