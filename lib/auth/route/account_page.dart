import 'package:flutter/material.dart';
import 'package:locator/auth/auth.dart';
import 'package:locator/auth/models/user.dart';
import 'package:locator/auth/route/account_mail_pass_page.dart';
import 'package:locator/general/widgets/primary_button.dart';
import 'package:locator/general/widgets/user_avatar.dart';
import 'package:locator/options/widgets/options_item.dart';
import 'package:locator/resources/style/dark_colors.dart';
import 'package:locator/resources/enums.dart' show SignInMode;
import 'package:locator/shared/widgets/dialog.dart';
import 'package:provider/provider.dart';

import '../auth_errors.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Auth auth;
  bool loading = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: StreamBuilder<UserModel>(
          stream: Provider.of<Auth>(context).userStream,
          builder: (context, snapshot) {
            final user = snapshot.data;
            return Center(
              child: loading
                  ? CircularProgressIndicator()
                  : user == null
                      ? LoggedOutLayout(login: login)
                      : LoggedInLayout(logout: logout, user: user),
            );
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    auth = Provider.of<Auth>(context);
  }

  login() async {
    setState(() {
      loading = true;
    });

    final status = await auth.login(mode: SignInMode.google);

    if (status == AuthResultStatus.successful) {
      setState(() {
        loading = false;
        // Navigator.pop(context);
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

    // auth.login(mode: SignInMode.google).then((_) {
    //   print('');
    // setState(() {
    //   loading = false;
    // });
    // });
  }

  void logout() => auth.logout().then((_) => setState(() {}));
}

class LoggedOutLayout extends StatelessWidget {
  final Function login;
  // final Function signIn;

  const LoggedOutLayout({Key key, this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('You are not logged in',
            style: Theme.of(context).textTheme.subtitle1),
        Container(height: 48),
        OutlineButton.icon(
          onPressed: () {
            login();
          },
          icon: Image.asset('assets/images/google-logo.png',
              height: 40, width: 40),
          label: Text(
            "Log in with Google",
            style: Theme.of(context).textTheme.headline6,
          ),
          borderSide: BorderSide(
            color: Theme.of(context).highlightColor.withOpacity(0.8),
          ),
          textColor: Theme.of(context).highlightColor.withOpacity(0.8),
          highlightedBorderColor:
              Theme.of(context).highlightColor.withOpacity(0.8),
        ),
        PrimaryButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MailPassPage(),
              ),
            );
          },
          child: Text(
            'Mail and Pass',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }
}

class LoggedInLayout extends StatelessWidget {
  final Function logout;
  final UserModel user;

  const LoggedInLayout({Key key, this.logout, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200,
          backgroundColor: Theme.of(context).primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              child: Column(
                // crossAxisAlignment:CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserAvatar(radius: 120),
                  Container(
                    child: Text(
                      user.name,
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  )
                ],
              ),

              // Column(
              //   padding: const EdgeInsets.only(bottom: 0),
              //   child:
              // ),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Column(
            children: <Widget>[
              OptionsItem(
                child: Text(
                  '-LOGOUT-',
                  style: Theme.of(context).textTheme.headline6,
                ),
                function: logout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
