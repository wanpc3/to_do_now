import 'package:flutter/material.dart';
import 'appearance.dart';
import 'terms_and_conditions.dart';
import 'privacy_policy.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          //Appearance
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: Icon(Icons.dark_mode_outlined),
                title: const Text('Appearance'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Appearance()
                    ),
                  );
                },
              ),
              childCount: 1,
            ),
          ),

          //Notifications
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: Icon(Icons.notification_important_outlined),
                title: const Text('Notifications'),
                onTap: () {
                  
                },
              ),
              childCount: 1,
            ),
          ),

          //Privacy Policy
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: Icon(Icons.policy_outlined),
                title: const Text('Privacy Policy'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PrivacyPolicy(),
                    ),
                  );
                },
              ),
              childCount: 1,
            ),
          ),

          //Terms and Conditions
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: Icon(Icons.notes_outlined),
                title: const Text('Terms and Conditions'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TermsAndConditions(),
                    ),
                  );
                },
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
