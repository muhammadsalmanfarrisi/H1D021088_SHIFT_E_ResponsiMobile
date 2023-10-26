import 'package:flutter/material.dart';
import 'package:tokokita/helpers/user_info.dart';
import 'package:tokokita/ui/login_page.dart';
import 'package:tokokita/ui/ikan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IKAN',
      debugShowCheckedModeBanner: false,
      home: const IkanPage(), // Mengarahkan langsung ke halaman IkanPage
    );
  }
}
//kalau mau ran ketik ini di terminal, flutter run -d chrome --web-browser-flag "--disable-web-security"
