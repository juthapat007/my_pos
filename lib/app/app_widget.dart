import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Users App',
      routerConfig: Modular.routerConfig,
      debugShowCheckedModeBanner: false, //ซ่อนแบน debug
    );
  }
}
