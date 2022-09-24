import 'package:flutter/material.dart';
import 'package:my_qr/models/models.dart';
import 'package:my_qr/providers/providers.dart';
import 'package:my_qr/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ListScanPage extends StatelessWidget {
  const ListScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scanProvider = Provider.of<ScanProvider>(context);
    return ListView.builder(
      itemCount: scanProvider.scans.length,
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (DismissDirection direction) {
          scanProvider.deleteScanById(scanProvider.scans[index].id!);
        },
        background: const _DismissibleBackground(),
        child: _ListTile(scanModel: scanProvider.scans[index]),
      ));
  }
}

class _ListTile extends StatelessWidget {
  const _ListTile({Key? key, required this.scanModel}) : super(key: key);

  final ScanModel scanModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        if(!await launchUrlString(scanModel.value!, mode: LaunchMode.externalApplication)) {
          throw 'Coult not launch ${scanModel.value}';
        }
      },
      leading: const Icon(Icons.language, color: AppTheme.primary),
      title: Text(scanModel.value!),
      subtitle: Text('ID: ${scanModel.id}'),
      trailing: const Icon(Icons.keyboard_arrow_right, color: AppTheme.primary),
    );
  }
}

class _DismissibleBackground extends StatelessWidget {
  const _DismissibleBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        margin: const EdgeInsets.only(right: 35),
        child: const Icon(Icons.delete_outline)));
  }
}