import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_qr/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ScanButtonWidget extends StatelessWidget {
  const ScanButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final scanProvider = Provider.of<ScanProvider>(context, listen: false);

    return FloatingActionButton(
      elevation: 15,
      child: const Icon(Icons.qr_code, color: Colors.white),
      onPressed: () async {
        // String res = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);
        final res = 'https://google.com';

        if (res == '-1') {
          return;
        }

        await scanProvider.addScan(res);
        if(!await launchUrlString(res, mode: LaunchMode.externalApplication)) {
              throw 'Coult not launch $res';
        }
      },
    );
  }
}