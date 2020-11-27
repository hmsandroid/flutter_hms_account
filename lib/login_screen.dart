import 'package:flutter/material.dart';
import 'package:flutter_hms_account/login_provider.dart';
import 'package:flutter_hms_account/profile.dart';
import 'package:huawei_account/authbutton/huawei_id_auth_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.silentSignIn();
    return Consumer<LoginProvider>(
      builder: (context, data, _) {
        return data.getUser.id != null
            ? ProfileScreen()
            : LoginWidget(loginProvider: loginProvider);
      },
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key key,
    @required this.loginProvider,
  }) : super(key: key);

  final LoginProvider loginProvider;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: screenSize.height / 6),
            child: HuaweiIdAuthButton(
              onPressed: () {
                loginProvider.signIn();
              },
              buttonColor: AuthButtonBackground.BLACK,
              borderRadius: AuthButtonRadius.MEDIUM,
            ),
          )
        ],
      ),
    );
  }
}
