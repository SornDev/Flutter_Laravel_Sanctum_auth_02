import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_register_app/screen/AddScreen.dart';
import 'package:login_register_app/screen/UserInfo.dart';
import 'package:login_register_app/service/Auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: const Center(
        child: Text('Home app'),
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
              title: Text('ຂໍ້ມູນຜູ້ໃຊ້'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                // getUserData();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfo()));
              },
            ),
            ListTile(
              title: Text('ອອກຈາກລະບົບ'),
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
