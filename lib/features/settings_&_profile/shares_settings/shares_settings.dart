import 'package:flutter/material.dart';

class SharesSettingScreen extends StatefulWidget {
  const SharesSettingScreen({super.key});

  @override
  State<SharesSettingScreen> createState() => _SharesSettingScreen();
}

class _SharesSettingScreen extends State<SharesSettingScreen> {
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
          'Share',
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
                'Sharing partners',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  // fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 78,
                        // height: 78,
                        //decoration: ShapeDecoration(
                        //        color: const Color(0xFF161828),
                        //     shape: RoundedRectangleBorder(
                        //      borderRadius: BorderRadius.circular(9)),
                        //),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/facebook.png"), // Replace with Facebook icon
                            SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Facebook',
                              style: TextStyle(
                                color: Color(0xFF7A7A7A),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 78,
                        // height: 100,
                        //decoration: ShapeDecoration(
                        //        color: const Color(0xFF161828),
                        //     shape: RoundedRectangleBorder(
                        //      borderRadius: BorderRadius.circular(9)),
                        //),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/whatapp.png"), // Replace with WhatsApp icon
                            SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'WhatsApp',
                              style: TextStyle(
                                color: Color(0xFF7A7A7A),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 78,
                        // height: 78,
                        //decoration: ShapeDecoration(
                        //        color: const Color(0xFF161828),
                        //     shape: RoundedRectangleBorder(
                        //      borderRadius: BorderRadius.circular(9)),
                        //),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/drive.png"), // Replace with Google icon
                            SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Drive',
                              style: TextStyle(
                                color: Color(0xFF7A7A7A),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 78,
                        // height: 78,
                        //decoration: ShapeDecoration(
                        //        color: const Color(0xFF161828),
                        //     shape: RoundedRectangleBorder(
                        //      borderRadius: BorderRadius.circular(9)),
                        //),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/mail.png"), // Replace with Mail icon
                            SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Mail',
                              style: TextStyle(
                                color: Color(0xFF7A7A7A),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 78,
                        // height: 78,
                        //decoration: ShapeDecoration(
                        //        color: const Color(0xFF161828),
                        //     shape: RoundedRectangleBorder(
                        //      borderRadius: BorderRadius.circular(9)),
                        //),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                                "assets/images/insta.png"), // Replace with Instagram icon
                            SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Instagram',
                              style: TextStyle(
                                color: Color(0xFF7A7A7A),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
