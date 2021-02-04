import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locator_app/map/models/category.dart';
import 'package:locator_app/map/models/coordinates.dart';
import 'package:locator_app/map/models/model.dart';

class Drop extends Model {
  final Category topCategory;
  final Category category;
  final Subcategory subcategory;
  final Map tags;

  final Coordinates coordinates;

  // Whether or not this drop is in the middle of being created.
  // drafts only appear to the user creating them.
  final bool isDraft;

  // a usr generated comment on where the object is located, e.g. 'next to the
  // elevator', 'second floor', etc.
  final String location;

  // a mark describing the condition of the object, in terms of how clean or
  // usable it is; calculated as the average of marks given by users
  final double condition;

  // foreign key showing what user added this object to the map
  final DocumentReference addedBy;

  // date stamp showing how recent the state of the object is
  final Timestamp lastEdited;

  // boolean stamp that shows if the object is actually there
  final bool verified;

  // how many confirmations there are that the object is there
  final int likes;

  // description of when this object is accessible
  //TODO: Shouldn't this be a List of times?
  final String open;

  final DocumentReference documentReference;

  // id of Google Maps drop marker this drop is depicted with
  String get id => documentReference.documentID;

  Drop({
    this.topCategory,
    this.category,
    this.subcategory,
    this.coordinates,
    this.location, // from user, on create
    this.condition, // from user, on create
    this.addedBy,
    this.lastEdited,
    this.verified,
    this.likes,
    this.open, // from user, on create
    this.documentReference,
    this.isDraft = false,
    this.tags = const {},
  });

  factory Drop.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data;
    // Use this if we start getting null data showing up in the db.
//    if (data.entries.where((element) => element.value == null).length > 4) {
//      document.reference.delete();
//      return null;
//    }
    return Drop(
      documentReference: document.reference,
      category: Category.fromJson(data['category']),
      topCategory: Category.fromJson(data['topCategory']),
      subcategory: Subcategory.fromJson(data['subcategory']),
      coordinates: Coordinates.fromJson(data['coordinates']),
      location: data['location'] ?? '',
      condition: data['condition'],
      addedBy: data['addedBy'],
      lastEdited: data['lastEdited'],
      verified: data['verified'],
      likes: data['likes'],
      open: data['open'],
      isDraft: data['isDraft'] ?? false,
      tags: data['tags'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topCategory': topCategory?.toMap(),
      'category': category?.toMap(),
      if (subcategory != null) 'subcategory': subcategory.toMap(),
      'coordinates': coordinates?.toMap(),
      'location': location,
      'condition': condition,
      'addedBy': addedBy,
      'lastEdited': lastEdited,
      'verified': verified,
      'likes': likes,
      'open': open,
      if (isDraft) 'isDraft': isDraft,
      'tags': tags,
    };
  }

  @override
  String toString() {
    return '${category?.name ?? ''} at $coordinates\n documentReference: ${documentReference.path}';
  }

  Drop copyWith({
    String typeId,
    Category topCategory,
    Category category,
    Subcategory subcategory,
    String typeName,
    Coordinates coordinates,
    String location,
    double condition,
    DocumentReference addedBy,
    Timestamp lastEdited,
    bool verified,
    int likes,
    String open,
    bool isDraft,
    Map tags,
  }) =>
      Drop(
        topCategory: topCategory ?? this.topCategory,
        category: category ?? this.category,
        subcategory: subcategory ?? this.subcategory,
        coordinates: coordinates ?? this.coordinates,
        location: location ?? this.location,
        condition: condition ?? this.condition,
        addedBy: addedBy ?? this.addedBy,
        lastEdited: lastEdited ?? this.lastEdited,
        verified: verified ?? this.verified,
        likes: likes ?? this.likes,
        open: open ?? this.open,
        isDraft: isDraft ?? this.isDraft,
        documentReference: documentReference,
        tags: tags ?? this.tags,
      );

  Category get lowestLevelCategory => subcategory ?? category;

  Future<void> delete() => documentReference.delete();
}
