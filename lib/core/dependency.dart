import 'package:blockchain_mobile_app/common/cubit/locale/locale_cubit.dart';
import 'package:blockchain_mobile_app/common/data/data_source/local/locale_source.dart';
import 'package:blockchain_mobile_app/common/data/data_source/local/token_source.dart';
import 'package:blockchain_mobile_app/common/data/repository_impl/locale_repo_impl.dart';
import 'package:blockchain_mobile_app/common/domain/repository/locale_repository.dart';
import 'package:blockchain_mobile_app/common/domain/usecase/locale_usecase.dart';
import 'package:blockchain_mobile_app/core/header_provider/header_provider.dart';
import 'package:blockchain_mobile_app/core/network/connection_checker.dart';
import 'package:blockchain_mobile_app/features/account_details/presentation/cubit/update_user_cubit.dart';
import 'package:blockchain_mobile_app/features/account_details/presentation/cubit/user_info_cubit.dart';
import 'package:blockchain_mobile_app/features/assetss/data/remote/asset_details_remote.dart';
import 'package:blockchain_mobile_app/features/assetss/data/repository_impl/asset_details_repository_impl.dart';
import 'package:blockchain_mobile_app/features/assetss/domain/repository/asset_details_repository.dart';
import 'package:blockchain_mobile_app/features/assetss/domain/usecase/asset_details_usecase.dart';
import 'package:blockchain_mobile_app/features/assetss/presentation/cubit/asset_details_cubit.dart';
import 'package:blockchain_mobile_app/features/buy_bitcoin/presentation/cubit/purchase_cubit.dart';
import 'package:blockchain_mobile_app/features/check_otp/presentation/cubit/verify_otp_cubit.dart';
import 'package:blockchain_mobile_app/features/home/data/remote/bitcoin_list_remote.dart';
import 'package:blockchain_mobile_app/features/home/data/repository_impl/bitcoin_list_repository_impl.dart';
import 'package:blockchain_mobile_app/features/home/domain/repository/bitcoin_list_repository.dart';
import 'package:blockchain_mobile_app/features/home/domain/usecase/bitcoin_list_usecase.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/bitcoin_list_cubit.dart';
import 'package:blockchain_mobile_app/features/home/presentation/cubit/cubit/toral_balance_cubit.dart';
import 'package:blockchain_mobile_app/features/order_book/data/remote/kline_book_remote.dart';
import 'package:blockchain_mobile_app/features/order_book/data/repository_impl/kline_repository_impl.dart';
import 'package:blockchain_mobile_app/features/order_book/domain/repository/kline_repository.dart';
import 'package:blockchain_mobile_app/features/order_book/domain/usecase/kline_usecase.dart';
import 'package:blockchain_mobile_app/features/order_book/presentation/cubit/kline_cubit.dart';
import 'package:blockchain_mobile_app/features/password_page/presentation/cubit/change_passwod_cubit.dart';
import 'package:blockchain_mobile_app/features/presentation/cubit/currency_list/currency_list_cubit.dart';
import 'package:blockchain_mobile_app/features/presentation/cubit/referral_earning_summary_cubit.dart';
import 'package:blockchain_mobile_app/features/sign%20in/presentation/cubit/login_cubit.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/cubit/country_list_cubit.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/cubit/resend_otp_cubit.dart';
import 'package:blockchain_mobile_app/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/cubit/transactions_cubit.dart';
import 'package:blockchain_mobile_app/features/wallet/presentation/cubit/wallet_price_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:blockchain_mobile_app/common/graphql/graphql_services.dart';

class Dependency {
  static final sl = GetIt.instance;
  Dependency._init();

  static Future<void> init() async {
    sl.registerLazySingleton<LocaleSource>(() => LocaleSourceImpl(sl()));

    sl.registerLazySingleton<LocaleRepository>(
        () => LocaleRepositoryImpl(sl()));
    sl.registerLazySingleton(() => ReadLocaleUsecase(sl()));
    sl.registerLazySingleton(() => SaveLocaleUsecase(sl()));
    sl.registerLazySingleton(() => LocaleCubit(
          readLocaleUsecase: sl(),
          saveLocaleUsecase: sl(),
        ));
    final sharedPref = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPref);
    sl.registerLazySingleton(() => Client());

