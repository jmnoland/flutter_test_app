import 'package:flutter/material.dart';
import 'package:flutter_test_app/pages/home/home_page.dart';
import 'package:flutter_test_app/pages/login/biometric_page.dart';
import 'package:flutter_test_app/pages/login/login_page.dart';
import 'package:flutter_test_app/pages/splash/splash_page.dart';
import 'package:flutter_test_app/services/data_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test_app/injection.dart';
import 'package:flutter_test_app/pages/signup/sign_up_page.dart';
import 'state_object.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  getIt.registerSingleton(DataService());
  var db = getIt.get<DataService>();
  await db.openLocalDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => StateObject(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routes: {
            '/': (context) => const SplashPage(),
            '/signup': (context) => const SignUpPage(),
            '/login': (context) => const LoginPage(),
            '/home': (context) => const HomePage(),
            '/biometric': (context) => const BiometricPage(),
          },
        ));
  }
}
