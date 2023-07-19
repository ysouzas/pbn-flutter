import 'package:flutter/material.dart';
import 'package:pbn_flutter/widgets/custom_list_players_widget.dart';

class ListOfPlayerWeb extends StatefulWidget {
  const ListOfPlayerWeb({Key? key}) : super(key: key);

  @override
  State<ListOfPlayerWeb> createState() => _ListOfPlayerWebState();
}

class _ListOfPlayerWebState extends State<ListOfPlayerWeb> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomListPlayersWidget();
  }
}
