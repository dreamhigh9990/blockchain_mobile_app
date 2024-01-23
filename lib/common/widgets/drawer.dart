import 'package:blockchain_mobile_app/features/buy_bitcoin/presentation/widget/buy_bitcoin.dart';
import 'package:blockchain_mobile_app/features/fiat_currency/presentation/fiat_currency_screen.dart';
import 'package:blockchain_mobile_app/features/presentation/screen/referal_screen.dart';
import 'package:blockchain_mobile_app/features/reward/presentaion/reward_screen.dart';
import 'package:blockchain_mobile_app/features/send_payment/presentation/widget/send_payment.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:blockchain_mobile_app/features/sign%20in/presentation/widget/sign_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonDrawer extends StatefulWidget {
  final Function(int) onDrawerItemClicked;
  const CommonDrawer({super.key, required this.onDrawerItemClicked});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF161828),
      width: 184,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Divider(
              color: Colors.white.withOpacity(.5),
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(
                'Trade',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            InkWell(
              onTap: () {
                widget.onDrawerItemClicked(4);
                Navigator.pop(context);
                // dashboardController.dispose;
                // setState(() {
                //   dashboardController.jumpToPage(4);
                // });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/crypto.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Crypto Wallet',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              //  onTap: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const FiatCurencyScreen()));
              // },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/icons8_user_96px_2 1.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Track',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FiatCurencyScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/icons8_user_96px_2 1 (1).png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Fiat Wallet',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BuyBitCoin()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/icons8_user_96px_2 1 (2).png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Recurring Buy',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: Row(
                children: [
                  Image.asset("assets/images/icons8_user_96px_2 1 (3).png"),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Target Price',
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(
                'Spend',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SendPayment()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/pay.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Pay',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 21),
            //   child: Text(
            //     'Finance',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //       height: 0.14,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/supercharger.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'Supercharger',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/earn.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'Earn',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontFamily: 'Lato',
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/staking.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'Staking',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontFamily: 'Lato',
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 21,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 21),
              child: Text(
                'Bonus',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 0.14,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: Row(
                children: [
                  Image.asset("assets/images/mission.png"),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Mission',
                    style: TextStyle(
                      color: Color(0xFF7A7A7A),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 0.28,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RewardScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Row(
                  children: [
                    Image.asset("assets/images/reward.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Reward',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReferalScreen()));
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/reffer.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Refer',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 21),
            //   child: Text(
            //     'More',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //       height: 0.14,
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/cryptooo.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'Crypto.com NFT',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 21),
            //   child: Row(
            //     children: [
            //       Image.asset("assets/images/university.png"),
            //       const SizedBox(
            //         width: 12,
            //       ),
            //       const Text(
            //         'University',
            //         style: TextStyle(
            //           color: Color(0xFF7A7A7A),
            //           fontSize: 14,
            //           fontFamily: 'Lato',
            //           fontWeight: FontWeight.w400,
            //           height: 0,
            //           letterSpacing: 0.28,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingAndProfile()));
                },
                child: Row(
                  children: [
                    Image.asset("assets/images/settings.png"),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Setting',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white.withOpacity(.5),
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: InkWell(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SignInWidget()));
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Color(0xFF7A7A7A),
                        fontSize: 14,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
