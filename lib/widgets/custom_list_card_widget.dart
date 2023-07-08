import 'package:flutter/material.dart';
import 'package:pbn_flutter/models/player.dart';

class CustomListCardWidget extends StatelessWidget {
  final Player player;
  final bool isSelected;

  const CustomListCardWidget({
    Key? key,
    required this.player,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 120,
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.black54,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey[50]!.withOpacity(0.6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              player.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              player.score.toStringAsFixed(2),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
