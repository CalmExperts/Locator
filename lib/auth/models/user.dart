import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locator/db/db.dart';
import 'package:locator/map/models/model.dart';

class UserModel extends Model {
  String email;
  String password;
  String name;
  String picUrl;
  String id;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.picUrl,
    this.id,
  });

  DocumentReference get documentReference =>
      firestore.collection('users').doc(id);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'picUrl':
          "https://media-exp1.licdn.com/dms/image/C4D0BAQHgjgLHxmJNSw/company-logo_200_200/0/1607739831527?e=2159024400&v=beta&t=DtZHXNhj0qEWteqDvH3GLxI6D5M483z8EGtEC7XWkyI",
      'id': id,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      name: data['name'],
      picUrl: data['picUrl'],
      id: data['id'],
    );
  }

  factory UserModel.google(GoogleSignInAccount googleUser) {
    return UserModel(
      email: googleUser.email,
      name: googleUser.displayName,
      picUrl: googleUser.photoUrl,
      id: googleUser.id,
    );
  }

  factory UserModel.currentUser(User signedUser) {
    // User signedUser = userCredential.user;
    return UserModel(
      email: signedUser.email,
      name: signedUser.displayName,
      picUrl: signedUser.photoURL,
      id: signedUser.uid,
    );
  }
}