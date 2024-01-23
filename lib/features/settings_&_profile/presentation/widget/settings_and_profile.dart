import 'package:blockchain_mobile_app/features/account_details/presentation/cubit/user_info_cubit.dart';
import 'package:blockchain_mobile_app/features/assetss/presentation/widget/assets.dart';
import 'package:blockchain_mobile_app/features/buy_bitcoin/presentation/widget/buy_bitcoin.dart';
import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/presentation/screen/referal_screen.dart';
import 'package:blockchain_mobile_app/features/security/presentation/widget/security.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/connect_settings/connect_settings_screen.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/news_settings/news_settings.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/nfts_settings/nfts__setting_screen.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/shares_settings/shares_settings.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/support_settings/support_settings.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/web_settings/web_setting_screen.dart';
import 'package:blockchain_mobile_app/features/stake/presentation/widget/stake.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingAndProfile extends StatefulWidget {
  const SettingAndProfile({Key? key});

  @override
  State<SettingAndProfile> createState() => _SettingAndProfileState();
}

class _SettingAndProfileState extends State<SettingAndProfile> {
  void saveUserData(String name, String email,String photoUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Saving data
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('photoUrl', photoUrl);
  }

  @override
  void initState() {
    BlocProvider.of<UserInfoCubit>(context).getUserInfo();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        if (state is UserInfoLoading) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: const Color(0xff1974B3),
              secondRingColor: const Color(0xffD9D9D9),
              thirdRingColor: const Color.fromARGB(157, 217, 217, 217),
              size: 50,
            ),
          );
        }
        if (state is UserInfoLoaded) {
          final response = state.userInfo;
          String name = response['name'] ?? '';
          String email = response['email'] ?? '';
          String photoUrl = response['avatar'] ?? '';
          saveUserData(name, email, photoUrl);
          return SafeArea(
            child: Scaffold(
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
                        padding:
                            const EdgeInsets.only(top: 54, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (_) => Dashboard()));
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
                      response['avatar'] == ""
                          ? Positioned(
                              top: 135.0,
                              left: 150,
                              child: Container(
                                width: 113,
                                height: 113,
                                decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/images/no_photo.jpg"),
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
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 113,
                                  height: 113,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(response['avatar']),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26),
                                    ),
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
                          name,
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
                          email,
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 78,
                              height: 78,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF161828),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/assets.png"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Assets()));
                                    },
                                    child: const Text(
                                      'Assets',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SecurityPage()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/security.png"),
                                    const SizedBox(
                                      height: 5,
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 78,
                              height: 78,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF161828),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SettingAndProfile()));
                                      },
                                      child: Image.asset(
                                          "assets/images/setting.png")),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Setting ',
                                    style: TextStyle(
                                      color: Color(0xFF7A7A7A),
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      letterSpacing: 0.24,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SupportSettingScreen()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/support.png"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Support',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReferalScreen()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        "assets/images/referAndEarn.png"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Refer & Earn',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WebSettingScreen()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/web3.png"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Web3',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BuyBitCoin()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/history.png"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'History',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StakePage()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/stakkking.png"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Staking',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ConnectSettingScreen()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/connect.png"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Connect',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NftsSettingScreen()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/nft.png"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'NFTs',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 78,
                              height: 78,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF161828),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/lightining.png"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    'Lightning',
                                    style: TextStyle(
                                      color: Color(0xFF7A7A7A),
                                      fontSize: 12,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                      letterSpacing: 0.24,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SharesSettingScreen()));
                              },
                              child: Container(
                                width: 78,
                                height: 78,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF161828),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/sharessss.png"),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Shares',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: 0.24,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NewsSettingScreen()));
                        },
                        child: Container(
                          width: 78,
                          height: 78,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF161828),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/news.png"),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                'News',
                                style: TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 12,
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: 0.24,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                )),
          );
        }
        return Center(
          child: LoadingAnimationWidget.discreteCircle(
            color: const Color(0xff1974B3),
            secondRingColor: const Color(0xffD9D9D9),
            thirdRingColor: const Color.fromARGB(157, 217, 217, 217),
            size: 50,
          ),
        );
      },
    );
  }
}