    sl.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(),
    );
    sl.registerLazySingleton<TokenSource>(() => TokenSourceImpl(sl()));
    sl.registerLazySingleton<HeaderProvider>(() => HeaderProviderImpl());

    sl.registerLazySingleton(() => AuthHeaderProvider(sl()));
    // sl.registerLazySingleton<HeaderProviderAuth>(
    //     () => HeaderProviderImplAuth());

    // sl.registerLazySingleton(() => AuthHeaderProviderToken(sl()));

    // sl.registerLazySingleton<ResponseHandler>(() => ResponseHandlerImpl());

    sl.registerLazySingleton(() => CountryListCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => SignUpCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => VerifyOtpCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => ResendOtpCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => LoginCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => ChangePasswordCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => UserInfoCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => UpdateUserCubit(graphqlService: sl()));
    sl.registerFactory(() => WalletPriceCubit(graphQLService: sl()));
    sl.registerFactory(() => TransactionsCubit(graphqlService: sl()));
    sl.registerFactory(() => PurchaseCubit(graphqlService: sl()));
    sl.registerFactory(() => ReferralEarningSummaryCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => CurrencyListCubit(graphqlService: sl()));
    sl.registerLazySingleton(() => TotalBalanceCubit(graphqlService: sl()));

//---------------------------BitCoinList Start-------------------------------//

    sl.registerLazySingleton<BitcoinListRemote>(
      () => BitcoinListRemoteImpl(
        sl<AuthHeaderProvider>(),
      ),
    );

    sl.registerLazySingleton<BitcoinListRepository>(
      () => BitcoinListRepositoryImpl(
        sl(),
        sl(),
        // sl(),
      ),
    );
    sl.registerLazySingleton(() => BitcoinListUsecase(sl()));
    sl.registerFactory(() => BitcoinListCubit(bitcoinListUsecase: sl()));

//---------------------------BitcoinList End-------------------------------//
//---------------------------AssetDetails Start-------------------------------//

    sl.registerLazySingleton<AssetDetailsRemote>(
      () => AssetDetailsRemoteImpl(
        sl<AuthHeaderProvider>(),
      ),
    );

    sl.registerLazySingleton<AssetDetailsRepository>(
      () => AssetDetailsRepositoryImpl(
        sl(),
        sl(),
        // sl(),
      ),
    );
    sl.registerLazySingleton(() => AssetDetailsUsecase(sl()));
    sl.registerFactory(() => AssetDetailsCubit(assetDetailsUsecase: sl()));

//---------------------------AssetDetails End-------------------------------//

//---------------------------Kline Start-------------------------------//

    sl.registerLazySingleton<KlineRemote>(
      () => KlineRemoteImpl(
        sl<AuthHeaderProvider>(),
      ),
    );

    sl.registerLazySingleton<KlineRepository>(
      () => KlineRepositoryImpl(
        sl(),
        sl(),
        // sl(),
      ),
    );
    sl.registerLazySingleton(() => KlineUsecase(sl()));
    sl.registerFactory(() => KlineCubit(klineUsecase: sl()));

//---------------------------Kline End-------------------------------//
  }

  static final providers = <BlocProvider>[
    BlocProvider<LocaleCubit>(
      create: (context) => Dependency.sl<LocaleCubit>(),
    ),
    BlocProvider<CountryListCubit>(
      create: (context) => Dependency.sl<CountryListCubit>(),
    ),
    BlocProvider<SignUpCubit>(
      create: (context) => Dependency.sl<SignUpCubit>(),
    ),
    BlocProvider<VerifyOtpCubit>(
      create: (context) => Dependency.sl<VerifyOtpCubit>(),
    ),
    BlocProvider<ResendOtpCubit>(
      create: (context) => Dependency.sl<ResendOtpCubit>(),
    ),
    BlocProvider<LoginCubit>(
      create: (context) => Dependency.sl<LoginCubit>(),
    ),
    BlocProvider<ChangePasswordCubit>(
      create: (context) => Dependency.sl<ChangePasswordCubit>(),
    ),
    BlocProvider<UserInfoCubit>(
      create: (context) => Dependency.sl<UserInfoCubit>(),
    ),
    BlocProvider<UpdateUserCubit>(
      create: (context) => Dependency.sl<UpdateUserCubit>(),
    ),
    BlocProvider<BitcoinListCubit>(
      create: (context) => Dependency.sl<BitcoinListCubit>(),
    ),
    BlocProvider<AssetDetailsCubit>(
      create: (context) => Dependency.sl<AssetDetailsCubit>(),
    ),
    BlocProvider<KlineCubit>(
      create: (context) => Dependency.sl<KlineCubit>(),
    ),
    BlocProvider<WalletPriceCubit>(
      create: (context) => Dependency.sl<WalletPriceCubit>(),
    ),
    BlocProvider<TransactionsCubit>(
      create: (context) => Dependency.sl<TransactionsCubit>(),
    ),
    BlocProvider<PurchaseCubit>(
      create: (context) => Dependency.sl<PurchaseCubit>(),
    ),
    BlocProvider<ReferralEarningSummaryCubit>(
      create: (context) => Dependency.sl<ReferralEarningSummaryCubit>(),
    ),
    BlocProvider<CurrencyListCubit>(
      create: (context) => Dependency.sl<CurrencyListCubit>(),
    ),
    BlocProvider<TotalBalanceCubit>(
      create: (context) => Dependency.sl<TotalBalanceCubit>(),
    ),
  ];
}
