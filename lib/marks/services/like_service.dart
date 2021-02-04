import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locator_app/db/db.dart' show firestore;
import 'package:locator_app/marks/models/mark.dart';
import 'package:locator_app/resources/constants.dart';

const String likes = 'likes';

class MarkService {
  StreamController<int> likesCountStreamController = StreamController();

  Future<void> mark(String dropId, String userId, String type) async {
    getLikesCollection(dropId).document(userId).setData({
      'type': type,
      'when': DateTime.now().millisecondsSinceEpoch,
    });
  }

  CollectionReference getLikesCollection(String dropId) =>
      firestore.collection(dropKey).document(dropId).collection(likes);

  Future<void> removeMark(String dropId, String userId) =>
      getLikesCollection(dropId).document(userId).delete();

  Stream<Like> isMarked(String dropId, String userId) {
    return getLikesCollection(dropId).snapshots().map((snap) {
      Iterable<DocumentSnapshot> userLikes =
          snap.documents.where((document) => document.documentID == userId);
      if (userLikes.isEmpty) {
        return null;
      } else {
        return Like.fromJson(snap.documents.first.data);
      }
    });
  }

  Stream<int> howMany(String dropId) {
    return getLikesCollection(dropId).snapshots().map((snapshot) {
      int likesCount = snapshot.documents
          .where((document) => document.data['type'] == 'like')
          .length;

      int dislikesCount = snapshot.documents
          .where((document) => document.data['type'] == 'dislike')
          .length;
      return likesCount - dislikesCount;
    });
  }

  dispose() {
    likesCountStreamController.close();
  }
}
