import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ຂໍ້ມູນຜູ້ໃຊ້'),
      ),
      body: Container(
          child: Center(
        child: Text('User Data'),
      )),
    );
  }
}
