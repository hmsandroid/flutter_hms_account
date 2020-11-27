import 'package:flutter/material.dart';
import 'package:flutter_hms_account/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huawei_account/auth/auth_huawei_id.dart';
import 'package:huawei_account/helpers/auth_param_helper.dart';
import 'package:huawei_account/helpers/scope.dart';
import 'package:huawei_account/hms_account.dart';

class LoginProvider with ChangeNotifier {
  User _user = new User();

  User get getUser {
    return _user;
  }

  void signIn() async {
    AuthParamHelper authParamHelper = new AuthParamHelper();
    authParamHelper
      ..setIdToken()
      ..setAuthorizationCode()
      ..setAccessToken()
      ..setProfile()
      ..setEmail()
      ..setId()
      ..addToScopeList([Scope.openId])
      ..setRequestCode(8888);
    try {
      final AuthHuaweiId accountInfo = await HmsAccount.signIn(authParamHelper);
      _user.id = accountInfo.unionId;
      _user.displayName = accountInfo.displayName;
      _user.email = accountInfo.email;
      _user.profilePhotoUrl = accountInfo.avatarUriString;
      notifyListeners();
      showToast('Welcome ${_user.displayName}');
    } on Exception catch (exception) {
      print(exception.toString());
    }
  }

  Future signOut() async {
    final signOutResult = await HmsAccount.signOut();
    if (signOutResult) {
      _user.id = null;
      notifyListeners();
      showToast('Signed out');
    } else {
      print('Login_provider:SignOut failed');
    }
  }

  void silentSignIn() async {
    AuthParamHelper authParamHelper = new AuthParamHelper();
    try {
      final AuthHuaweiId accountInfo =
          await HmsAccount.silentSignIn(authParamHelper);
      if (accountInfo.unionId != null) {
        _user.id = accountInfo.unionId;
        _user.displayName = accountInfo.displayName;
        _user.profilePhotoUrl = accountInfo.avatarUriString;
        _user.email = accountInfo.email;
        notifyListeners();
        showToast('Welcome ${_user.displayName}');
      }
    } on Exception catch (exception) {
      print(exception.toString());
      print('Login_provider:Can not SignIn silently');
    }
  }

  Future revokeAuthorization() async {
    final bool revokeResult = await HmsAccount.revokeAuthorization();
    if (revokeResult) {
      print('Login_provider:Revoked Auth Successfully');
    } else {
      print('Login_provider:Failed to Revoked Auth');
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
