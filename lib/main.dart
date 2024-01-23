import 'dart:io';
import 'package:blockchain_mobile_app/app.dart';
import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';
import 'package:blockchain_mobile_app/core/dependency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void setupLocator() {
  GetIt.I.registerLazySingleton<GraphQLService>(() => GraphQLService());
}

final client = GraphQLClient(
  link: HttpLink('http://62.171.132.197/graphql'),
  cache: GraphQLCache(),
);

final graphqlService = GraphQLService();



void main() async {
  setupLocator();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  

  final graphqlService = GraphQLService();

  await Dependency.init();
  runApp(RepositoryProvider<GraphQLService>(
    create: (_) => graphqlService,
    child: const App(),
  ));
}

// void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//     ..loadingStyle = EasyLoadingStyle.dark
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.yellow
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.yellow
//     ..textColor = Colors.yellow
//     ..maskColor = Colors.blue.withOpacity(0.5)
//     ..userInteractions = false
//     ..dismissOnTap = false
//     ..customAnimation = CustomAnimation();
// }
