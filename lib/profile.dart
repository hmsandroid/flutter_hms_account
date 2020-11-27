import 'package:flutter/material.dart';
import 'package:flutter_hms_account/login_provider.dart';
import 'package:flutter_hms_account/login_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final _user = Provider.of<LoginProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.black45,
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Row(
                  children: [
                    _buildCircleAvatar(_user.profilePhotoUrl),
                    _userInformationText(_user.displayName, _user.email),
                  ],
                ),
              ),
              Divider(
                color: Colors.black26,
                height: 50,
              ),
            ],
          ),
          OutlineButton.icon(
            textColor: Colors.black54,
            onPressed: () {
              loginProvider.signOut().then((value) {
                loginProvider.revokeAuthorization().then((value) =>
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName));
              });
            },
            icon: Icon(Icons.exit_to_app_sharp, color: Colors.black54),
            label: Text("Log out"),
          )
        ],
      ),
    );
  }
}

Widget _buildCircleAvatar(String photoUrl) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 10,
      top: 30,
    ),
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: photoUrl == null
              ? AssetImage('assets/images/profile_circle_avatar.png')
              : NetworkImage(photoUrl),
        ),
      ),
    ),
  );
}

Widget _userInformationText(String name, String email) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 15.0,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 3,
        ),
        email == null
            ? Text('')
            : Text(
                email,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ],
    ),
  );
}
