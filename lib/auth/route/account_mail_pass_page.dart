import 'package:flutter/material.dart';
import 'package:locator/auth/models/user.dart';
import 'package:locator/auth/route/account_page.dart';
import 'package:locator/general/widgets/primary_button.dart';
import 'package:locator/resources/enums.dart';
import 'package:locator/shared/widgets/inputs/email_input.dart';
import 'package:locator/shared/widgets/inputs/password_input.dart';
import 'package:provider/provider.dart';

import '../auth.dart';

class MailPassPage extends StatefulWidget {
  @override
  _MailPassPageState createState() => _MailPassPageState();
}

class _MailPassPageState extends State<MailPassPage> {
  final formKey = GlobalKey<FormState>();
  Auth auth;
  bool loading = false;

  UserModel model = UserModel();

  void signIn() {
    setState(() {
      loading = true;
    });
    auth.login(mode: SignInMode.emailAndPassword, model: model).then((_) {
      setState(() {
        loading = false;
      });

      if (auth.currentUser != null) {
        print("NOT NULL");
        Navigator.pop(context);
      } else {
        print("ERROR");
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    auth = Provider.of<Auth>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: formKey,
          child: StreamBuilder<UserModel>(
              stream: Provider.of<Auth>(context).userStream,
              builder: (context, snapshot) {
                if (loading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmailInput(
                      onSaved: (String value) {
                        model.email = value;
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    PasswordInput(
                      onSaved: (String value) {
                        model.password = value;
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    PrimaryButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          signIn();
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
