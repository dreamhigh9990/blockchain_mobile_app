import 'package:blockchain_mobile_app/features/assetss/presentation/cubit/asset_details_cubit.dart';
import 'package:blockchain_mobile_app/features/dashboard/presentation/screen/dashboard.dart';
import 'package:blockchain_mobile_app/features/home/data/model/bitcoin_list_response.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/bitcoin_list_cubit.dart';
import 'package:blockchain_mobile_app/features/home/presentation/screen/crypto_prices.dart';
import 'package:blockchain_mobile_app/features/settings_&_profile/presentation/widget/settings_and_profile.dart';
import 'package:blockchain_mobile_app/features/track/specific_coin_track_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  bool seeAllAsset = false;
  @override
  void initState() {
    callBitcoinListApi();
    super.initState();
  }

  callBitcoinListApi() async {
    await BlocProvider.of<BitcoinListCubit>(context).bitcoinList();
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
                'Track',
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
                Expanded(child: BlocBuilder<BitcoinListCubit, BitcoinListState>(
                  builder: (context, state) {
                    if (state is BitcoinListSuccess) {
                      if (seeAllAsset == false) {
                        print("in bitcoin success");
                        final List<BitcoinListResponse> response =
                            state.bitcoinListResponse;
                        // Sort the response based on some criteria, assuming there's a property called 'quoteVolume'
                        response.sort((a, b) =>
                            (double.parse(b.quoteVolume ?? "0"))
                                .compareTo(double.parse(a.quoteVolume ?? "0")));

                        // Take the top 15 items
                        final top15 = response.take(15).toList();
                        // log("top 15:${json.encode(top15)}");
                        return ListView.builder(
                          itemCount: top15.length,
                          itemBuilder: (context, index) {
                            final symbol = top15[index].symbol;
                            return listItems(symbol!, index);
                          },
                        );
                      } else {
                        print("in bitcoin success");
                        final List<BitcoinListResponse> response =
                            state.bitcoinListResponse;

                        // Sort the response based on some criteria, assuming there's a property called 'quoteVolume'
                        response.sort((a, b) =>
                            (double.parse(b.quoteVolume ?? "0"))
                                .compareTo(double.parse(a.quoteVolume ?? "0")));

                        // Take the top 15 items
                        // final top15 = response.take(15).toList();
                        // log("top 15:${json.encode(top15)}");
                        return ListView.builder(
                          itemCount: response.length,
                          itemBuilder: (context, index) {
                            final symbol = response[index].symbol;
                            return listItems(symbol!, index);
                          },
                        );
                      }
                    }

                    return Center(
                      child: LoadingAnimationWidget.discreteCircle(
                        color: const Color(0xff1974B3),
                        secondRingColor: const Color(0xffD9D9D9),
                        thirdRingColor:
                            const Color.fromARGB(157, 217, 217, 217),
                        size: 50,
                      ),
                    );
                  },
                )),
              ],
            )));
  }

  Widget listItems(String symbol, int index) {
    return ListTile(
      leading: index.isEven
          ? Image.asset("assets/images/bitcoin2.png")
          : Image.asset("assets/images/bitcoin1.png"),
      title: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      // symbol.symbol!,
                      symbol,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                    CryptoPriceWidget(
                        // symbol.symbol!
                        symbol),
                    // Text(
                    //   symbol.symbol!,
                    //   style: const TextStyle(
                    //     color: Color(0xFF7A7A7A),
                    //     fontSize: 10,
                    //     fontFamily: 'Lato',
                    //     fontWeight: FontWeight.w400,
                    //     height: 0,
                    //     letterSpacing: 0.20,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const Spacer(),
              Expanded(flex: 2, child: Image.asset("assets/images/Group.png")),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // symbol.symbol!,
                      symbol,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                    const Text(
                      '\.345}',
                      style: TextStyle(
                        color: Color(0xFF61DA01),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      onTap: () {
        // BlocProvider.of<AssetDetailsCubit>(context).assetDetails(
        //     // symbol.symbol!
        //     symbol);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SpecificCoinTrackScreen(symbol: symbol)));
      },
    );
  }
}
