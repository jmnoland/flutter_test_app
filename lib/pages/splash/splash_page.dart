import 'package:flutter/material.dart';
import 'package:flutter_test_app/injection.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test_app/services/data_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _dataService = getIt.get<DataService>();

  void navigateToSignIn() {
    Navigator.pushNamed(context, '/signup');
  }

  void navigateToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  void checkLogin() async {
    var users = await _dataService.getUsers();
    if (users.isEmpty) {
      navigateToSignIn();
    }
    navigateToLogin();
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => checkLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Splash page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You are on the splash page',
            ),
          ],
        ),
      ),
    );
  }
}
