import 'dart:js_interop';

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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return players.isDefinedAndNotNull
        ? ListView.separated(
            shrinkWrap: true,
            itemCount: players!.length,
            itemBuilder: (_, index) => GestureDetector(
              onTap: () => {onTapGestureDetector!(players![index].id)},
              child: CustomListCardWidget(
                  player: players![index],
                  isSelected: isIdSelected(players![index].id)),
            ),
            separatorBuilder: (context, index) {
              return const Divider(
                height: 16,
              );
            },
          )
        : Container(
            padding: const EdgeInsets.all(20),
            child: Lottie.asset("assets/ball.json"),
          );
  }

  bool isIdSelected(String id) {
    return selectedIds.isNotEmpty ? selectedIds.contains(id) : false;
  }
}
