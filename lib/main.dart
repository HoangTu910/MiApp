import 'package:flutter/material.dart';
import 'package:miapp/config/route/route.dart';

class MiApp extends StatefulWidget {
  const MiApp({super.key});

  @override
  State<MiApp> createState() => _MiAppState();
}

class _MiAppState extends State<MiApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(debugShowCheckedModeBanner: false, routerConfig: AppRoute.router);
  }
}

void main() {
  runApp(const MiApp());
}