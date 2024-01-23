import 'package:blockchain_mobile_app/features/about_us/presentation/widget/about_us.dart';
import 'package:blockchain_mobile_app/features/account_details/presentation/widget/account_details.dart';
import 'package:blockchain_mobile_app/features/notifications/presentation/widget/notifications.dart';
import 'package:blockchain_mobile_app/features/password_page/presentation/widget/password_page.dart';
import 'package:blockchain_mobile_app/features/terms_and_condition/presentation/widget/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  String retrievedName = '';
  String retrievedEmail = '';
  String retrievedPhotoUrl = '';

  @override
  void initState() {
    super.initState();
    // Call the function to retrieve data when the page is initialized
    retrieveUserData();
  }

  void retrieveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieving data
    setState(() {
      retrievedName = prefs.getString('name') ?? '';
      retrievedEmail = prefs.getString('email') ?? '';
      retrievedPhotoUrl = prefs.getString('photoUrl') ?? '';
      print("retrievedPhotoUrl:$retrievedPhotoUrl");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(260), // Adjust the height as needed
        child: Stack(
          children: [
            Container(
              height: 188,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 54, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const Text(
                    'Profile & Setting',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Image.asset("assets/images/down-arrow 6.png"),
                ],
              ),
            ),
            retrievedPhotoUrl == ""
                ? Positioned(
                    top: 135.0,
                    left: 150,
                    child: Container(
                      width: 113,
                      height: 113,
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/no_photo.jpg"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
                  )
                : Positioned(
                    top: 135.0,
                    left: 150,
                    child: Container(
                      width: 113,
                      height: 113,
                      decoration: ShapeDecoration(
                        image:  DecorationImage(
                          image: NetworkImage(retrievedPhotoUrl),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                    ),
                  ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Text(
                    '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Jumper PERSONAL USE ONLY',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Text(
                retrievedName,
                style: const TextStyle(
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
            Center(
              child: Text(
                retrievedEmail,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  // fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(
              height: 47,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountDetails()));
              },
              child: Container(
                width: 350,
                height: 59,
                decoration: ShapeDecoration(
                  color: const Color(0xFF161828),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person_2_outlined,
                            color: Color(0xFF7A7A7A),
                            size: 16,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Account',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 12,
                              // fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PasswordPage()));
              },
              child: Container(
                width: 350,
                height: 59,
                decoration: ShapeDecoration(
                  color: const Color(0xFF161828),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/securityprofile.png"),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Security',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 12,
                              // fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationsPage()));
              },
              child: Container(
                width: 350,
                height: 59,
                decoration: ShapeDecoration(
                  color: const Color(0xFF161828),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/notification.png"),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Notification',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 12,
                              // fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 16,
            // ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const DepositPage()));
            //   },
            //   child: Container(
            //     width: 350,
            //     height: 59,
            //     decoration: ShapeDecoration(
            //       color: const Color(0xFF161828),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(15.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             children: [
            //               Image.asset("assets/images/depositemoney.png"),
            //               const SizedBox(
            //                 width: 12,
            //               ),
            //               const Text(
            //                 'Deposit Money',
            //                 style: TextStyle(
            //                   color: Color(0xFF7A7A7A),
            //                   fontSize: 12,
            //                   // fontFamily: 'Lato',
            //                   fontWeight: FontWeight.w400,
            //                   height: 0,
            //                   letterSpacing: 0.24,
            //                 ),
            //               ),
            //             ],
            //           ),
            //           const Icon(
            //             Icons.arrow_forward_ios,
            //             color: Colors.white,
            //             size: 16,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsAndCondition()));
              },
              child: Container(
                width: 350,
                height: 59,
                decoration: ShapeDecoration(
                  color: const Color(0xFF161828),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/t&c.png"),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Terms And Condition',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 12,
                              // fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ],
                      ),
                      // Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: Colors.white,
                      //   size: 16,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutUs()));
              },
              child: Container(
                width: 350,
                height: 59,
                decoration: ShapeDecoration(
                  color: const Color(0xFF161828),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/about.png"),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'About',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 12,
                              // fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 0.24,
                            ),
                          ),
                        ],
                      ),
                      // Icon(
                      //   Icons.arrow_forward_ios,
                      //   color: Colors.white,
                      //   size: 16,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(

                  // color: const Color(0xff1974B3),
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFF9963B7), Color(0xFF4710E4)],
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: MaterialButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                  child: Text(
                    "Refer & Get \$25 USD",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
