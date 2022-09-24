import 'package:flutter/material.dart';
import 'package:my_qr/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {

    final prefProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, top: 20),
          child: Text(
            'Opciones', 
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        SwitchListTile.adaptive(
          value: PreferencesProvider.isDarkMode,
          title: const Text('Modo oscuro'),
          onChanged: (value) {
            value ? prefProvider.setDarkTheme() : prefProvider.setLightTheme();
            PreferencesProvider.isDarkMode = value;
            setState(() {});
        }),
        Expanded(
          child: Lottie.asset('assets/lottie_settings.json')
        )
      ],
    );
  }
}