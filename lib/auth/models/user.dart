import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:locator_app/db/db.dart';
import 'package:locator_app/map/models/model.dart';

class User extends Model {
  final String email;
  final String name;
  final String picUrl;
  final String id;

  User({
    this.email,
    this.name,
    this.picUrl,
    this.id,
  });

  DocumentReference get documentReference =>
      firestore.collection('users').document(id);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'picUrl': picUrl,
      'id': id,
    };
  }

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      email: data['email'],
      name: data['name'],
      picUrl: data['picUrl'],
      id: data['id'],
    );
  }

  factory User.google(GoogleSignInAccount googleUser) {
    return User(
      email: googleUser.email,
      name: googleUser.displayName,
      picUrl: googleUser.photoUrl,
      id: googleUser.id,
    );
  }
}
