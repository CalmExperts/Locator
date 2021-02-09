import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:locator/db/db.dart';
import 'package:locator/resources/constants.dart';

changeLocationToSingleMapField() {
  firestore.collection('drop').get().then((snapshot) {
    for (final DocumentSnapshot document in snapshot.docs) {
      var data = document.data;
      document.reference.update({
        'coordinates': {
          'latitude': data()['latitude'],
          'longitude': data()['longitude']
        },
        'latitude': FieldValue.delete(),
        'longitude': FieldValue.delete()
      });
    }
  });
}

moveTypesToCategories() => firestore
    .collection('type')
    .get()
    .then((value) => value.docs.forEach((element) async {
          var newDocument = firestore.collection('categories').doc(element.id);
          newDocument.set(element.data());
          var documentSnapshot = await newDocument.get();
          if (documentSnapshot.exists) {
            await element.reference.delete();
          }
        }));

changeAddedByToDocumentReference() {
  firestore
      .collection('drop')
      .get()
      .then((snapshot) => snapshot.docs.forEach((element) {
            var data = element.data();
            data['addedBy'] = firestore.doc('users/${data['addedBy']}');
            firestore.doc('drops/${element.id}').set(data);
          }));
}

moveTypeNamesToCategory() {
  firestore.collection('categories').get().then((snapshot) {
    firestore
        .collection(dropKey)
        .get()
        .then((snapshot) => snapshot.docs.forEach((drop) {
              if (drop.data()['category'] == null) {
                var categoryId = drop.data()['type'];
                drop.reference.update({
                  'category': {
                    'name': drop.data()['type_name'],
                    'documentReference': firestore.doc('categories/$categoryId')
                  },
                  'type': FieldValue.delete(),
                  'type_name': FieldValue.delete()
                });
              }
            }));
  });
}

addCategoriesToTopCategory() async {
  final streetDoc =
      await firestore.doc('/categories/MCS8kNHQiuGgUxoZwntF').get();
  var streetDocData = streetDoc.data();
  var newList = [];
  await firestore
      .collection('categories')
      .get()
      .then((query) => query.docs.forEach((element) {
            if (element.data()['name'] != 'Street' &&
                element.data()['level'] != 'sub') {
              newList.add(element.reference);
            }
          }));
  streetDocData['categories'] = newList;
  streetDoc.reference.update(streetDocData);
}

clearDropsWithNullCoordinates() {
  firestore
      .collection('drops')
      .get()
      .then((snapshot) => snapshot.docs.forEach((element) {
            if (element.data()['coordinates'] == null) {
              element.reference.delete();
              debugPrint('Deleted ${element.reference.path}');
            }
          }));
}

convertDropTagsToMaps() {
  firestore.collection('drops').get().then((snapshot) => snapshot.docs
      .forEach((element) => element.reference.update({'tags': {}})));
}

addFieldToDocument(
  String path, {
  @required String field,
  @required dynamic fieldData,
}) =>
    firestore.doc(path).update({field: fieldData});

convertDropCategoriesTagsToMaps() {
  firestore
      .collection('drops')
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
            Map<String, dynamic> newMap = {};
            var data = document.data();
            if (data['category'] != null && data['category']['tags'] is List) {
              Map oldCategory = data['category'];
              oldCategory['tags'] = {};
              newMap['category'] = oldCategory;
            }
            if (data['topCategory'] != null &&
                data['topCategory']['tags'] is List) {
              Map oldCategory = data['topCategory'];
              oldCategory['tags'] = {};
              newMap['topCategory'] = oldCategory;
            }
            if (data['subcategory'] != null &&
                data['subcategory']['tags'] is List) {
              Map oldCategory = data['subcategory'];
              oldCategory['tags'] = {};
              newMap['subcategory'] = oldCategory;
            }
            document.reference.update(newMap);
          }));
}
