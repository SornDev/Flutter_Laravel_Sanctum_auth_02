import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ເພີ່ມຂໍ້ມູນໃໝ່')),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: ListView(
            children: const <Widget>[
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'ອີເມວລ໌', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'ອີເມວລ໌', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'ອີເມວລ໌', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'ອີເມວລ໌', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
