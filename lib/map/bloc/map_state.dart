part of 'map_bloc.dart';

class MapState extends Equatable {
  final Category activeCategory;
  final Category activeTopCategory;
  final Subcategory activeSubcategory;
  final List<Category> topCategories;
  final List<Category> categories;
  final bool isCardOpen;

  const MapState({
    @required this.activeTopCategory,
    @required this.activeCategory,
    @required this.topCategories,
    @required this.activeSubcategory,
    @required this.categories,
    @required this.isCardOpen,
  });

  @override
  List<Object> get props => [
        activeTopCategory,
        activeCategory,
        activeSubcategory,
        topCategories,
        categories,
        isCardOpen,
      ];

  MapState copyWith({
    Category activeTopCategory,
    Category activeCategory,
    Subcategory activeSubcategory,
    List<Category> topCategories,
    List<Category> categories,
    bool isCardOpen,
  }) {
    return MapState(
      activeTopCategory: activeTopCategory ?? this.activeTopCategory,
      activeCategory: activeCategory ?? this.activeCategory,
      activeSubcategory: activeSubcategory ?? this.activeSubcategory,
      topCategories: topCategories ?? this.topCategories,
      categories: categories ?? this.categories,
      isCardOpen: isCardOpen ?? this.isCardOpen,
    );
  }

  MapState setAsNull({
    bool activeTopCategory = false,
    bool activeCategory = false,
    bool activeSubcategory = false,
  }) {
    return MapState(
      activeTopCategory: activeTopCategory ? null : this.activeTopCategory,
      activeCategory: activeCategory ? null : this.activeCategory,
      activeSubcategory: activeSubcategory ? null : this.activeSubcategory,
      topCategories: topCategories,
      categories: categories,
      isCardOpen: isCardOpen,
    );
  }
}

class MapInitial extends MapState {
  MapInitial()
      : super(
          topCategories: [],
          categories: [],
          activeTopCategory: null,
          activeCategory: null,
          activeSubcategory: null,
          isCardOpen: false,
        );

  @override
  List<Object> get props => [
        activeTopCategory,
        activeCategory,
        activeSubcategory,
        topCategories,
        categories,
        isCardOpen,
      ];
}
