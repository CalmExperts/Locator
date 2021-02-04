part of create_card;

class CategoryCardView extends StatefulWidget {
  final ValueChanged<Category> onCategoryChosen;

  const CategoryCardView({Key key, @required this.onCategoryChosen})
      : super(key: key);

  @override
  CategoryCardViewState createState() => CategoryCardViewState();
}

class CategoryCardViewState extends State<CategoryCardView> {
  ScrollController scrollController;
  bool drawerIsCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: <Widget>[
              Text(
                Locs.of(context).moreDetails,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
        BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                NotificationListener<CategoryBarStateNotification>(
                  onNotification: (categoryBarStateNotification) {
                    drawerIsCollapsed =
                        categoryBarStateNotification.isCollapsed;
                    return true;
                  },
                  // TODO fix subcategory animation
                  child: Flexible(
                    flex: state.activeCategory != null ? 0 : 2,
                    fit: FlexFit.loose,
                    child: CategoryBar.fromMapState(
                      mapState: state,
                      scrollDirection: Axis.horizontal,
                      initialState: _getInitialState(
                        activeTopCategory: state.activeTopCategory,
                        activeCategory: state.activeCategory,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                if (state.activeCategory != null)
                  Expanded(
                    child: SubcategoryScrollView(
                      category: state.activeCategory,
                      isExpanded: state.activeSubcategory == null,
                      subcategoryWhenCollapsed: state.activeSubcategory,
                      onSubcategorySelected: (Subcategory subcategory) {
                        MapBloc mapBloc = MapBloc.of(context);
                        if (state.activeSubcategory != null) {
                          mapBloc.add(SetActiveSubcategory(null));
                        } else {
                          mapBloc.add(SetActiveSubcategory(subcategory));
                        }
                      },
                    ),
                  )
              ],
            );
          },
        ),
      ],
    );
  }

  CategoryBarStep _getInitialState({
    @required Category activeTopCategory,
    @required Category activeCategory,
  }) {
    if (activeTopCategory == null) {
      return CategoryBarStep.openTopCategory;
    }
    if (activeCategory == null) {
      return CategoryBarStep.openCategory;
    }
    return CategoryBarStep.closedTopCategoryAndCategory;
  }

//      };
//    );

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }
}
