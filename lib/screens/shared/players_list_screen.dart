import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/widgets/custom_list_card_widget.dart';

class PlayerList extends StatelessWidget {
  final List<Player>? players;
  final Function(String id)? onTapGestureDetector;
  final List<String> selectedIds;

  const PlayerList({
    required this.players,
    this.onTapGestureDetector,
    required this.selectedIds,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return players != null && players!.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: players!.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () => onTapGestureDetector?.call(players![index].id),
              child: CustomListCardWidget(
                player: players![index],
                isSelected: isIdSelected(players![index].id),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(20),
            child: Lottie.asset("assets/ball.json"),
          );
  }

  bool isIdSelected(String id) {
    return selectedIds.contains(id);
  }
}
