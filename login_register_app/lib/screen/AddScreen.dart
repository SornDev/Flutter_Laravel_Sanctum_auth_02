import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:login_register_app/model/Transection.dart';
import 'package:login_register_app/service/Transection_provider.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final formKey = GlobalKey<FormState>();
  String _food_name = '';
  String _food_price = '';

  Future<void> submitForm() async {
    Transection statement = Transection(
      title: _food_name,
      amount: double.parse(_food_price),
      date: DateTime.now(),
    );
    await Provider.of<TransectionProvider>(context, listen: false)
        .addTransection(statement);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: LocaleText('add_new')),
      body: Form(
        key: formKey,
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
                    return 'ກະລຸນາປ້ອນຊື່ອາຫານ';
                  }
                },
                onSaved: (value) => _food_name = value!,
                autofocus: true,
                decoration: InputDecoration(
                    // hintText: LocaleText('food_name'),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'ກະລຸນາປ້ອນລາຄາ';
                  }
                },
                onSaved: (value) => _food_price = value!,
                decoration: InputDecoration(
                    //  hintText: LocaleText('price'),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      submitForm();
                    }
                    Navigator.pop(context);
                  },
                  child: const LocaleText(
                    'save',
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
