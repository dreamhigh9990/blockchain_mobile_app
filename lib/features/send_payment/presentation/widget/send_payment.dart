import 'dart:developer';

import 'package:blockchain_mobile_app/features/send_payment/presentation/widget/qr_scan.dart';
import 'package:blockchain_mobile_app/features/send_payment/presentation/widget/send_to_pay.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:flutter/material.dart';

class SendPayment extends StatefulWidget {
  const SendPayment({super.key});

  @override
  State<SendPayment> createState() => _SendPaymentState();
}

class _SendPaymentState extends State<SendPayment> {
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Pay',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              // fontFamily: 'Jumper PERSONAL USE ONLY',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 15,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingAndProfile()));
              },
              child: Image.asset("assets/images/setting.png"),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: QrCodeWiget(onQrCodeScanned: (value) {
                      log(value);
                    }),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     //     Navigator.push(
                  //     // context,
                  //     // MaterialPageRoute(builder: (context) => QRScannerScreen(qrKey)),

                  //     // );
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => QrCodeWiget(
                  //         onQrCodeScanned: (String) {},
                  //       ),
                  //     ));
                  //   },
                  //   child: Container(
                  //     width: 70,
                  //     height: 54,
                  //     decoration: ShapeDecoration(
                  //       gradient: const LinearGradient(
                  //         begin: Alignment(0.00, -1.00),
                  //         end: Alignment(0, 1),
                  //         colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(6)),
                  //     ),
                  //     // ignore: prefer_const_constructors
                  //     child: Center(
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Icon(Icons.qr_code_scanner, color: Colors.white),
                  //             // Spacer(),
                  //             Text(
                  //               'Scan',
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 12,
                  //                 // fontFamily: 'Lato',
                  //                 fontWeight: FontWeight.w600,
                  //                 height: 0,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SendToPayScreen()));
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      // ignore: prefer_const_constructors
                      child: Center(
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(Icons.send, color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  // fontFamily: 'Lato',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("  Transection history")),
              const SizedBox(
                height: 10,
              ),
              items.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('No Transection history available'),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          Color tileColor = index % 2 == 0
                              ? const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.2)
                              : const Color.fromARGB(255, 45, 0, 42)
                                  .withOpacity(0.4);
                          return ListTile(
                            tileColor: tileColor,
                            title: Text(items[index]),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
