import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrCodeWiget extends StatefulWidget {
  final Function(String) onQrCodeScanned;

  const QrCodeWiget({Key? key, required this.onQrCodeScanned})
      : super(key: key);

  @override
  State<QrCodeWiget> createState() => _QrCodeWigetState();
}

class _QrCodeWigetState extends State<QrCodeWiget> {
  String text = "";

  Future<void> onPressed() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          "#4B0082", "Cancel", true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        text = qrCode.toString();
      });

      // Call the callback function with the scanned QR code value
      widget.onQrCodeScanned(text);
    } catch (e) {
      print("Error ::: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          color: Colors.white,
          onPressed: onPressed,
          icon: Icon(Icons.qr_code),
        ),
        Text("Scan")
      ],
    );
  }
}