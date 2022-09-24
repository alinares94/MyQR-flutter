import 'package:flutter/material.dart';
import 'package:my_qr/pages/pages.dart';
import 'package:my_qr/providers/providers.dart';
import 'package:my_qr/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My QR'),
        actions: [
          IconButton(onPressed: () async {
            const url = 'https://www.privacypolicies.com/live/17c71511-deba-4b6e-abb5-ac51c9681677';
            if(!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
              throw 'Coult not launch $url';
            }
          }, icon: const Icon(Icons.help))
        ],
      ),
      body: const _BodyWidget(),
      bottomNavigationBar: const BottomNavWidget(),
      floatingActionButton: const ScanButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Provider.of<ScanProvider>(context, listen: false).loadScans();
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedPage;

    switch (currentIndex) {
      case 0:
        return const ListScanPage();
      case 1:
        return const SettingsPage();
      default:
        return const ListScanPage();
    }
  }
}