import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final onSaved;
  final validator;

  const PasswordInput({Key key, @required this.onSaved, this.validator})
      : super(key: key);

  validatePassword(String value) {
    if (value.isEmpty) {
      return "Field can't be empty";
    } else if (value.length < 8) {
      return "Password has to be at least 8 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
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
        hintText: "Password",
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
          Icons.lock_outline,
          color: Theme.of(context).accentColor,
        ),
      ),
      onSaved: onSaved,
      validator: (String value) {
        return validatePassword(value);
      },
    );
  }
}
