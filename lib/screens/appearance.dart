import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sort_provider.dart';
import 'theme_provider.dart';

class Appearance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final sortProvider = Provider.of<SortProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: CustomScrollView(
        slivers: [

          //Dark Mode
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: Icon(Icons.dark_mode_outlined),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleDarkMode(value);
                  },
                ),
                onTap: () {
                  themeProvider.toggleDarkMode(!isDarkMode);
                },
              ),
              childCount: 1,
            ),
          ),

          //Sort Card
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  leading: Icon(Icons.sort),
                  title: const Text('Sort by'),
                  trailing: DropdownButton<String>(
                    value: sortProvider.sortMode,
                    underline: SizedBox(),
                    items: [
                      DropdownMenuItem(
                        value: 'Recently Added',
                        child: const Text('Recently Added'),
                      ),
                      DropdownMenuItem(
                        value: 'Title (A-Z)',
                        child: const Text('Title (A-Z)'),
                      ),
                      DropdownMenuItem(
                        value: 'Last Updated',
                        child: const Text('Last Updated'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        sortProvider.setSortMode(value);
                      }
                    },
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
