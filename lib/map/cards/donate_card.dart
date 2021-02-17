import 'package:buffetlocator/app/shared/inputs/password_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app_controller.dart';
import '../../../controllers/auth_controller.dart';
import '../../../models/fridge_model.dart';
import '../../../shared/dialog.dart';
import '../../../shared/inputs/email_input.dart';

class DonateCard extends StatefulWidget {
  const DonateCard({this.fridge});

  final FridgeModel fridge;

  @override
  _DonateCardState createState() => _DonateCardState();
}

class _DonateCardState extends State<DonateCard> {
  final authController = AuthController();
  final appController = AppController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loginPrompt = false;
  bool loginSelected = false;
  bool showPasswordInput = false;
  bool loginSucess = false;
  CustomDialog customDialog;

  @override
  void initState() {
    super.initState();
    // authController.signIn();
  }

  signIn() async {
    await authController.signIn();
    if (authController.loggedIn == false) {
      customDialog = CustomDialog(
        title: "Error",
        content: authController.errorMessage,
        dismissible: true,
        buttonText: "Go back",
        context: context,
        onPressed: () {
          Navigator.pop(context);
        },
      );
      customDialog.show();
    } else {
      setState(() {
        loginPrompt = false;
        loginSelected = false;
        loginSucess = true;
      });
    }
  }

  googleSignIn() async {
    await authController.googleSignIn();
    if (authController.loggedIn == false) {
      customDialog = CustomDialog(
        title: "Error",
        content: authController.errorMessage,
        dismissible: true,
        buttonText: "Go back",
        context: context,
        onPressed: () {
          Navigator.pop(context);
        },
      );
      customDialog.show();
    } else {
      setState(() {
        loginPrompt = false;
        loginSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Visibility(
            visible: !loginPrompt && (!loginSelected && !loginSucess),
            child: new Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Icon(Icons.card_giftcard, size: 48),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Donate',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Donate items to this fridge',
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Flexible(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ["Fridge", Icons.kitchen],
                        ["Space", Icons.local_convenience_store],
                        ["Money", Icons.monetization_on],
                        ["Food", Icons.fastfood],
                      ]
                          .map(
                            (i) => Card(
                              clipBehavior: Clip.antiAlias,
                              shape: StadiumBorder(),
                              child: ListTile(
                                title:
                                    Text(i[0], style: TextStyle(fontSize: 16)),
                                leading: Icon(i[1]),
                                onTap: () {
                                  appController.verifyUser();
                                  if (appController.userId == null) {
                                    setState(() {
                                      loginPrompt = true;
                                    });
                                  } else {
                                    print("User logged in");
                                    FirebaseAuth.instance.signOut();
                                    //????? perguntar sobre
                                  }
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: loginPrompt && !loginSelected,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      loginPrompt = false;
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text(
                    "Back",
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        child: Text("Login with email"),
                        onPressed: () {
                          setState(() {
                            loginSelected = true;
                          });
                    print('ssssax');

                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Divider(
                        height: 72,
                        color: Colors.grey,
                      ),
                    ),
                    Text("CONTINUE WITH"),
                    Flexible(
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Container(
                  // width: 200,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 70,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(),
                              child: (FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Image.asset(
                                  'assets/3-points-icon.png',
                                ),
                                onPressed: () {
                                  print('asdsa');
                                },
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                padding: EdgeInsets.all(0.0),
                                child: Image.asset(
                                  'assets/google-logo.png',
                                ),
                                onPressed: () {
                                  googleSignIn();
                                },
                              ),
                            ),
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  FontAwesomeIcons.facebookF,
                                  size: 40.0,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  authController.facebookSignIn();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: showPasswordInput && loginPrompt,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      showPasswordInput = false;
                      loginSelected = true;
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text(
                    "Back",
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Align(
                  alignment: Alignment.center,
                  child: PasswordInput(
                    controller: passwordController,
                    onSaved: (String value) {
                      authController.model.password = value;
                    },
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        signIn();
                      }
                    },
                  ),
                ),
                Container(
                  // width: 70,
                  height: 65,
                  // color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(),
                        child: (FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: Image.asset(
                            'assets/3-points-icon.png',
                          ),
                          onPressed: () {
                            print('asdsa');
                          },
                        )),
                      ),
                      Container(
                        // width: 95,
                        height: 30,
                        padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        decoration: BoxDecoration(),
                        child: (FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                          // padding: EdgeInsets.all(5.0),
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),

                          child: (Row(
                            children: [
                              Row(
                                children: [Icon(Icons.face_retouching_natural)],
                              ),
                              Text('User')
                            ],
                          )),

                          onPressed: () {
                            print('asdsa');
                          },
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: loginSelected && !showPasswordInput, //---
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton.icon(
                  onPressed: () {
                    setState(() {
                      loginSelected = false;
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                  label: Text(
                    "Back",
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                EmailInput(
                  controller: emailController,
                  onSaved: (String value) {
                    authController.model.email = value;
                  },
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      // signIn();
                      setState(() {
                        showPasswordInput = true;
                      });
                    }
                  },
                ),
                Container(
                  // width: 70,
                  height: 65,
                  // color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(),
                        child: (FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.white, width: 1),
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: 
                          // Image.asset(
                          //   'assets/3-points-icon.png',
                            
                          // )
                          Text(widget.fridge.tags[1])
                          ,

                          onPressed: () {
                            print('asdsa');
                          },
                        )),
                      ),
                    ],
                  ),
                  
                ),
              ],
            ),
          ),
          Visibility(
            visible: loginSucess && !loginPrompt,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.red,
                ),
                Align(
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
