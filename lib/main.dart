import 'package:flutter/material.dart';
import 'package:lab_2/utils/go_router_init.dart';
import 'package:lab_2/injection.dart' as di;
import 'common/theme.dart';
void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: lightTheme,
      routerConfig: router,
    );
  }
}
