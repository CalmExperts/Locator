import 'package:flutter/material.dart';
import 'package:locator/auth/models/user.dart';
import 'package:locator/auth/route/account_page.dart';
import 'package:locator/general/widgets/primary_button.dart';
import 'package:locator/shared/widgets/dialog.dart';
import 'package:locator/shared/widgets/inputs/email_input.dart';
import 'package:locator/shared/widgets/inputs/name_input.dart';
import 'package:locator/shared/widgets/inputs/password_input.dart';
import 'package:provider/provider.dart';

import '../auth.dart';
import '../auth_errors.dart';

class AccountRegistration extends StatefulWidget {
  @override
  _AccountRegistrationState createState() => _AccountRegistrationState();
}

class _AccountRegistrationState extends State<AccountRegistration> {
  final formKey = GlobalKey<FormState>();
  Auth auth;
  bool loading = false;
  String errorMessage = "";
  UserModel model = UserModel();

  signUp() async {
    setState(() {
      loading = true;
    });

    final status = await auth.createUser(model);

    if (status == AuthResultStatus.successful) {
      setState(() {
        loading = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AccountPage(),
          ),
        );
      });
    } else {
      setState(() {
        errorMessage = AuthExceptionHandler.generateExceptionMessage(
          status,
        );
        CustomDialog customDialog = CustomDialog(
          buttonText: "Get back",
          title: "There was an error",
          content: errorMessage,
          context: context,
          dismissible: true,
          onPressed: () {
            Navigator.pop(context);
          },
        );
        customDialog.show();

        loading = false;
      });
    }
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
        child: Center(
          child: Form(
            key: formKey,
            child: StreamBuilder<UserModel>(
                stream: Provider.of<Auth>(context).userStream,
                builder: (context, snapshot) {
                  if (loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          NameInput(
                            onSaved: (String value) {
                              model.name = value;
                            },
                          ),
                          Divider(
                            color: Colors.transparent,
                          ),
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
                                signUp();
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
