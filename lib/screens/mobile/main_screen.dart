import 'package:flutter/material.dart';
import 'package:pbn_flutter/utils/dependencyinjection.utils.dart';
import 'package:pbn_flutter/widgets/custom_list_players_widget.dart';

class MainMobileScreen extends StatelessWidget {
  MainMobileScreen({super.key}) {
    DependencyInjection.setupMobile();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomListPlayersWidget();
  }
}
