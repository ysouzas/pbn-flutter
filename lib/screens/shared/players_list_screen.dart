import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/widgets/custom_list_card_widget.dart';
import 'package:pbn_flutter/widgets/score_modal.dart';

class PlayerList extends StatefulWidget {
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
  State<PlayerList> createState() {
    return _PlayerListState();
  }
}

class _PlayerListState extends State<PlayerList> {
  late List<Player> filteredPlayers;

  @override
  void initState() {
    super.initState();
    filteredPlayers = widget.players ?? [];
  }

  void filterPlayers(String searchTerm) {
    setState(() {
      filteredPlayers = widget.players
              ?.where((player) =>
                  player.name.toLowerCase().contains(searchTerm.toLowerCase()))
              .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterPlayers,
              decoration: const InputDecoration(
                labelText: 'Search by name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          if (filteredPlayers.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredPlayers.length,
              itemBuilder: (_, index) {
                final player = filteredPlayers[index];
                return GestureDetector(
                  onTap: () => widget.onTapGestureDetector?.call(player.id),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          flex: 2,
                          onPressed: (context) {
                            showScoreModal(context, player.id);
                          },

                          backgroundColor: const Color(0xFF7BC043),
                          foregroundColor: Colors.white,
                          icon: Icons.archive,
                          label: 'Add Score',
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomListCardWidget(
                            player: player,
                            isSelected: isIdSelected(player.id),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 16,
                );
              },
            )
          else
            const Center(
              child: Text('No players found'),
            ),
        ],
      ),
    );
  }

  bool isIdSelected(String id) {
    return widget.selectedIds.contains(id);
  }

  void showScoreModal(BuildContext context, String playerId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ScoreModal(playerId: playerId);
      },
    );
  }
}
