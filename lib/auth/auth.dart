import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locator/auth/auth_errors.dart';
import 'package:locator/db/db.dart';
import 'package:locator/resources/enums.dart';
import 'package:rxdart/rxdart.dart';

import 'models/user.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final BehaviorSubject<UserModel> _userStream = BehaviorSubject<UserModel>();
  AuthResultStatus _status;

  Stream<UserModel> get userStream => _userStream.stream;
  UserModel get currentUser => _userStream.value;

  Future<void> logout() async {
    // await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    _userStream.add(null);
  }

  Future<GoogleSignInAccount> gLogin() async => _googleSignIn.signIn();

  Future<User> signIn(UserModel userModel) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
            email: userModel.email, password: userModel.password);

    User user = userCredential.user;

    return user;
  }

  Future<User> signUp(UserModel userModel) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email, password: userModel.password);

    await _firebaseAuth.currentUser.updateProfile(
      displayName: userModel.name,
      photoURL:
          "https://media-exp1.licdn.com/dms/image/C4D0BAQHgjgLHxmJNSw/company-logo_200_200/0/1607739831527?e=2159024400&v=beta&t=DtZHXNhj0qEWteqDvH3GLxI6D5M483z8EGtEC7XWkyI",
    );

    User user = _firebaseAuth.currentUser;

    return user;
  }

  Future<AuthResultStatus> login({SignInMode mode, UserModel model}) async {
    switch (mode) {
      case SignInMode.google:
        try {
          final GoogleSignInAccount googleSignInAccount = await gLogin();
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          final UserCredential authResult =
              await _firebaseAuth.signInWithCredential(credential);
          final User user = authResult.user;
          UserModel userModel = UserModel.currentUser(user);

          if (user != null) {
            _status = AuthResultStatus.successful;
            print("STATUS -> $_status");
          }
          _userStream.add(userModel);
          register(userModel);
        } on FirebaseException catch (e) {
          _status = AuthExceptionHandler.handleException(e);
          print("STATUS -> $_status");
        }
        return _status;
        break;
      case SignInMode.emailAndPassword:
        try {
          User user = await signIn(model);

          if (user != null) {
            _status = AuthResultStatus.successful;
            print("STATUS -> $_status");
          }
          UserModel userModel = UserModel.currentUser(user);
          _userStream.add(userModel);
          register(userModel);
        } on FirebaseException catch (e) {
          _status = AuthExceptionHandler.handleException(e);
          print("STATUS -> $_status");
        }

        return _status;
        break;
      default:
        return null;
    }
  }

  Future<AuthResultStatus> createUser(UserModel model) async {
    try {
      User user = await signUp(model);
      if (user != null) {
        _status = AuthResultStatus.successful;
        print("STATUS -> $_status");
      }
      UserModel userModel = UserModel.currentUser(user);
      _userStream.add(userModel);
      register(userModel);
    } on FirebaseException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print("STATUS -> $_status");
    }
    return _status;
  }

  /// returns a [UserModel] if has email and password configured in
  /// the firebase OR it's signed in at Google.
  Future<UserModel> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;

    if (user != null) {
      print("USER -> ${user.uid}");

      var userModel = UserModel.currentUser(user);
      register(userModel);
      _userStream.add(userModel);
      return userModel;
    }

    return null;
  }

  /// returns a [User] if there is an existing sign in session, otherwise, returns null.
  ///
  /// When [suppressErrors] is set to `false` and an error occurred during sign in
  /// returned Future completes with PlatformException whose `code` can be
  /// either kSignInRequiredError (when there is no authenticated user) or
  /// kSignInFailedError (when an unknown error occurred).
  // Future<UserModel> silently({bool suppressErrors = true}) async {
  //   var gUser =
  //       await _googleSignIn.signInSilently(suppressErrors: suppressErrors);

  //   // print("ID -> ${gUser.id}");
  //   if (gUser == null) {
  //     return null;
  //   }
  //   var user = UserModel.google(gUser);
  //   register(user);
  //   _userStream.add(user);

  //   return user;
  // }

  void close() => _userStream.close();

  void register(UserModel user) =>
      firestore.collection('users').doc(user.id).set(user.toMap());
}
