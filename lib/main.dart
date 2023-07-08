import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pbn_flutter/screens/mobile/main_screen.dart';
import 'package:pbn_flutter/screens/web/main_web_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  if (kIsWeb) {
    // running on the web!
  } else {
    await dotenv.load();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PBN',
      theme: ThemeData.dark(),
      home: determineHomePage(),
    );
  }

  Widget determineHomePage() {
    if (kIsWeb) {
      return const MainWebScreen();
    } else {
      return const MainMobileScreen();
    }
  }
}
