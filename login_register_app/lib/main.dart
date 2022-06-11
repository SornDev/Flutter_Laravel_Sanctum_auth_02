import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_register_app/screen/HomeScreen.dart';
import 'package:login_register_app/service/Auth.dart';
import 'package:provider/provider.dart';
import 'package:login_register_app/screen/LoginScreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AuthProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    Provider.of<AuthProvider>(context, listen: false)
        .getToken(token: token.toString());
    // print(token);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: Scaffold(
        body: Center(
          child: Consumer<AuthProvider>(
            builder: (context, auth, child) {
              switch (auth.isAuthenticated) {
                case true:
                  return HomeScreen();
                default:
                  return LoginScreen();
              }
            },
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
