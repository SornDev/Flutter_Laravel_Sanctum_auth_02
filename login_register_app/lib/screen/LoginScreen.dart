import 'package:flutter/material.dart';
import 'package:login_register_app/service/Auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _errorMessage = '';

  Future<void> submitForm() async {
    setState(() {
      _errorMessage = '';
    });
    bool result = await Provider.of<AuthProvider>(context, listen: false)
        .login(_email, _password);
    print(result);
    if (result == false) {
      setState(() {
        _errorMessage = 'ອີເມວລ໌ ຫຼື ລະຫັດຜ່ານບໍ່ຖຶກຕ້ອງ!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Image.asset('assets/images/sorndev_logo.jpg'),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              autofocus: true,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'ກະລຸນາປ້ອນຂໍ້ມູນ';
                }
              },
              onSaved: (value) => _email = value!,
              decoration: const InputDecoration(
                //labelText: 'ອີເມວລ໌',
                hintText: 'ອີເມວລ໌',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                border: OutlineInputBorder(),
                // focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: Colors.red)),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
                } else if (value.length <= 5) {
                  return 'ລະຫັດຕ້ອງຫຼາຍກ່ວາ 6 ຕົວອັກສອນ';
                }
              },
              onSaved: (value) => _password = value!,
              decoration: const InputDecoration(
                //labelText: 'ລະຫັດຜ່ານ',
                hintText: 'ລະຫັດຜ່ານ',
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                border: OutlineInputBorder(),
                // focusedBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: Colors.red)),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            Container(
              alignment: Alignment(1.0, 0.0),
              padding: EdgeInsets.only(top: 15.0, left: 15.0),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //       builder: (BuildContext context) =>
                  //           new ResetPasswordPage(title: 'Reset Password'),
                  //     ));
                },
                child: const Text(
                  'ລຶມລະຫັດຜ່ານ?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    submitForm();
                  }
                },
                child: Text(
                  'ເຂົ້າສູ່ລະບົບ',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // );
  }
}
