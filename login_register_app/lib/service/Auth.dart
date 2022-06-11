import 'package:flutter/material.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import '../model/User.dart';
import 'Dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  late User _user;
  late String _token;

  bool get isAuthenticated => _isAuthenticated;
  User get user => _user;

  final storage = new FlutterSecureStorage();

  Future<bool> login(email, password) async {
    Map creds = {
      'email': email,
      'password': password,
      'device_name': await getDeviceId(),
    };

    final response = await dio().post('/sanctum/token',
        data: creds, options: Options(validateStatus: ((status) => true)));

    if (response.statusCode == 200) {
      String token = response.data.toString();
      await saveToken(token);
      this._token = token;
      getToken(token: token);
      _isAuthenticated = true;
      notifyListeners();
      return true;
    }

    if (response.statusCode == 422) {
      return false;
    }

    return false;
  }

  getDeviceId() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return build.androidId;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor;
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  void getToken({required String token}) async {
    if (token == null) {
      return;
    } else {
      try {
        final response = await dio().get('/user',
            options: Options(
                headers: {'Authorization': 'Bearer $token'},
                validateStatus: ((status) => true)));

        //  print(response.statusCode);

        if (response.statusCode == 200) {
          _isAuthenticated = true;
          this._user = User.fromJson(response.data);
          //print(response.data.toString());
          notifyListeners();
          _token = token;
        }
        //this._isAuthenticated = true;
        //this._user = User.fromJson(response.data);
        //this._token = token;

      } catch (e) {
        print(e);
      }
    }
  }

  saveToken(String token) async {
    //final prefs = await SharedPreferences.getInstance();
    //await prefs.setString('token', token);
    await storage.write(key: 'token', value: token);
  }

  logout() async {
    try {
      String? token = await storage.read(key: 'token');
      // print(token);
      await dio().get('/user/revoke',
          options: Options(
              headers: {'Authorization': 'Bearer $token'},
              validateStatus: ((status) => true)));
      cleanUp();
    } catch (e) {
      print(e);
    }
  }

  cleanUp() async {
    // String? _user = null;
    _isAuthenticated = false;
    notifyListeners();
    // print('remove ok!');
    String? _token = null;
    await storage.delete(key: 'token');
  }
}
