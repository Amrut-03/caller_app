import 'package:caller_app/pages/homepage.dart';
import 'package:caller_app/widgets/infoCard.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayPopUp() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: Infocard()));
}
