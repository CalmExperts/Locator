import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthModel {
  FirebaseAuth auth;

  FirebaseAuthModel({
    this.auth,
  });

  factory FirebaseAuthModel.auth() {
    return FirebaseAuthModel(
      auth: FirebaseAuth.instance,
    );
  }
}
