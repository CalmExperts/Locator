part of card_bloc;

abstract class CardEvent extends Event {
  CardEvent();
}

class SelectCategoryEvent extends CardEvent {
  final Category category;

  SelectCategoryEvent(this.category);
}

class UpdateDrop extends CardEvent {
  final Category topCategory;
  final Category category;
  final Subcategory subcategory;
  final Coordinates coordinates;

  // a user generated comment on where the object is located, e.g. 'next to the
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
  final String availabilityDescription;

  final bool isDraft;
  final Map tags;

  UpdateDrop({
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
    this.availabilityDescription,
    this.isDraft, // from user, on create
    this.tags,
  });
}

class SetDrop extends CardEvent {
  final Drop drop;

  SetDrop(this.drop);
}

class SaveDrop extends CardEvent {}

class UpdateEditDropCardPage extends CardEvent {
  final EditDropCardPage page;

  UpdateEditDropCardPage(this.page);
}

class Reset extends CardEvent {}
