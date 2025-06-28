import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'App Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Introduction
            const Center(
              child: Text(
                "Welcome to the 'To-Do Now' App!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "'To-Do Now' is a simple and user-friendly to-do list app designed for everyone. With a clean layout, minimal pages, and customizable themes, it is easy to use whether you are a student, teacher, worker, or anyone needing to stay organized. Features include:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Clean and minimal interface  '),
                  Text('• Task sorting and completion  '),
                  Text('• Customizable themes'),
                  Text('• Easy task management'),
                  Text('• Local device storage only'),
                ],
              ),
            ),
            const Divider(height: 40),

            // Terms Section
            const Text(
              'Terms of Use',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Last Updated: July 1, 2025',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'By using To-Do Now, you agree that:\n'
              '- You are at least 13 years old\n'
              '- You will use the app lawfully\n'
              '- All data is stored only on your device\n'
              '- You maintain responsibility for your data\n'
              '- The app comes with no warranties',
              style: TextStyle(fontSize: 14),
            ),
            const Divider(height: 40),

            // Privacy Section
            const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Last Updated: July 1, 2025',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'We respect your privacy:\n'
              '- No data is collected or shared\n'
              '- All tasks stay on your device\n'
              '- No analytics or tracking\n'
              '- No special permissions required\n'
              '- Uninstalling removes all data',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact: idrissilhan@gmail.com',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}