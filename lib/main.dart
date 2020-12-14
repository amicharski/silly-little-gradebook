import 'package:flutter/material.dart';
import 'student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool checkBoxValue = false;
  String _firstName;
  String _lastName;
  int _id;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()){
      print("Form is valid");
      form.save();
      Student student = new Student(id: _id, firstName: _firstName, lastName: _lastName);
      print("First Name: ${student.firstName}");
      print("Last Name: ${student.lastName}");
      print("Student ID: ${student.id}");
    } else {
      print("Form is invalid");
    }
  }
  @override
    Widget build(BuildContext context){
    return MaterialApp(
      title: 'Student Registrar',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student Registrar')
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                new Flexible(
                    child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'First Name'
                        ),
                        onSaved: (value) => _firstName = value,
                        validator: (value) => value.isEmpty ? 'Student must have first name' : null
                    )
                ),
                new Flexible(
                    child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Last Name'
                        ),
                        onSaved: (value) => _lastName = value,
                        validator: (value) => value.isEmpty ? 'Student must have last name' : null
                    )
                ),
                new Flexible(
                    child: AbsorbPointer(
                      absorbing: checkBoxValue,
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'ID',
                          ),
                          onSaved: (value) => _id = int.parse(value),
                          validator: (value) => value.contains(new RegExp(r'[^0-9]')) ? 'Student ID can only be an integer' : null
                      ),
                    )
                ),
                new Flexible(
                    child: Row(
                      children: <Widget>[
                        Text('Generate ID'),
                        new Flexible(
                          child: Checkbox(
                              value: checkBoxValue,
                              onChanged: (bool value) {
                                setState(() {
                                  checkBoxValue = value;
                                });
                              }
                          )
                        )
                      ]
                    )
                ),
                new Flexible(
                  child: ElevatedButton(
                    child: Text(
                      'Add Student'
                    ),
                    onPressed: validateAndSave
                  )
                )
              ]
            ),
          )
        )
      )
    );
  }
}

