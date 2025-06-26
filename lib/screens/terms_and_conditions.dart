import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/*
Terms and Conditions

By using To-Do Now, you agree to use the app for personal task management only. We are not responsible for any data loss, including if the app is uninstalled or your device is damaged.

This app is provided "as is" without warranty of any kind. We may update the app and these terms at any time.

You agree not to use the app for illegal or harmful activities.

*/