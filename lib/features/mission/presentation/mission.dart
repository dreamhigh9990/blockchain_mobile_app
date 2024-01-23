import 'dart:developer';

import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/reward/presentaion/reward_screen.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({super.key});

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  int currentProgress = 1;
  final int totalSteps = 10;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => Dashboard()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        title: const Text(
          'Mission',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Jumper PERSONAL USE ONLY',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        actions: [
          Image.asset("assets/images/messenger2.png"),
          const SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingAndProfile(
                            // assetDetailsResponse: response,
                            )));
              },
              child: Image.asset("assets/images/settings.png")),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: 8,
              itemBuilder: (context, index) {
                // Set tile color based on index

                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 45, 0, 42)
                            .withOpacity(0.4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/bitcoin1.png"),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Make your first deposit and get Cashback \$30",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 195, 177, 177)),
                                ),
                                const SizedBox(height: 8),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 350,
                                          color: const Color.fromARGB(
                                              255, 26, 1, 41),
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                  "Rules",
                                                  style:
                                                      TextStyle(fontSize: 26),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white)),
                                                    child: const Column(
                                                      children: [
                                                        Text(
                                                            "To get the bonus you need to deposit 30 USDT, you can deposit from bank bu adding your card you transfer your cash and get the rewards.To get the bonus you need to deposit 30 USDT, you can deposit from bank bu adding your card you transfer your cash and get the rewards"),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                // Align(
                                                //   alignment: Alignment.center,
                                                //   child: Padding(
                                                //     padding: const EdgeInsets.all(8.0),
                                                //     child: ElevatedButton(
                                                //       child:  Text('Confirm Purchase'),
                                                //       onPressed: Navigator.pop(context),
                                                //       // onPressed: () => successDialog(context),
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "View rules",
                                    style: TextStyle(
                                      fontSize: 11,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Color.fromARGB(
                                          255,
                                          243,
                                          233,
                                          33), // Optional: Set the underline color
                                      decorationThickness:
                                          2.0, // Optional: Set the underline thickness
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70,
                                      child: LinearProgressIndicator(
                                        value: currentProgress / totalSteps,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text('$currentProgress / $totalSteps',
                                        style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: Row(
                                    children: [
                                      Container(
                                        color:
                                            Color.fromARGB(255, 139, 100, 163)
                                                .withOpacity(0.7),
                                        child: const Text(
                                          "30 USDT",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Text(
                                        "Cashback Voucher",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Container(
                                    color: const Color.fromARGB(255, 4, 194, 74)
                                        .withOpacity(0.5),
                                    child: const Text(
                                      "33420 rewards left",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Expired Date : 2024/2/25 "),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Reward Time : 14 days",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [
                                Color(0xff9963B7),
                                Color(0xff4710E4)
                              ]),
                              borderRadius: BorderRadius.circular(5)),
                          child: MaterialButton(
                              // color: Colors.black,
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 350,
                                      color:
                                          const Color.fromARGB(255, 26, 1, 41),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 80,
                                                child: Image.asset(
                                                    "assets/images/Green-check-mark-icon.png"),
                                              ),
                                              const Text(
                                                "Congratulation",
                                                style: TextStyle(fontSize: 26),
                                              ),
                                              const SizedBox(height: 12),
                                              const Text(
                                                  "you have succesfully completed your mission to collect the reward visit rewards screen",
                                                  textAlign: TextAlign.justify),
                                              const SizedBox(height: 12),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      width: 180,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 50,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  const LinearGradient(
                                                                      colors: [
                                                                    Color(
                                                                        0xff9963B7),
                                                                    Color(
                                                                        0xff4710E4)
                                                                  ]),
                                                            ),
                                                            child: const Center(
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            8.0),
                                                                child: Text(
                                                                  "30 USDT",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 12),
                                                          const Text(
                                                            "Cashback Voucher",
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            const LinearGradient(
                                                                colors: [
                                                              Color(0xff9963B7),
                                                              Color(0xff4710E4)
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: MaterialButton(
                                                        // color: Colors.black,
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const RewardScreen()));
                                                        },
                                                        child: const Text(
                                                          "Visit Reward Screen",
                                                          style: TextStyle(),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Complete",
                                style: TextStyle(),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
