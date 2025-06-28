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

          //Enable/Disable Alerts
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: Icon(Icons.notifications_active_outlined),
                title: const Text('Show Alert Messages'),
                subtitle: const Text('Control whether the app shows brief alerts when you perform actions.'),
                trailing: Switch(
                  value: themeProvider.showAlerts,
                  onChanged: (value) {
                    themeProvider.toggleAlerts(value);
                  },
                ),
              ),
              childCount: 1,
            ),
          ),

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

          //Custom Theme Toggle
          SliverToBoxAdapter(
            child: ListTile(
              leading: Icon(Icons.color_lens_outlined),
              title: const Text('Custom Theme'),
              trailing: Switch(
                value: themeProvider.useCustomTheme,
                onChanged: (value) {
                  themeProvider.toggleCustomTheme(value);
                },
              ),
            ),
          ),

            //Appbar's Color
            if (themeProvider.useCustomTheme)
            SliverToBoxAdapter(
              child: ListTile(
                leading: Icon(Icons.format_color_fill_outlined),
                title: const Text("Appbar's Color"),
                trailing: DropdownButton<Color>(
                  value: themeProvider.appBarColor,
                  underline: SizedBox(),
                  items: [

                    //Red
                    DropdownMenuItem(
                      value: Colors.red,
                      child: const Text("Red"),
                    ),

                    //Yellow
                    DropdownMenuItem(
                      value: Colors.amber,
                      child: const Text("Yellow"),
                    ),

                    //Blue
                    DropdownMenuItem(
                      value: Colors.blue,
                      child: const Text("Blue"),
                    ),

                    //Green
                    DropdownMenuItem(
                      value: Colors.green,
                      child: const Text("Green"),
                    ),

                    //Purple
                    DropdownMenuItem(
                      value: Colors.purple,
                      child: const Text("Purple"),
                    ),

                    //White
                    DropdownMenuItem(
                      value: Colors.white,
                      child: const Text('White'),
                    ),

                  ],
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.setAppBarColor(value);
                    }
                  },
                ),
              ),
            ),

            //Bottom Navigation's Color
            if (themeProvider.useCustomTheme)
            SliverToBoxAdapter(
              child: ListTile(
                leading: Icon(Icons.color_lens_outlined),
                title: const Text("Bottom Navigation's Color"),
                trailing: DropdownButton<Color>(
                  value: themeProvider.bottomNavigationColor,
                  underline: SizedBox(),
                  items: [

                    //Red
                    DropdownMenuItem(
                      value: Colors.red[400],
                      child: const Text("Red"),
                    ),

                    //Yellow
                    DropdownMenuItem(
                      value: Colors.amber[400],
                      child: const Text("Yellow"),
                    ),

                    //Blue
                    DropdownMenuItem(
                      value: Colors.blue[400],
                      child: const Text("Blue"),
                    ),

                    //Green
                    DropdownMenuItem(
                      value: Colors.green[400],
                      child: const Text("Green"),
                    ),

                    //Purple
                    DropdownMenuItem(
                      value: Colors.purple[400],
                      child: const Text("Purple"),
                    ),

                    //White
                    DropdownMenuItem(
                      value: Colors.white,
                      child: const Text('White'),
                    ),

                  ],
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.setBottomNavigationColor(value);
                    }
                  },
                ),
              ),
            ),


            //Background's Color
            if (themeProvider.useCustomTheme)
            SliverToBoxAdapter(
              child: ListTile(
                leading: Icon(Icons.border_color_outlined),
                title: const Text("Background's Color"),
                trailing: DropdownButton<Color>(
                  value: themeProvider.backgroundColor,
                  underline: SizedBox(),
                  items: [

                    //Red
                    DropdownMenuItem(
                      value: Colors.red[100],
                      child: const Text("Red"),
                    ),

                    //Yellow
                    DropdownMenuItem(
                      value: Colors.yellow[100],
                      child: const Text("Yellow"),
                    ),

                    //Blue
                    DropdownMenuItem(
                      value: Colors.blue[100],
                      child: const Text("Blue"),
                    ),

                    //Green
                    DropdownMenuItem(
                      value: Colors.green[100],
                      child: const Text("Green"),
                    ),

                    //Purple
                    DropdownMenuItem(
                      value: Colors.purple[100],
                      child: const Text("Purple"),
                    ),

                    //White
                    DropdownMenuItem(
                      value: Colors.white,
                      child: const Text('White'),
                    ),

                  ],
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.setBackgroundColor(value);
                    }
                  },
                ),
              ),
            ),

          //Card's background color
          if (themeProvider.useCustomTheme)
            SliverToBoxAdapter(
              child: ListTile(
                leading: Icon(Icons.crop_square_outlined),
                title: const Text("Card's Color"),
                trailing: DropdownButton<Color>(
                  value: themeProvider.cardColor,
                  underline: SizedBox(),
                  items: [

                    //Light Red
                    DropdownMenuItem(
                      value: Colors.red[100],
                      child: const Text("Red"),
                    ),

                    //Light Yellow
                    DropdownMenuItem(
                      value: Colors.yellow[100],
                      child: const Text("Yellow"),
                    ),

                    //Light Blue
                    DropdownMenuItem(
                      value: Colors.blue[100],
                      child: const Text("Blue"),
                    ),

                    //Light Green
                    DropdownMenuItem(
                      value: Colors.green[100],
                      child: const Text("Green"),
                    ),

                    //Light Purple
                    DropdownMenuItem(
                      value: Colors.purple[100],
                      child: const Text("Purple"),
                    ),

                    //White
                    DropdownMenuItem(
                      value: Colors.white,
                      child: const Text('White'),
                    ),

                  ],
                  onChanged: (value) {
                    if (value != null) {
                      themeProvider.setCardColor(value);
                    }
                  },
                ),
              ),
            ),

        ],
      ),
    );
  }
}
