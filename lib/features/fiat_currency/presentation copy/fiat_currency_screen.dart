import 'dart:developer';

import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/presentation/cubit/currency_list/currency_list_cubit.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FiatCurencyScreen extends StatefulWidget {
  const FiatCurencyScreen({super.key});

  @override
  State<FiatCurencyScreen> createState() => _FiatCurencyScreenState();
}

List<String> displayedCurrencies = [];

TextEditingController searchController = TextEditingController();

class _FiatCurencyScreenState extends State<FiatCurencyScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CurrencyListCubit>(context).fetchCurrencyList();
    // displayedCurrencies = currencyList;
  }

  // void filterCurrencies(String query) {
  //   setState(() {
  //     displayedCurrencies = allCurrencies
  //         .where((currency) =>
  //             currency.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   });
  // }

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
                'Fiat Curency List',
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
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search Currency',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                Expanded(
                  child: BlocBuilder<CurrencyListCubit, CurrencyListState>(
                    builder: (context, state) {
                      if (state is CurrencyListLoading) {
                        return LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 200,
                        );
                      } else if (state is CurrencyListSuccess) {
                        List<Map<String, dynamic>> filteredList = state
                            .currencyList
                            .where((currency) => currency['code']
                                .toString()
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()))
                            .toList();
                        log("$filteredList");
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, index) {
                                    final currency = filteredList[index];
                                    Color tileColor = index % 2 == 0
                                        ? const Color.fromARGB(255, 0, 0, 0)
                                            .withOpacity(0.2)
                                        : const Color.fromARGB(255, 45, 0, 42)
                                            .withOpacity(0.4);
                                    return ListTile(
                                      trailing: Text(
                                        currency['symbol'],
                                      ),
                                      tileColor: tileColor,
                                      title: Text(currency['code'] ??
                                          'Unknown Currency'),
                                      subtitle: Text(
                                        currency['name'],
                                      ),
                                      // You can customize the ListTile based on your currency data
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 50,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            )));
  }
}
