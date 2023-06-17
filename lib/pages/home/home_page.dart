import 'package:flutter/material.dart';
import 'package:flutter_test_app/injection.dart';
import 'package:flutter_test_app/models/entities/user.dart';
import 'package:flutter_test_app/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dataService = getIt.get<DataService>();
  final List<User> _users = List.empty(growable: true);

  void getUserData() async {
    var response = await _dataService.getUsers();
    setState(() {
      for (var user in response) {
        _users.add(user);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var user in _users)
              Row(
                children: [
                  Text(user.email),
                  const Text(" "),
                  Text(user.password)
                ],
              )
          ],
        ),
      ),
    );
  }
}
