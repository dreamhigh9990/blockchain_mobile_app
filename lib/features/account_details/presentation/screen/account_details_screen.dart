// import 'dart:developer';

// import 'package:blockchain_mobile_app/common/widgets/app_loading.dart';
// import 'package:blockchain_mobile_app/features/account_details/presentation/cubit/user_info_cubit.dart';
// import 'package:blockchain_mobile_app/features/account_details/presentation/widget/account_details.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AccountDetailsScreen extends StatefulWidget {
//   const AccountDetailsScreen({super.key});

//   @override
//   State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
// }

// class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//      BlocProvider.of<UserInfoCubit>(context).getUserInfo();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserInfoCubit, UserInfoState>(
//       builder: (context, state) {
//         if (state is UserInfoLoading) {
//           return showAppLoading(context);
//         }
//         if (state is UserInfoLoaded) {
//           final response = state.userInfo;
//           log("$response");
//           return AccountDetails();
//         }
//         if (state is UserInfoError) {
//           final error = state.errorMessage;

//           return Center(
//             child: Text(error),
//           );
//         }
//         return SizedBox();
//       },
//     );
//   }
// }
