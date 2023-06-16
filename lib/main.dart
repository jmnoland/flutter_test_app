import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/home/home_page.dart';
import 'state_object.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var routes = <String, Widget>{};

    return ChangeNotifierProvider(
        create: (context) => StateObject(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(title: 'Flutter Demo Home Page'),
          routes: Map.from(routes),
        ));
  }
}
