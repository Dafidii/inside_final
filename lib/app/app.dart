import 'package:flutter/material.dart';
import 'package:inside_1/app/constants.dart';
import 'package:inside_1/app/di.dart';
import 'package:inside_1/domain/provider/auth_provider.dart';
import 'package:inside_1/domain/provider/connectivity.dart';
import 'package:inside_1/presentation/resources/route_manager.dart';
import 'package:inside_1/presentation/resources/theme_manager.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal ();

  static const instances = MyApp._internal();

  factory MyApp() => instances;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: instance<AuthState>()),
        ChangeNotifierProvider.value(value: instance<ConnectivityState>()),
      ],
      child: MaterialApp.router(
        scaffoldMessengerKey: scaffoldKey,
        debugShowCheckedModeBanner: false,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
        routerDelegate: router.routerDelegate,
        theme: getApplicationTheme(),
        builder: (BuildContext context, Widget? child){
          return child!;
        },

      ),
    );
  }
}
