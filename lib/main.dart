import 'package:flutter/material.dart';
import 'package:flutter_hms_account/login_provider.dart';
import 'package:flutter_hms_account/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => LoginProvider(),
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
