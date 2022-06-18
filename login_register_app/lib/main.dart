import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_register_app/screen/HomeScreen.dart';
import 'package:login_register_app/service/Auth.dart';
import 'package:login_register_app/service/Transection_provider.dart';
import 'package:provider/provider.dart';
import 'package:login_register_app/screen/LoginScreen.dart';

// void main() {
//   runApp(ChangeNotifierProvider(
//     create: (BuildContext context) => AuthProvider(),
//     child: MyApp(),
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'lo']);
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => AuthProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => TransectionProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
    return LocaleBuilder(
      builder: (locale) => MaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
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
      ),
    );
  }
}
