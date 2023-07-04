import 'package:flutter/material.dart';

import '../models/player.dart';

class CustomListCardWidget extends StatelessWidget {
  final Player player;
  final bool isSelected;

  const CustomListCardWidget(
      {Key? key, required this.player, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.black54,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey[50]!.withOpacity(0.6))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  player.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "   -   ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  player.score.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
