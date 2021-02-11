import 'package:locator/map/models/model.dart';
import 'package:quiver/core.dart';

abstract class Mark implements Model {
  final String whoBy;
  final String drop;

  Mark(this.whoBy, this.drop);
}

class Like extends Mark {
  final String type;

  Like({
    String whoBy,
    String drop,
    this.type,
  })  : assert(type == 'like' || type == 'dislike'),
        super(whoBy, drop);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'whoBy': whoBy,
      'drop': drop,
    };
  }

  factory Like.fromJson(Map<String, dynamic> data) {
    return Like(
      whoBy: data['whoBy'],
      drop: data['drop'],
      type: data['type'],
    );
  }

  @override
  bool operator ==(other) {
    return other is Like &&
        other.drop == drop &&
        other.whoBy == whoBy &&
        other.type == type;
  }

  bool get isLike => type == 'like';

  bool get isDisLike => type == 'dislike';

  @override
  int get hashCode => hash3(drop, whoBy, type);
}

class ConditionMark extends Mark {
  ConditionMark(String whoBy, String drop) : super(whoBy, drop);

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    return null;
  }
}
