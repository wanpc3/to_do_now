import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sort_provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  String _getColorName(Color color) {
    if (color == Colors.red || color == Colors.red[400]) return "Red";
    if (color == Colors.red[100]) return "Light Red";
    if (color == Colors.amber || color == Colors.amber[400]) return "Yellow";
    if (color == Colors.yellow[100]) return "Light Yellow";
    if (color == Colors.blue || color == Colors.blue[400]) return "Blue";
    if (color == Colors.blue[100]) return "Light Blue";
    if (color == Colors.green || color == Colors.green[400]) return "Green";
    if (color == Colors.green[100]) return "Light Green";
    if (color == Colors.purple || color == Colors.purple[400]) return "Purple";
    if (color == Colors.purple[100]) return "Light Purple";
    if (color == Colors.white) return "White";
    return "Custom";
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final sortProvider = Provider.of<SortProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                leading: const Icon(Icons.sort),
                title: const Text('Sort by'),
                trailing: DropdownButton<String>(
                  value: sortProvider.sortMode,
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'Recently Added', child: Text('Recently Added')),
                    DropdownMenuItem(value: 'Title (A-Z)', child: Text('Title (A-Z)')),
                    DropdownMenuItem(value: 'Last Updated', child: Text('Last Updated')),
                  ],
                  onChanged: (value) {
                    if (value != null) sortProvider.setSortMode(value);
                  },
                ),
              ),

              //Show Alert Message
              ListTile(
                leading: const Icon(Icons.notifications_active_outlined),
                title: const Text('Show Alert Messages'),
                subtitle: const Text('Control whether the app shows brief alerts when you perform actions.'),
                trailing: Switch(
                  value: themeProvider.showAlerts,
                  onChanged: themeProvider.toggleAlerts,
                ),
              ),

              //Dark Mode
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: themeProvider.toggleDarkMode,
                ),
                onTap: () => themeProvider.toggleDarkMode(!themeProvider.isDarkMode),
              ),

              //Custom Theme
              ListTile(
                leading: const Icon(Icons.color_lens_outlined),
                title: const Text('Custom Theme'),
                trailing: Switch(
                  value: themeProvider.useCustomTheme,
                  onChanged: themeProvider.toggleCustomTheme,
                ),
              ),
            ]),
          ),

          if (themeProvider.useCustomTheme)
            ...[

              //Appbar's Color
              _buildColorSelector(
                context,
                icon: Icons.format_paint_outlined,
                label: "Appbar's Color",
                value: themeProvider.appBarColor,
                options: ThemeProvider.appBarColors,
                onChanged: themeProvider.setAppBarColor,
              ),

              //Bottom Navigation's Color
              _buildColorSelector(
                context,
                icon: Icons.view_sidebar_outlined,
                label: "Bottom Navigation's Color",
                value: themeProvider.bottomNavigationColor,
                options: ThemeProvider.componentColors,
                onChanged: themeProvider.setBottomNavigationColor,
              ),

              //Background's Color
              _buildColorSelector(
                context,
                icon: Icons.wallpaper_outlined,
                label: "Background's Color",
                value: themeProvider.backgroundColor,
                options: ThemeProvider.backgroundColors,
                onChanged: themeProvider.setBackgroundColor,
              ),

              //Card's Color
              _buildColorSelector(
                context,
                icon: Icons.rectangle_outlined,
                label: "Card's Color",
                value: themeProvider.cardColor,
                options: ThemeProvider.backgroundColors,
                onChanged: themeProvider.setCardColor,
              ),
            ],
        ],
      ),
    );
  }

  Widget _buildColorSelector(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color value,
    required List<Color> options,
    required ValueChanged<Color> onChanged,
  }) {
    return SliverToBoxAdapter(
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        trailing: DropdownButton<Color>(
          value: options.contains(value) ? value : null,
          underline: const SizedBox(),
          items: options.map((color) {
            return DropdownMenuItem(
              value: color,
              child: Row(
                children: [
                  Container(width: 20, height: 20, color: color),
                  const SizedBox(width: 8),
                  Text(_getColorName(color)),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ),
    );
  }
}
