import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/*
Privacy Policy

To-Do Now does not collect, store, or share any personal information. All your tasks and data are stored locally on your device and are not transmitted to any external server.

We do not use third-party analytics, advertising, or tracking tools.

If you uninstall the app, all your data will be deleted from your device permanently.

If you have any questions or concerns, feel free to contact us.

*/