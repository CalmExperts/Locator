import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  final onSaved;

  const EmailInput({Key key, @required this.onSaved}) : super(key: key);

  String validateEmail(String valor) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    String novoValor = valor.trim();
    if (novoValor.length == 0) {
      return "Field can't be empty";
    } else if (!regExp.hasMatch(novoValor)) {
      return "Invalid E-Mail";
    } else {
      return null;
    }
  }

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
        hintText: "E-Mail",
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
          Icons.mail_outline,
          color: Theme.of(context).accentColor,
        ),
      ),
      onSaved: onSaved,
      validator: validateEmail,
    );
  }
}
