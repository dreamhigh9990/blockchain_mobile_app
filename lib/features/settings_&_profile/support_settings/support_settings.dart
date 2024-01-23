import 'package:flutter/material.dart';

class SupportSettingScreen extends StatefulWidget {
  const SupportSettingScreen({super.key});

  @override
  State<SupportSettingScreen> createState() => _SupportSettingScreen();
}

class _SupportSettingScreen extends State<SupportSettingScreen> {
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
          'Supports',
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
                'Our suppotrs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  // fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
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
                            const SizedBox(
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
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        width: 208,
                        // height: 58,
                        // decoration: ShapeDecoration(
                        //   color: const Color(0xFF161828),
                        //   shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(9)),
                        // ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Mail us for any support or you use chatbot for minor problems',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 178,
                            // height: 58,
                            decoration: ShapeDecoration(
                              color: const Color.fromARGB(255, 63, 69, 113),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'ChatBot Service',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 195, 192, 192),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 190),
                            child: Container(
                              width: 178,
                              height: 58,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF161828),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'I am your chatbot Support , How may i help you ?',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 195, 192, 192),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 190),
                            child: Container(
                              width: 178,
                              height: 58,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF161828),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Write your issue',
                                  style: TextStyle(
                                    color: Color(0xFF7A7A7A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
