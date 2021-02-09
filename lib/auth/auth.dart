import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:locator/db/db.dart';
import 'package:locator/resources/enums.dart';
import 'package:rxdart/rxdart.dart';

import 'models/user.dart';

class Auth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final BehaviorSubject<User> _userStream = BehaviorSubject<User>();

  Stream<User> get userStream => _userStream.stream;
  User get currentUser => _userStream.value;

  Future<void> logout() async {
    await _googleSignIn.signOut();
    _userStream.add(null);
  }

  Future<GoogleSignInAccount> gLogin() async => _googleSignIn.signIn();

  Future<User> login({SignInMode mode}) async {
    switch (mode) {
      case SignInMode.google:
        GoogleSignInAccount googleUser = await gLogin();
        User user = User.google(googleUser);
        _userStream.add(user);
        register(user);
        return user;
      default:
        return null;
    }
  }

  /// returns a [User] if there is an existing sign in session, otherwise, returns null.
  ///
  /// When [suppressErrors] is set to `false` and an error occurred during sign in
  /// returned Future completes with PlatformException whose `code` can be
  /// either kSignInRequiredError (when there is no authenticated user) or
  /// kSignInFailedError (when an unknown error occurred).
  Future<User> silently({bool suppressErrors = true}) async {
    var gUser =
        await _googleSignIn.signInSilently(suppressErrors: suppressErrors);
    if (gUser == null) {
      return null;
    }
    var user = User.google(gUser);
    register(user);
    _userStream.add(user);
    return user;
  }

  void close() => _userStream.close();

  void register(User user) =>
      firestore.collection('users').doc(user.id).set(user.toMap());
}
