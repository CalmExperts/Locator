import 'package:flutter/material.dart';

class PointsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.yellow,
          ),
          CircleAvatar(
            backgroundColor: Colors.yellow,
          ),
          CircleAvatar(
            backgroundColor: Colors.yellow,
          ),
          CircleAvatar(
            backgroundColor: Colors.yellow,
          ),
          CircleAvatar(
            backgroundColor: Colors.yellow,
          ),
          CircleAvatar(
            backgroundColor: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
