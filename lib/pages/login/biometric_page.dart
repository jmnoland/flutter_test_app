import 'package:flutter/material.dart';
import 'package:flutter_test_app/injection.dart';
import 'package:flutter_test_app/services/data_service.dart';
import 'package:local_auth/local_auth.dart';

class BiometricPage extends StatefulWidget {
  const BiometricPage({super.key});

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  final DataService _dataService = getIt.get<DataService>();
  final LocalAuthentication _localAuth = LocalAuthentication();

  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  Future<void> checkBiometricType() async {
    final availableBiometrics = await _localAuth.getAvailableBiometrics();
    if (await attemptBiometricAuth()) {
      navigateToHome();
    }
  }

  Future<bool> attemptBiometricAuth() async {
    return await _localAuth.authenticate(
      localizedReason: "Scan fingerprint to authenticate",
      options: const AuthenticationOptions(
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true,
      ),
    );
  }

  @override
  void initState() {
    checkBiometricType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Biometric page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Biometric',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToHome();
        },
        tooltip: 'Biometric',
        child: const Icon(Icons.skip_next),
      ),
    );
  }
}
