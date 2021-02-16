import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  final onSaved;
  final validator;

  const NameInput({Key key, @required this.onSaved, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      cursorColor: Colors.yellow,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: "Name",
        hintStyle: TextStyle(color: Colors.white, fontSize: 16.0),
        alignLabelWithHint: true,
        enabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        suffixIcon: Icon(
          Icons.person,
          color: Theme.of(context).accentColor,
        ),
      ),
      onSaved: onSaved,
      validator: (String value) {
        if (value.isEmpty) {
          return "Field can't be empty";
        } else if (value.length < 3) {
          return "Name has to be at least 3 characters";
        }
        return null;
      },
    );
  }
}
