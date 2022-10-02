import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_qr/providers/providers.dart';
import 'package:my_qr/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ScanButtonWidget extends StatelessWidget {
  const ScanButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      elevation: 15,
      child: const Icon(Icons.qr_code, color: Colors.white),
      onPressed: () {
        // String res = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.BARCODE);
        Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRReaderWidget(),
            ));
      },
    );
  }
}

class QRReaderWidget extends StatefulWidget {
  const QRReaderWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRReaderWidgetState();
}

class _QRReaderWidgetState extends State<QRReaderWidget> {
  Barcode? result;
  int readingCount = 0;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton(onPressed: () {
               Navigator.of(context).pop();
            }, child: Text('Cancelar')),
          )
        ]
      )
    );
  }

  Widget _buildQrView(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var scanArea = min(width, height) * .85;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppTheme.primary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    readingCount = 0;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;
      readingCount++;
      if (result?.code == null || readingCount > 1) {
        return;
      }
      final resultString = result!.code!;
      
      await Provider.of<ScanProvider>(context, listen: false).addScan(resultString);
      Navigator.of(context).pop();
      if(!await launchUrlString(resultString, mode: LaunchMode.externalApplication)) {
            throw 'Coult not launch $resultString';
      };
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}