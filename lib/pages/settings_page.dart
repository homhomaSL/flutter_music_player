import 'package:flutter/material.dart';
import 'package:flutter_music_player/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S E T T I N G S'),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark Mode',
              style: TextStyle(fontSize: 15),
            ),
            Switch(
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
              onChanged: (value) => {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(),
              },
            ),
          ],
        ),
      ),
    );
  }
}
