class ApiConstants {
  ApiConstants._();

// Live Base API Url
  static const baseCommonApiUrl = 'https://api.binance.com';
  // static const bitcoinList = "/api/v3/exchangeInfo";
  static const bitcoinListforAssetDetails = "/api/v3/exchangeInfo";
  static const bitcoinList = "/api/v3/ticker/24hr";
  static const assetDetails =
      'https://api.binance.com/api/v3/exchangeInfo?symbol=ETHBTC';
  static const kline = '/api/v3/klines';
}
