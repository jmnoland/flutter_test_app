import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test_app/state_object.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key, required this.title});

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _showPassword = false;

  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      final String email = _emailController.text.toLowerCase();
      _emailController.value = _emailController.value.copyWith(
        text: email,
        composing: TextRange.empty,
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<StateObject>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
                        labelText: 'Passowrd',
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
        onPressed: () {},
        tooltip: 'Submit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
