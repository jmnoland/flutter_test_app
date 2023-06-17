import 'package:flutter/material.dart';
import 'package:flutter_test_app/injection.dart';
import 'package:flutter_test_app/models/dtos/user.dart';
import 'package:flutter_test_app/services/data_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test_app/state_object.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _dataService = getIt.get<DataService>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  var _showPassword = false;

  void _toggleShowPassword() async {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void navigateToLogin() {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void register() async {
    if (_emailController.value.text.isEmpty ||
        !_emailController.value.text.contains('@')) {
      return;
    }
    if (_passwordController.value.text.isEmpty ||
        _passwordController.value.text.length < 6) {
      return;
    }
    if (_confirmPasswordController.value.text.isEmpty) {
      return;
    }
    if (_confirmPasswordController.value.text !=
        _passwordController.value.text) {
      return;
    }
    var userDto = UserDto();
    userDto.email = _emailController.text;
    userDto.password = _passwordController.text;
    await _dataService.insertUser(userDto);

    _emailController.clear();
    _passwordController.clear();
    navigateToLogin();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<StateObject>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sign in page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sign up',
            ),
            Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      enableSuggestions: false,
                      autocorrect: false,
                      enableIMEPersonalizedLearning: false,
                      decoration: const InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder()),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      enableIMEPersonalizedLearning: false,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            icon: Icon(_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              _toggleShowPassword();
                            }),
                      ),
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_showPassword,
                      enableSuggestions: false,
                      autocorrect: false,
                      enableIMEPersonalizedLearning: false,
                      decoration: InputDecoration(
                        labelText: 'Confirm passowrd',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                            icon: Icon(_showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              _toggleShowPassword();
                            }),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          register();
        },
        tooltip: 'Submit',
        child: const Icon(Icons.save),
      ),
    );
  }
}
