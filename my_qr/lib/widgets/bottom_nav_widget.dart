import 'package:flutter/material.dart';
import 'package:my_qr/providers/providers.dart';
import 'package:provider/provider.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedPage;
    
    return BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historial'),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Opciones'),
      ],
      currentIndex: currentIndex,
      onTap: (index) => uiProvider.selectedPage = index
    );
  }
}