import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:inside_1/app/app.dart';
import 'package:inside_1/app/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initAppModule();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  runApp(MyApp());
}
