import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: implementation_imports
import 'package:cloud_firestore_platform_interface/src/method_channel/method_channel_document_reference.dart';
import 'package:flutter/foundation.dart';
import 'package:locator/db/db.dart';
import 'package:locator/map/models/model.dart';
import 'package:locator/utils/extensions.dart';

class Category extends Model implements Comparable {
  final String name;
  final String description;
  final DocumentReference documentReference;
  final List<DocumentReference> childrenCategories;
  final Map tags;

  final CategoryLevel level;

  Category({
    @required String name,
    @required this.documentReference,
    @required this.level,
    @required this.description,
    @required this.childrenCategories,
    @required this.tags,
  })  : assert(name != null),
        name = name.capitalize().trim();

  const Category.empty(this.name)
      : description = 'Empty',
        documentReference = null,
        childrenCategories = const [],
        tags = const {},
        level = CategoryLevel.top;

  const Category.constant({
    @required this.name,
    @required this.documentReference,
    @required this.level,
    @required this.description,
    @required this.childrenCategories,
    @required this.tags,
  }) : assert(name != null);

  String get id => documentReference.id;

  bool get hasChildren => childrenCategories?.isNotEmpty == true;

  factory Category.fromDocument(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    CategoryLevel categoryLevel = stringToCategoryLevelMap[data['level']];
    List<DocumentReference> childrenCategories;
    if (categoryLevel == CategoryLevel.top) {
      childrenCategories =
          (data['categories'] as List)?.cast<DocumentReference>();
    }
    if (categoryLevel == CategoryLevel.category) {
      childrenCategories =
          (data['subcategories'] as List)?.cast<DocumentReference>();
    }

    if (categoryLevel == CategoryLevel.sub) {
      return Subcategory.fromDocument(documentSnapshot);
    }
    return Category(
      documentReference: documentSnapshot.reference,
      name: data['name'] as String,
      description: data['description'] ?? '',
      level: categoryLevel,
      childrenCategories: childrenCategories,
      tags: data['tags'],
    );
  }

  factory Category.fromJson(Map data) {
    if (data == null) {
      return null;
    }
    var documentReference = data['documentReference'];
    if (documentReference is MethodChannelDocumentReference) {
      documentReference = firestore.doc(documentReference.path);
    }
    List<DocumentReference> childrenCategories;
    if (data['categoryLevel'] == CategoryLevel.top) {
      childrenCategories =
          (data['categories'] as List)?.cast<DocumentReference>();
    }

    return Category(
      documentReference: documentReference,
      name: data['name'],
      description: data['description'],
      level: stringToCategoryLevelMap[data['level']],
      tags: data['tags'],
      childrenCategories: childrenCategories,
    );
  }

  @override
  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'description': description,
        'documentReference': documentReference,
        'level': categoryLevelToStringMap[level],
        'tags': tags,
      };

  @override
  String toString() =>
      '$name${description == null || description.isEmpty ? '' : ', $description'}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          documentReference == other.documentReference;

  @override
  int get hashCode => name.hashCode ^ documentReference.hashCode;

  @override
  int compareTo(other) {
    if (other is Category) {
      return name.compareTo(other.name);
    } else {
      return 0;
    }
  }
}

class Subcategory extends Category {
  Subcategory({
    @required String name,
    @required String description,
    @required DocumentReference documentReference,
    @required Map tags,
  })  : assert(name != null),
        super(
          name: name,
          description: description,
          documentReference: documentReference,
          childrenCategories: null,
          tags: tags,
          level: CategoryLevel.sub,
        );

  factory Subcategory.fromDocument(DocumentSnapshot document) {
    final data = document.data;
    if (data == null) {
      throw Exception(
          'The Document located at ${document.reference.path} does not exist');
    }
    return Subcategory(
      documentReference: document.reference,
      name: data()['name'] as String,
      description: data()['description'] ?? '',
      tags: data()['tags'],
    );
  }

  factory Subcategory.fromJson(Map data) {
    if (data == null) {
      return null;
    }
    var documentReference = data['documentReference'];
    if (documentReference is MethodChannelDocumentReference) {
      documentReference = firestore.doc(documentReference.path);
    }

    return Subcategory(
      documentReference: documentReference,
      name: data['name'],
      description: data['description'],
      tags: data['tags'],
    );
  }
}

enum CategoryLevel { top, category, sub }

Map<String, CategoryLevel> stringToCategoryLevelMap = {
  'top': CategoryLevel.top,
  'category': CategoryLevel.category,
  'sub': CategoryLevel.sub
};

Map<CategoryLevel, String> categoryLevelToStringMap =
    stringToCategoryLevelMap.inverse;
