import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locator/app/errors/auth_errors.dart';
import 'package:locator/app/models/firebase_auth_model.dart';
import 'package:locator/app/models/user_model.dart';

class AuthRepository {
  FirebaseAuthModel _authModel = new FirebaseAuthModel(
    auth: FirebaseAuth.instance,
  );
  UserCredential _user;
  GoogleSignInAccount _googleSignInAccount;
  AuthResultStatus _status;

  Future<AuthResultStatus> signIn(UserModel model) async {
    try {
      _user = await _authModel.auth.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      if (_user.user != null) {
        _status = AuthResultStatus.successful;
        print("STATUS -> $_status");
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print("STATUS -> $_status");
    }

    return _status;
  }

  Future<AuthResultStatus> googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _authModel.auth.signInWithCredential(credential);
      final User user = authResult.user;

      if (user != null) {
        _status = AuthResultStatus.successful;
        print("STATUS -> $_status");
      }
    } on FirebaseException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      print("STATUS -> $_status");
    }
    return _status;
  }

  //  Future<AuthResultStatus> signUp(UserModel model) async {
  //   try {
  //     await _authModel.auth.createUserWithEmailAndPassword(
  //         email: model.email, password: model.password);

  //     await _firestoreModel.firestore.collection("users").add({
  //       "name": model.name,
  //     });

  //     if (_user.user != null) {
  //       _status = AuthResultStatus.successful;
  //       print("STATUS -> $_status");
  //     }
  //   } on FirebaseException catch (e) {
  //     _status = AuthExceptionHandler.handleException(e);
  //     print("STATUS -> $_status");
  //   }
  //   return _status;
  // }

}
