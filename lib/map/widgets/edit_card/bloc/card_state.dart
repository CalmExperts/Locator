part of card_bloc;

@immutable
class CardState {
  final Drop drop;
  final EditDropCardPage activeEditDropCardPage;

  const CardState({
    @required this.drop,
    @required this.activeEditDropCardPage,
  });

  CardState.initial()
      : drop = Drop(),
        activeEditDropCardPage = EditDropCardPage.category;

  Category get dropCategory => drop.category;

  CardState copyWith({
    Drop drop,
    Category dropCategory,
    EditDropCardPage activeEditDropCardPage,
  }) {
    return CardState(
      drop: drop ?? this.drop,
      activeEditDropCardPage:
          activeEditDropCardPage ?? this.activeEditDropCardPage,
    );
  }

  bool get isAtLastPage =>
      activeEditDropCardPage == EditDropCardPage.values.last;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardState &&
          runtimeType == other.runtimeType &&
          drop == other.drop &&
          dropCategory == other.dropCategory &&
          activeEditDropCardPage == other.activeEditDropCardPage;

  @override
  int get hashCode =>
      drop.hashCode ^ dropCategory.hashCode ^ activeEditDropCardPage.hashCode;
}
