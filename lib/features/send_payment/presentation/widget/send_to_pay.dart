import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:flutter/material.dart';

class SendToPayScreen extends StatefulWidget {
  const SendToPayScreen({super.key});

  @override
  State<SendToPayScreen> createState() => _SendToPayScreenState();
}

class _SendToPayScreenState extends State<SendToPayScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'Send to pay',
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
                child: Image.asset("assets/images/setting.png")),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Text(
                  "Send crypto to your contacts",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const Center(
                  child: Padding(
                padding:
                    EdgeInsets.only(left: 8.0, right: 8.0, bottom: 15, top: 25),
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  autocorrect: true,
                  decoration:
                      InputDecoration(hintText: '  Enter Wallet Address'),
                ),
              )),
              const SizedBox(
                height: 33,
              ),
              InkWell(
                onTap: () => successDialog(context),
                child: Container(
                  width: 350,
                  height: 54,
                  decoration: ShapeDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                    ),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  // ignore: prefer_const_constructors
                  child: Center(
                      child: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      // fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> successDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // icon: Image.asset('assets/images/quality.png'),
          backgroundColor: const Color(0xff161828),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                  'assets/images/quality.png'), // Replace with your image asset
              const Text(
                textAlign: TextAlign.center,
                'CONGRATULATIONS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),

              const Text("Sent successfully"),
              const SizedBox(height: 20),

              const Text(
                "",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff9963B7), Color(0xff4710E4)]),
                      borderRadius: BorderRadius.circular(5)),
                  // color: const Color(0xff1974B3),
                  // borderRadius: BorderRadius.circular(40),

                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => Dashboard()));
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
