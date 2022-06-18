import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/Auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _shpass = true;
  bool _shpass2 = true;

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _password2 = '';
  String _errormessage = '';

  Future<void> submitForm() async {
    setState(() {
      _errormessage = '';
    });

    if (_password == _password2) {
      bool result = await Provider.of<AuthProvider>(context, listen: false)
          .register(_name, _email, _password);

      if (result == true) {
        print(result);
        Navigator.pop(context);
      } else if (result == false) {
        setState(() {
          _errormessage = 'ການລົງທະບຽນບໍ່ສຳເລັດ!';
        });
      }
    } else {
      setState(() {
        _errormessage = 'ລະຫັດຜ່ານບໍ່ກົງກັນ!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'ກະລຸນາປ້ອນຊື່';
                  }
                },
                onSaved: (value) => _name = value!,
                decoration: InputDecoration(
                  hintText: 'ຊື່ຜູ້ໃຊ້',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'ກະລຸນາປ້ອນອີເມວລ໌';
                  }
                },
                onSaved: (value) => _email = value!,
                decoration: InputDecoration(
                    hintText: 'ອີເມວລ໌', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
                  } else if (value.length <= 5) {
                    return 'ລະຫັດຕ້ອງຫຼາຍກ່ວາ 6 ຕົວອັກສອນ';
                  }
                },
                onSaved: (value) => _password = value!,
                decoration: InputDecoration(
                  hintText: 'ລະຫັດຜ່ານ',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon:
                        Icon(_shpass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _shpass = !_shpass;
                      });
                    },
                  ),
                ),
                obscureText: _shpass,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'ກະລຸນາປ້ອນລະຫັດຜ່ານ';
                  } else if (value.length <= 5) {
                    return 'ລະຫັດຕ້ອງຫຼາຍກ່ວາ 6 ຕົວອັກສອນ';
                  }
                },
                onSaved: (value) => _password2 = value!,
                decoration: InputDecoration(
                  hintText: 'ຍືນຍັນລະຫັດຜ່ານ',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _shpass2 = !_shpass2;
                      });
                    },
                    icon: Icon(
                        _shpass2 ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                obscureText: _shpass2,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                child: Text(
                  _errormessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      submitForm();
                    }
                  },
                  child: const Text(
                    'ລົງທະບຽນ',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
