import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:locator/app/app_controller.dart';
import 'package:locator/app/controllers/auth_controller.dart';
import 'package:locator/app/features/account/logged_in_layout.dart';
import 'package:locator/app/features/account/logged_out_layout.dart';
import 'package:locator/app/shared/custom_dialog.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final appController = GetIt.I.get<AppController>();
  final controller = GetIt.I.get<AuthController>();
  CustomDialog customDialog;

  @override
  void initState() {
    super.initState();
    appController.verifyUser();
  }

  googleSignIn() async {
    await controller.googleSignIn();
    if (controller.loggedIn == false) {
      customDialog = CustomDialog(
        title: "Error",
        content: controller.errorMessage,
        dismissible: true,
        buttonText: "Go back",
        context: context,
        onPressed: () {
          Navigator.pop(context);
        },
      );
      customDialog.show();
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Observer(
        builder: (_) {
          if (controller.isLoading == true) {
            return Center(child: CircularProgressIndicator());
          }

          User user = appController.user;

          print("USER? -> $user");

          return user == null
              ? LoggedOutLayout(
                  googleSignIn: () {
                    try {
                      controller.changeLoading(loading: true);
                      googleSignIn();
                      // print("USER LOGGED IN -> ${user.uid}");
                    } finally {
                      controller.changeLoading(loading: true);
                    }
                  },
                )
              : LoggedInLayout(
                  user: user,
                  logout: () {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    auth.signOut();
                  },
                );
        },
      ),
    );
  }
}
