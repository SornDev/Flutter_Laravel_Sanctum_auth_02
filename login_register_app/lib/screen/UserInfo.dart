import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText('user_info'),
      ),
      body: Container(
          child: Center(
        child: Text('User Data'),
      )),
    );
  }
}
