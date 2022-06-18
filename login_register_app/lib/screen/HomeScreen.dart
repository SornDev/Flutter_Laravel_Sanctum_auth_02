import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:login_register_app/model/Transection.dart';
import 'package:login_register_app/screen/AddScreen.dart';
import 'package:login_register_app/screen/UserInfo.dart';
import 'package:login_register_app/service/Auth.dart';
import 'package:login_register_app/service/Transection_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var myMenuItems = <String>['en', 'lao'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText('home'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
                Icons.language), //don't specify icon if you want 3 dot menu
            color: Colors.blue,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "en",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "la",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            onSelected: (item) => {
              if (item == 0)
                {Locales.change(context, 'en')}
              else if (item == 1)
                {Locales.change(context, 'lo')}
            },
          ),
          // PopupMenuButton<String>(
          //  itemBuilder: (BuildContext context) {

          // return myMenuItems.map((String choice) {
          //   return PopupMenuItem<String>(
          //     child: Text(choice),
          //     value: choice,
          //   );
          // }).toList();
          //},
          //onSelected: ,
          // ),
        ],
      ),
      body: Consumer<TransectionProvider>(
        builder: (context, transection, child) {
          var count = transection.transections.length;
          if (count <= 0) {
            return const Center(
              child: LocaleText(
                'no_data',
                style: TextStyle(fontSize: 30),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: count,
              itemBuilder: (context, int index) {
                Transection data = transection.transections[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset('assets/images/fast-food.png'),
                    ),
                    title: Text(data.title),
                    subtitle: Text('ລາຄາ: ' +
                        data.amount.toString() +
                        ' | ວັນທີ່: ' +
                        DateFormat('dd/mm/yyyy').format(data.date)),
                  ),
                );
              },
            );
          }
        },
      ),
      drawer:
          Drawer(child: Consumer<AuthProvider>(builder: (context, auth, child) {
        return ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(auth.user.avatar),
                    radius: 40,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    auth.user.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    auth.user.email,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: LocaleText('user_info'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                // getUserData();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfo()));
              },
            ),
            ListTile(
              title: LocaleText('log_out'),
              leading: Icon(Icons.logout),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            ),
          ],
        );
      })),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddScreen()),
            );
          }),
    );
  }
}
