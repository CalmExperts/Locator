import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:locator_app/db/db.dart';
import 'package:locator_app/resources/constants.dart';

changeLocationToSingleMapField() {
  firestore.collection('drop').getDocuments().then((snapshot) {
    for (final DocumentSnapshot document in snapshot.documents) {
      var data = document.data;
      document.reference.updateData({
        'coordinates': {
          'latitude': data['latitude'],
          'longitude': data['longitude']
        },
        'latitude': FieldValue.delete(),
        'longitude': FieldValue.delete()
      });
    }
  });
}

moveTypesToCategories() => firestore
    .collection('type')
    .getDocuments()
    .then((value) => value.documents.forEach((element) async {
          var newDocument =
              firestore.collection('categories').document(element.documentID);
          newDocument.setData(element.data);
          var documentSnapshot = await newDocument.get();
          if (documentSnapshot.exists) {
            await element.reference.delete();
          }
        }));

changeAddedByToDocumentReference() {
  firestore
      .collection('drop')
      .getDocuments()
      .then((snapshot) => snapshot.documents.forEach((element) {
            var data = element.data;
            data['addedBy'] = firestore.document('users/${data['addedBy']}');
            firestore.document('drops/${element.documentID}').setData(data);
          }));
}

moveTypeNamesToCategory() {
  firestore.collection('categories').getDocuments().then((snapshot) {
    firestore
        .collection(dropKey)
        .getDocuments()
        .then((snapshot) => snapshot.documents.forEach((drop) {
              if (drop.data['category'] == null) {
                var categoryId = drop.data['type'];
                drop.reference.updateData({
                  'category': {
                    'name': drop.data['type_name'],
                    'documentReference':
                        firestore.document('categories/$categoryId')
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
      await firestore.document('/categories/MCS8kNHQiuGgUxoZwntF').get();
  var streetDocData = streetDoc.data;
  var newList = [];
  await firestore
      .collection('categories')
      .getDocuments()
      .then((query) => query.documents.forEach((element) {
            if (element.data['name'] != 'Street' &&
                element.data['level'] != 'sub') {
              newList.add(element.reference);
            }
          }));
  streetDocData['categories'] = newList;
  streetDoc.reference.updateData(streetDocData);
}

clearDropsWithNullCoordinates() {
  firestore
      .collection('drops')
      .getDocuments()
      .then((snapshot) => snapshot.documents.forEach((element) {
            if (element.data['coordinates'] == null) {
              element.reference.delete();
              debugPrint('Deleted ${element.reference.path}');
            }
          }));
}

convertDropTagsToMaps() {
  firestore.collection('drops').getDocuments().then((snapshot) => snapshot
      .documents
      .forEach((element) => element.reference.updateData({'tags': {}})));
}

addFieldToDocument(
  String path, {
  @required String field,
  @required dynamic fieldData,
}) =>
    firestore.document(path).updateData({field: fieldData});

convertDropCategoriesTagsToMaps() {
  firestore
      .collection('drops')
      .getDocuments()
      .then((snapshot) => snapshot.documents.forEach((document) {
            Map<String, dynamic> newMap = {};
            var data = document.data;
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
            document.reference.updateData(newMap);
          }));
}
