// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphQLService {
  final GraphQLClient _client;

  GraphQLService() : _client = _createClient();

  static GraphQLClient _createClient() {
    final HttpLink httpLink = HttpLink(
      'https://blockchainapp.dkingsolution.com/graphql',
    );

    return GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );
  }

  Future<List<Map<String, dynamic>>> getCountryList() async {
    final options = QueryOptions(
      document: gql('''
      query countries {
        countries {
          id
          full_name
          calling_code
        }
      }
    '''),
      variables: {},
    );

    final queryResult = await _client.query(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      debugPrint('GraphQL error: $errorMessage');
      throw Exception('Failed to fetch country list: $errorMessage');
    }

    final countryList = queryResult.data?['countries'] as List;

    if (countryList == null) {
      throw Exception('Country list not found in the GraphQL response');
    }

    final countryListData = countryList.cast<Map<String, dynamic>>();
    return countryListData;
  }

  Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    int? country_id,
    String? referral_code,
    required String calling_code,
  }) async {
    final options = MutationOptions(
      document: gql('''
        mutation registerUser(
          \$name: String
          \$email: String
          \$password: String
          \$phone: String
          \$country_id: ID
          \$calling_code: String
          \$referral_code: String
          
        ) {
          registerUser(
            name: \$name
            email: \$email
            password: \$password
            phone: \$phone
            country_id: \$country_id
            calling_code: \$calling_code
            referral_code: \$referral_code
          ) {
            id
            name
            email
          }
        }
      '''),
      variables: <String, dynamic>{
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'country_id': country_id,
        'calling_code': calling_code,
        'referral_code': referral_code, // Use camelCase for variables
      },
    );

    final mutationResult = await _client.mutate(options);

    if (mutationResult.hasException) {
      final errorMessage = mutationResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      debugPrint('GraphQL error: $errorMessage');
      throw Exception('Failed to sign up: $errorMessage');
    }

    final userData =
        mutationResult.data?['registerUser'] as Map<String, dynamic>;

    if (userData == null) {
      throw Exception('User registration response data not found');
    }

    // Print the response
    debugPrint('User registration response: $userData');

    return userData;
  }

  Future<String> checkOtp({
    required int id,
    required String model_type,
    required String otp,
  }) async {
    final options = MutationOptions(
      document: gql('''
      mutation verifyOtp(\$id: ID!, \$model_type: String!, \$otp: String!) {
        verifyOtp(id: \$id, model_type: \$model_type, otp: \$otp){
          message
        }
      }
    '''),
      variables: <String, dynamic>{
        'id': id,
        'model_type': model_type,
        'otp': otp,
      },
    );

    final mutationResult = await _client.mutate(options);

    if (mutationResult.hasException) {
      final errorMessage = mutationResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      debugPrint('GraphQL error: $errorMessage');
      throw Exception('Failed to verify OTP: $errorMessage');
    }

    final verificationResult = mutationResult.data?['verifyOtp'];

    if (verificationResult == null) {
      throw Exception('OTP verification response data not found');
    }

    // Print the response
    debugPrint('OTP verification response: $verificationResult');

    return verificationResult.toString();
  }

  Future<Map<String, dynamic>> resendOtp({
    required String email,
  }) async {
    final options = MutationOptions(
      document: gql('''
      mutation resendOtp(\$email: String) {
        resendOtp(email: \$email) {
          user_id
          message
        }
      }
    '''),
      variables: <String, dynamic>{
        'email': email,
      },
    );

    final mutationResult = await _client.mutate(options);

    if (mutationResult.hasException) {
      final errorMessage = mutationResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      debugPrint('GraphQL error: $errorMessage');
      throw Exception('Failed to resend OTP: $errorMessage');
    }

    final otpResendResult =
        mutationResult.data?['resendOtp'] as Map<String, dynamic>;

    if (otpResendResult == null) {
      throw Exception('OTP resend response data not found');
    }

    // Print the response
    debugPrint('OTP resend response: $otpResendResult');

    return otpResendResult;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String device,
  }) async {
    final options = MutationOptions(
      document: gql('''
      mutation Login(\$email: String, \$password: String, \$device: String) {
        login(email: \$email, password: \$password, device: \$device) {
          message
          token_type
          access_token
        }
      }
    '''),
      variables: <String, dynamic>{
        'email': email,
        'password': password,
        'device': device,
      },
    );

    final mutationResult = await _client.mutate(options);

    if (mutationResult.hasException) {
      final errorMessage = mutationResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      debugPrint('GraphQL error: $errorMessage');
      throw Exception('Failed to log in: $errorMessage');
    }

    final loginResponse = mutationResult.data?['login'] as Map<String, dynamic>;

    if (loginResponse == null) {
      throw Exception('Login response data not found');
    }

    debugPrint('Login response: $loginResponse'); // Print the response

    return loginResponse;
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    final options = MutationOptions(
      document: gql('''
      mutation PasswordChange(\$oldPassword: String, \$newPassword: String, \$confirmPassword: String) {
        passwordChange(oldPassword: \$oldPassword, newPassword: \$newPassword, confirmPassword: \$confirmPassword) {
          message
        }
      }
    '''),
      variables: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("accessToken");

    print("accessToken:$accessToken");
    final httpLink = HttpLink(
      'https://blockchainapp.dkingsolution.com/graphql', // Replace with your GraphQL API endpoint
      defaultHeaders: accessToken != null
          ? {
              'Authorization': 'Bearer $accessToken',
            }
          : <String, String>{},
    );

    final queryResult = await GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ).mutate(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      throw Exception('GraphQL error: $errorMessage');
    }

    final message = queryResult.data?['passwordChange']?['message'] as String;

    if (message == null || message != 'Password changed successfully') {
      throw Exception('Password change failed');
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final options = QueryOptions(
      document: gql('''
      query getUserInfo {
        getUserInfo {
          id
          name
          email
          phone
          address
          country_id
          avatar
        }
      }
    '''),
    );

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final httpLink = HttpLink(
      'https://blockchainapp.dkingsolution.com/graphql', // Replace with your GraphQL API endpoint
      defaultHeaders: accessToken != null
          ? {
              'Authorization': 'Bearer $accessToken',
            }
          : <String, String>{},
    );

    final queryResult = await GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ).query(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      throw Exception('GraphQL error: $errorMessage');
    }

    final userInfo = queryResult.data?['getUserInfo'] as Map<String, dynamic>;

    if (userInfo == null) {
      throw Exception('Failed to retrieve user info');
    }

    return userInfo;
  }

  Future<String> updateUser({
    required String name,
    required String phone,
    required String countryId,
    required String callingCode,
    required String address,
  }) async {
    final options = MutationOptions(
      document: gql('''
      mutation UpdateUser(
        \$name: String, 
        \$phone: String, 
        \$countryId: ID, 
        \$callingCode: String, 
        \$address: String
      ) {
        updateUser(
          name: \$name, 
          phone: \$phone, 
          country_id: \$countryId, 
          calling_code: \$callingCode, 
          address: \$address
        ) {
          message
        }
      }
    '''),
      variables: {
        'name': name,
        'phone': phone,
        'countryId': countryId,
        'callingCode': callingCode,
        'address': address,
      },
    );

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("accessToken");
    final httpLink = HttpLink(
      'https://blockchainapp.dkingsolution.com/graphql', // Replace with your GraphQL API endpoint
      defaultHeaders: accessToken != null
          ? {
              'Authorization': 'Bearer $accessToken',
            }
          : <String, String>{},
    );

    final queryResult = await GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ).mutate(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      throw Exception('GraphQL error: $errorMessage');
    }

    final message = queryResult.data?['updateUser']?['message'] as String;

    if (message == null || message != 'Profile updated successfully') {
      throw Exception('Profile update failed');
    }

    return message;
  }

  Future<Map<String, dynamic>> getWalletBalanceInfo(String symbol) async {
    final options = QueryOptions(
      document: gql('''
        query WalletBalanceInfo(\$symbol: String) {
          walletBalanceInfo(symbol: \$symbol) {
            wallet_address
            cryptoCoin
            currency
            balance
          }
        }
      '''),
      variables: {'symbol': symbol},
    );

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final httpLink = HttpLink(
      "https://blockchainapp.dkingsolution.com/graphql", // Replace with your GraphQL API endpoint
      defaultHeaders: accessToken != null
          ? {
              'Authorization': 'Bearer $accessToken',
            }
          : <String, String>{},
    );

    final queryResult = await GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ).query(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      throw Exception('GraphQL error: $errorMessage');
    }

    final walletInfo =
        queryResult.data?['walletBalanceInfo'] as Map<String, dynamic>;

    if (walletInfo == null) {
      throw Exception('Failed to retrieve wallet balance info');
    }

    return walletInfo;
  }

  Future<List<Map<String, dynamic>>?> getTransactions(
      String walletAddress) async {
    final options = QueryOptions(
      document: gql('''
        query Transactions(\$wallet_address: String) {
          transactions(wallet_address: \$wallet_address) {
            purpose
            cryptocurrency_symbol
            cryptocurrency_amount
            amount
            symbol
          }
        }
      '''),
      variables: {
        'wallet_address': walletAddress,
      },
    );

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final httpLink = HttpLink(
      'https://blockchainapp.dkingsolution.com/graphql', // Replace with your GraphQL API endpoint
      defaultHeaders: accessToken != null
          ? {
              'Authorization': 'Bearer $accessToken',
            }
          : <String, String>{},
    );

    final queryResult = await GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ).query(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      throw Exception('GraphQL error: $errorMessage');
    }

    final transactions = queryResult.data?['transactions'] as List?;

    if (transactions == null) {
      throw Exception('Failed to retrieve transactions');
    }

    return transactions.cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>?> purchase({
    required String senderWalletAddress,
    required String cryptocurrencySymbol,
    required double cryptocurrencyAmount,
    required String receiverWalletAddress,
    required double amount,
    required String currencyType,
  }) async {
    final options = MutationOptions(
      document: gql('''
        mutation Purchase(
          \$sender_wallet_address: String!,
          \$cryptocurrency_symbol: String!,
          \$cryptocurrency_amount: Float!,
          \$receiver_wallet_address: String!,
          \$amount: Float!,
          \$currency_type: String!
        ) {
          purchase(
            sender_wallet_address: \$sender_wallet_address,
            cryptocurrency_symbol: \$cryptocurrency_symbol,
            cryptocurrency_amount: \$cryptocurrency_amount,
            receiver_wallet_address: \$receiver_wallet_address,
            amount: \$amount,
            currency_type: \$currency_type
          ) {
            message
          }
        }
      '''),
      variables: {
        'sender_wallet_address': senderWalletAddress,
        'cryptocurrency_symbol': cryptocurrencySymbol,
        'cryptocurrency_amount': cryptocurrencyAmount,
        'receiver_wallet_address': receiverWalletAddress,
        'amount': amount,
        'currency_type': currencyType,
      },
    );

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final httpLink = HttpLink(
      'https://blockchainapp.dkingsolution.com/graphql', // Replace with your GraphQL API endpoint
      defaultHeaders: accessToken != null
          ? {
              'Authorization': 'Bearer $accessToken',
            }
          : <String, String>{},
    );
    final client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final queryResult = await client.mutate(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      throw Exception('GraphQL error: $errorMessage');
    }

    return queryResult.data?['purchase'] as Map<String, dynamic>?;
  }

  Future<Map<String, dynamic>> getReferralEarningSummary() async {
    final options = QueryOptions(
      document: gql('''
        query ReferralEarningSummary {
          referralEarningSummary {
            total
            currency
            total_referred
            last_week_earning
          }
        }
      '''),
    );

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final httpLink = HttpLink(
      'https://blockchainapp.dkingsolution.com/graphql', // Replace with your GraphQL API endpoint
      defaultHeaders: accessToken != null
          ? {
              'Authorization': 'Bearer $accessToken',
            }
          : <String, String>{},
    );

    final queryResult = await GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ).query(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      throw Exception('GraphQL error: $errorMessage');
    }

    final referralEarningSummary =
        queryResult.data?['referralEarningSummary'] as Map<String, dynamic>;

    if (referralEarningSummary == null) {
      throw Exception('Failed to retrieve referral earning summary');
    }

    return referralEarningSummary;
  }
  Future<List<Map<String, dynamic>>> getCurrencyList() async {
    final options = QueryOptions(
      document: gql('''
        query CurrencyList {
          currencies {
            id
            name
            code
            symbol
          }
        }
      '''),
      variables: {},
    );

    final queryResult = await _client.query(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      print('GraphQL error: $errorMessage');
      throw Exception('Failed to fetch currency list: $errorMessage');
    }

    final currencyList = queryResult.data?['currencies'] as List<dynamic>;

    if (currencyList == null) {
      throw Exception('Currency list not found in the GraphQL response');
    }

    // Extracting the data and casting it to List<Map<String, dynamic>>
    final currencyListData = currencyList
        .map((currency) => currency as Map<String, dynamic>)
        .toList();

    return currencyListData;
  }

  Future<Map<String, dynamic>?> getTotalBalance() async {
    final options = QueryOptions(
      document: gql('''
      query getTotalBalance {
        getTotalBalance {
          currency_code
          total_balance
        }
      }
    '''),
    );

    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final httpLink = HttpLink(
      'https://blockchainapp.dkingsolution.com/graphql', // Replace with your GraphQL API endpoint
      defaultHeaders: accessToken != null
          ? {
              'Authorization': 'Bearer $accessToken',
            }
          : <String, String>{},
    );

    final queryResult = await GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ).query(options);

    if (queryResult.hasException) {
      final errorMessage = queryResult.exception?.graphqlErrors
          .map((error) => error.message)
          .join(', ');
      throw Exception('GraphQL error: $errorMessage');
    }

    final totalBalance =
        queryResult.data?['getTotalBalance'] as Map<String, dynamic>?;

    if (totalBalance == null) {
      throw Exception('Failed to retrieve total balance');
    }

    return totalBalance;
  }
}
