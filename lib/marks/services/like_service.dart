import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locator/db/db.dart' show firestore;
import 'package:locator/marks/models/mark.dart';
import 'package:locator/resources/constants.dart';

const String likes = 'likes';

class MarkService {
  StreamController<int> likesCountStreamController = StreamController();

  Future<void> mark(String dropId, String userId, String type) async {
    getLikesCollection(dropId).doc(userId).set({
      'type': type,
      'when': DateTime.now().millisecondsSinceEpoch,
    });
  }

  CollectionReference getLikesCollection(String dropId) =>
      firestore.collection(dropKey).doc(dropId).collection(likes);

  Future<void> removeMark(String dropId, String userId) =>
      getLikesCollection(dropId).doc(userId).delete();

  Stream<Like> isMarked(String dropId, String userId) {
    return getLikesCollection(dropId).snapshots().map((snap) {
      Iterable<DocumentSnapshot> userLikes =
          snap.docs.where((doc) => doc.id == userId);
      if (userLikes.isEmpty) {
        return null;
      } else {
        return Like.fromJson(snap.docs.first.data());
      }
    });
  }

  Stream<int> howMany(String dropId) {
    return getLikesCollection(dropId).snapshots().map((snapshot) {
      int likesCount =
          snapshot.docs.where((doc) => doc.data()['type'] == 'like').length;

      int dislikesCount =
          snapshot.docs.where((doc) => doc.data()['type'] == 'dislike').length;
      return likesCount - dislikesCount;
    });
  }

  dispose() {
    likesCountStreamController.close();
  }
}
