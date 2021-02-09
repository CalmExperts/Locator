import 'package:flutter/material.dart';
import 'package:locator/auth/auth.dart';
import 'package:locator/auth/models/user.dart';
import 'package:locator/general/widgets/primary_button.dart';
import 'package:locator/general/widgets/user_avatar.dart';
import 'package:locator/options/widgets/options_item.dart';
import 'package:locator/resources/colors.dart';
import 'package:locator/resources/enums.dart' show SignInMode;
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Auth auth;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<UserModel>(
          stream: Provider.of<Auth>(context).userStream,
          builder: (context, snapshot) {
            final user = snapshot.data;
            return Center(
              child: loading
                  ? CircularProgressIndicator()
                  : user == null
                      ? LoggedOutLayout(login: login, signIn: signIn)
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

  void login() {
    setState(() {
      loading = true;
    });
    auth.login(mode: SignInMode.google).then((_) {
      print('');
      setState(() {
        loading = false;
      });
    });
  }

  void signIn() {
    setState(() {
      loading = true;
    });
    auth.login(mode: SignInMode.emailAndPassword).then((_) {
      print('');
      setState(() {
        loading = false;
      });
    });
  }

  void logout() => auth.logout().then((_) => setState(() {}));
}

class LoggedOutLayout extends StatelessWidget {
  final Function login;
  final Function signIn;

  const LoggedOutLayout({Key key, this.login, this.signIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
//        Text('You are not logged in', style: Theme.of(context).textTheme.headline6),
        Text('You are not logged in',
            style: Theme.of(context).textTheme.headline6),
        Container(height: 48),
        PrimaryButton(
          onPressed: login,
          child: Text('Log in'),
        ),
        PrimaryButton(
          onPressed: signIn,
          child: Text('Mail and Pass'),
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
          backgroundColor: darkAccent,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(user.name),
            background: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 48),
                  child: UserAvatar(radius: 120),
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: Column(
            children: <Widget>[
              OptionsItem(
                child: Text('Logout'),
                function: logout,
              ),
            ],
          ),
        )
      ],
    );
  }
}
