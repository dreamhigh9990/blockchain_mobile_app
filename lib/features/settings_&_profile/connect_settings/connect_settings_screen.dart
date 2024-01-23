import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ConnectSettingScreen extends StatefulWidget {
  const ConnectSettingScreen({super.key});

  @override
  State<ConnectSettingScreen> createState() => _ConnectSettingScreen();
}

class _ConnectSettingScreen extends State<ConnectSettingScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isCameraOpen = false;

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        title: const Text(
          'Connect',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            // fontFamily: 'Jumper PERSONAL USE ONLY',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        actions: [
          Image.asset("assets/images/messenger2.png"),
          const SizedBox(
            width: 10,
          )
          // Image.asset("assets/images/settings.png")
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Center(
              child: Text(
                ' Wollito',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  // fontFamily: 'Jumper PERSONAL USE ONLY',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: Text(
                'connecting options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  // fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Wallet button press
                  },
                  child: Text('Wallet'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Super Node button press
                  },
                  child: Text('Super Node'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Market button press
                  },
                  child: Text('Market'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              width: 200,
              child: isCameraOpen
                  ? QRView(
                      key: qrKey,
                      onQRViewCreated: (QRViewController controller) {
                        this.controller = controller;
                        controller.scannedDataStream.listen((scanData) {
                          // Handle scanned data
                          print(scanData);
                        });
                      },
                    )
                  : Container(
                      width: 113,
                      height: 113,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/qr.PNG"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            // Buttons for opening QR code scanner and capturing a photo
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isCameraOpen = !isCameraOpen;
                });
              },
              child: Text(isCameraOpen ? 'Close Scanner' : 'Open Scanner'),
            ),
          ],
        ),
      ),
    );
  }
}
