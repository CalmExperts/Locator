part of create_card;

class ConditionCardView extends StatelessWidget {
  final double dropCondition;
  final ValueChanged<double> onChange;

  const ConditionCardView({
    Key key,
    @required this.dropCondition,
    @required this.onChange,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    var stars = List.generate(
        5,
        (int index) => Star(
              onPressed: () => onChange(index.toDouble()),
              index: index,
              pressed: index <= (dropCondition ?? -1),
            ));
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'How is the condition?',
            style: Theme.of(context).textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: stars,
            ),
          ),
        ],
      ),
    );
  }
}
