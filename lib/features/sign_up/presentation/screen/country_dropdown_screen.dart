// import 'package:blockchain_mobile_app/features/sign%20in/presentation/cubit/country_list_cubit.dart';
// import 'package:blockchain_mobile_app/features/sign_up/presentation/widget/country_dropdown_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// class CountryDropDownScreen extends StatefulWidget {
//   const CountryDropDownScreen({super.key});

//   @override
//   State<CountryDropDownScreen> createState() => _CountryDropDownScreenState();
// }

// class _CountryDropDownScreenState extends State<CountryDropDownScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     context.read<CountryListCubit>().fetchCountryList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CountryListCubit, CountryListState>(
//       builder: (ctx, countryListState) {
//         if (countryListState is CountryListLoading) {
//           return Center(
//             child: LoadingAnimationWidget.discreteCircle(
//               color: Colors.white.withOpacity(0.5),
//               size: 50,
//             ),
//           );
//         } else if (countryListState is CountryListFailure) {
//           final countryListError =
//               (countryListState as CountryListFailure).error;
//           return Center(
//             child: Text("Post List Error: $countryListError"),
//           );
//         } else if (countryListState is CountryListSuccess) {
//           final countryList = countryListState.countryList;
//           final countryNames = countryList
//               .map((country) =>
//                   (country['full_name'] as String?) ?? 'Unknown Country')
//               .toList();
//           return CountryDropDownWidget(
//             countryNames: countryNames,
//           );
//         }

//         return SizedBox();
//       },
//     );
//   }
// }
