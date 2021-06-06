import 'package:flutter/material.dart';
import 'admob_service.dart';
import 'home_page.dart';
import 'native_inline_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdmobService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativeInlinePage(),
    );
  }
}
