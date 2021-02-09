import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show required;
import 'package:locator_app/auth/models/user.dart';
import 'package:locator_app/db/db.dart' show firestore;
import 'package:locator_app/map/models/category.dart';
import 'package:locator_app/map/models/drop.dart';
import 'package:locator_app/resources/constants.dart';
import 'package:locator_app/utils/extensions.dart';

class DropService {
  final User user;

  DropService({@required this.user});

  Stream<List<Drop>> fetch(Category category) {
    return firestore
        .collection(dropKey)
        .whereIf('category.documentReference',
            isEqualTo: category?.documentReference, condition: category != null)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .where((document) {
            final data = document.data();
            if (data['isDraft'] != true) {
              return true;
            }
            if (user == null) {
              return false; // don't return drafts unless the draft belongs to the logged in user.
            } else {
              return document.data()['addedBy'] == user.documentReference;
            }
          })
          .map((documentSnapshot) => Drop.fromDocument(documentSnapshot))
          .toList();
    });
  }

  Future<DocumentReference> create(Drop drop) =>
      firestore.collection(dropKey).add(drop.toMap());

  void update(Drop drop) => drop.documentReference.set(drop.toMap());
}
