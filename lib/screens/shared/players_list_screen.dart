import 'package:flutter/material.dart';
import 'package:pbn_flutter/models/player.dart';
import 'package:pbn_flutter/widgets/custom_list_card_widget.dart';

class PlayerList extends StatefulWidget {
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
  _PlayerListState createState() => _PlayerListState();
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.86, // Provide a height constraint
              child: Column(
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
                    Expanded(
                      child: ListView.separated(
                        itemCount: filteredPlayers.length,
                        itemBuilder: (_, index) {
                          final player = filteredPlayers[index];
                          return GestureDetector(
                            onTap: () =>
                                widget.onTapGestureDetector?.call(player.id),
                            child: CustomListCardWidget(
                              player: player,
                              isSelected: isIdSelected(player.id),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 16,
                          );
                        },
                      ),
                    )
                  else
                    Center(
                      child: Text('No players found'),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isIdSelected(String id) {
    return widget.selectedIds.contains(id);
  }
}
