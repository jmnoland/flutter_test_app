import 'package:flutter/material.dart';
import 'package:flutter_test_app/services/data_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test_app/injection.dart';
import 'package:flutter_test_app/pages/signup/sign_up_page.dart';
import 'state_object.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  getIt.registerSingleton(DataService());
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
          home: const SignUpPage(title: 'Flutter Demo Home Page'),
          routes: Map.from(routes),
        ));
  }
}
