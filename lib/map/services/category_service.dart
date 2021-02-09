import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locator_app/db/db.dart' show firestore;
import 'package:locator_app/map/models/category.dart';
import 'package:rxdart/rxdart.dart';

class CategoryService {
  final BehaviorSubject<List<Category>> topCategoryStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Category>> categoryStream =
      BehaviorSubject.seeded([]);
  final BehaviorSubject<Subcategory> activeSubcategoryStream =
      BehaviorSubject.seeded(null);
  final BehaviorSubject<Category> activeTopCategoryStream =
      BehaviorSubject.seeded(null);
  final BehaviorSubject<Category> activeCategoryStream =
      BehaviorSubject.seeded(null);

  CategoryService() {
    _fetchTopCategories().listen(topCategoryStream.add);

    getActiveCategory().then((activeCategory) {
      activeCategoryStream.add(activeCategory);
    });
    activeTopCategoryStream.listen((activeTopCategory) =>
        _fetchCategories(activeTopCategory).then(categoryStream.add));
  }

  Future<Category> getActiveTopCategory() => _defaultActiveTopCategory;

  Future<Category> getActiveCategory() => _defaultActiveCategory;

  setActiveTopCategory(Category category) =>
      activeTopCategoryStream.add(category);

  setActiveCategory(Category category) => activeCategoryStream.add(category);

  setActiveSubcategory(Subcategory subcategory) =>
      activeSubcategoryStream.add(subcategory);

  Future<Category> get _defaultActiveTopCategory async {
    final first = await categoryStream.first;
    final category = first.firstWhere(
        (category) => category.name.toLowerCase().contains('street'),
        orElse: () => null);
    if (category != null) {
      return category;
    } else {
      return topCategoryStream.first
          .then((value) => value.isNotEmpty ? value.first : null);
    }
  }

  Future<Category> get _defaultActiveCategory async {
    final first = await categoryStream.first;
    final category = first.firstWhere(
        (category) => category.name.toLowerCase().contains('drinking'),
        orElse: () => null);
    if (category != null) {
      return category;
    } else {
      return categoryStream.first
          .then((value) => value.isNotEmpty ? value.first : null);
    }
  }

  Future<List<Category>> _fetchCategories(Category topCategory) async {
    if (topCategory == null) {
      return Future.value([]);
    }

    if (topCategory.childrenCategories != null) {
      List<DocumentSnapshot> subCategoryDocuments = await Future.wait(
          topCategory.childrenCategories?.map((reference) => reference.get()));
      return subCategoryDocuments
          .map((ds) => Category.fromDocument(ds))
          .toList()
            ..sort();
    } else {
      return [];
    }
  }

  Future<List<Subcategory>> getSubcategoriesFromCategory(
      Category category) async {
    if (category?.childrenCategories != null) {
      final List<DocumentSnapshot> docs =
          await Future.wait(category.childrenCategories.map((e) => e.get()));
      return docs
          .map((document) => Subcategory.fromDocument(document))
          .toList();
    } else {
      return [];
    }
  }

  Stream<List<Category>> _fetchTopCategories() {
    return firestore
        .collection('categories')
        .where('level', isEqualTo: 'top')
        .snapshots()
        .map((qs) =>
            qs.docs.map((ds) => Category.fromDocument(ds)).toList()..sort());
  }

  void uid() {
    firestore.collection('type').get().then((qs) {
      qs.docs.forEach((ds) {
        var id = ds.id;
        firestore.collection('type').doc(id).update({
          'uid': id,
        });
      });
    });
  }

  Map<Category, List<Category>> categoriesCache = {};
}
