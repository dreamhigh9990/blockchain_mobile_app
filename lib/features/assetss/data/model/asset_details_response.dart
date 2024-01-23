// To parse this JSON data, do
//
//     final assetDetailsResponse = assetDetailsResponseFromJson(jsonString);

import 'dart:convert';

AssetDetailsResponse assetDetailsResponseFromJson(String str) =>
    AssetDetailsResponse.fromJson(json.decode(str));

String assetDetailsResponseToJson(AssetDetailsResponse data) =>
    json.encode(data.toJson());

class AssetDetailsResponse {
  String? timezone;
  int? serverTime;
  List<RateLimit>? rateLimits;
  List<dynamic>? exchangeFilters;
  List<Symbol>? symbols;

  AssetDetailsResponse({
    this.timezone,
    this.serverTime,
    this.rateLimits,
    this.exchangeFilters,
    this.symbols,
  });

  factory AssetDetailsResponse.fromJson(Map<String, dynamic> json) =>
      AssetDetailsResponse(
        timezone: json["timezone"],
        serverTime: json["serverTime"],
        rateLimits: json["rateLimits"] == null
            ? []
            : List<RateLimit>.from(
                json["rateLimits"]!.map((x) => RateLimit.fromJson(x))),
        exchangeFilters: json["exchangeFilters"] == null
            ? []
            : List<dynamic>.from(json["exchangeFilters"]!.map((x) => x)),
        symbols: json["symbols"] == null
            ? []
            : List<Symbol>.from(
                json["symbols"]!.map((x) => Symbol.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timezone": timezone,
        "serverTime": serverTime,
        "rateLimits": rateLimits == null
            ? []
            : List<dynamic>.from(rateLimits!.map((x) => x.toJson())),
        "exchangeFilters": exchangeFilters == null
            ? []
            : List<dynamic>.from(exchangeFilters!.map((x) => x)),
        "symbols": symbols == null
            ? []
            : List<dynamic>.from(symbols!.map((x) => x.toJson())),
      };
}

class RateLimit {
  String? rateLimitType;
  String? interval;
  int? intervalNum;
  int? limit;

  RateLimit({
    this.rateLimitType,
    this.interval,
    this.intervalNum,
    this.limit,
  });

  factory RateLimit.fromJson(Map<String, dynamic> json) => RateLimit(
        rateLimitType: json["rateLimitType"],
        interval: json["interval"],
        intervalNum: json["intervalNum"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "rateLimitType": rateLimitType,
        "interval": interval,
        "intervalNum": intervalNum,
        "limit": limit,
      };
}

class Symbol {
  String? symbol;
  String? status;
  String? baseAsset;
  int? baseAssetPrecision;
  String? quoteAsset;
  int? quotePrecision;
  int? quoteAssetPrecision;
  int? baseCommissionPrecision;
  int? quoteCommissionPrecision;
  List<String>? orderTypes;
  bool? icebergAllowed;
  bool? ocoAllowed;
  bool? quoteOrderQtyMarketAllowed;
  bool? allowTrailingStop;
  bool? cancelReplaceAllowed;
  bool? isSpotTradingAllowed;
  bool? isMarginTradingAllowed;
  List<Filter>? filters;
  List<String>? permissions;
  String? defaultSelfTradePreventionMode;
  List<String>? allowedSelfTradePreventionModes;

  Symbol({
    this.symbol,
    this.status,
    this.baseAsset,
    this.baseAssetPrecision,
    this.quoteAsset,
    this.quotePrecision,
    this.quoteAssetPrecision,
    this.baseCommissionPrecision,
    this.quoteCommissionPrecision,
    this.orderTypes,
    this.icebergAllowed,
    this.ocoAllowed,
    this.quoteOrderQtyMarketAllowed,
    this.allowTrailingStop,
    this.cancelReplaceAllowed,
    this.isSpotTradingAllowed,
    this.isMarginTradingAllowed,
    this.filters,
    this.permissions,
    this.defaultSelfTradePreventionMode,
    this.allowedSelfTradePreventionModes,
  });

  factory Symbol.fromJson(Map<String, dynamic> json) => Symbol(
        symbol: json["symbol"],
        status: json["status"],
        baseAsset: json["baseAsset"],
        baseAssetPrecision: json["baseAssetPrecision"],
        quoteAsset: json["quoteAsset"],
        quotePrecision: json["quotePrecision"],
        quoteAssetPrecision: json["quoteAssetPrecision"],
        baseCommissionPrecision: json["baseCommissionPrecision"],
        quoteCommissionPrecision: json["quoteCommissionPrecision"],
        orderTypes: json["orderTypes"] == null
            ? []
            : List<String>.from(json["orderTypes"]!.map((x) => x)),
        icebergAllowed: json["icebergAllowed"],
        ocoAllowed: json["ocoAllowed"],
        quoteOrderQtyMarketAllowed: json["quoteOrderQtyMarketAllowed"],
        allowTrailingStop: json["allowTrailingStop"],
        cancelReplaceAllowed: json["cancelReplaceAllowed"],
        isSpotTradingAllowed: json["isSpotTradingAllowed"],
        isMarginTradingAllowed: json["isMarginTradingAllowed"],
        filters: json["filters"] == null
            ? []
            : List<Filter>.from(
                json["filters"]!.map((x) => Filter.fromJson(x))),
        permissions: json["permissions"] == null
            ? []
            : List<String>.from(json["permissions"]!.map((x) => x)),
        defaultSelfTradePreventionMode: json["defaultSelfTradePreventionMode"],
        allowedSelfTradePreventionModes:
            json["allowedSelfTradePreventionModes"] == null
                ? []
                : List<String>.from(
                    json["allowedSelfTradePreventionModes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "status": status,
        "baseAsset": baseAsset,
        "baseAssetPrecision": baseAssetPrecision,
        "quoteAsset": quoteAsset,
        "quotePrecision": quotePrecision,
        "quoteAssetPrecision": quoteAssetPrecision,
        "baseCommissionPrecision": baseCommissionPrecision,
        "quoteCommissionPrecision": quoteCommissionPrecision,
        "orderTypes": orderTypes == null
            ? []
            : List<dynamic>.from(orderTypes!.map((x) => x)),
        "icebergAllowed": icebergAllowed,
        "ocoAllowed": ocoAllowed,
        "quoteOrderQtyMarketAllowed": quoteOrderQtyMarketAllowed,
        "allowTrailingStop": allowTrailingStop,
        "cancelReplaceAllowed": cancelReplaceAllowed,
        "isSpotTradingAllowed": isSpotTradingAllowed,
        "isMarginTradingAllowed": isMarginTradingAllowed,
        "filters": filters == null
            ? []
            : List<dynamic>.from(filters!.map((x) => x.toJson())),
        "permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x)),
        "defaultSelfTradePreventionMode": defaultSelfTradePreventionMode,
        "allowedSelfTradePreventionModes":
            allowedSelfTradePreventionModes == null
                ? []
                : List<dynamic>.from(
                    allowedSelfTradePreventionModes!.map((x) => x)),
      };
}

class Filter {
  String? filterType;
  String? minPrice;
  String? maxPrice;
  String? tickSize;
  String? minQty;
  String? maxQty;
  String? stepSize;
  int? limit;
  int? minTrailingAboveDelta;
  int? maxTrailingAboveDelta;
  int? minTrailingBelowDelta;
  int? maxTrailingBelowDelta;
  String? bidMultiplierUp;
  String? bidMultiplierDown;
  String? askMultiplierUp;
  String? askMultiplierDown;
  int? avgPriceMins;
  String? minNotional;
  bool? applyMinToMarket;
  String? maxNotional;
  bool? applyMaxToMarket;
  int? maxNumOrders;
  int? maxNumAlgoOrders;

  Filter({
    this.filterType,
    this.minPrice,
    this.maxPrice,
    this.tickSize,
    this.minQty,
    this.maxQty,
    this.stepSize,
    this.limit,
    this.minTrailingAboveDelta,
    this.maxTrailingAboveDelta,
    this.minTrailingBelowDelta,
    this.maxTrailingBelowDelta,
    this.bidMultiplierUp,
    this.bidMultiplierDown,
    this.askMultiplierUp,
    this.askMultiplierDown,
    this.avgPriceMins,
    this.minNotional,
    this.applyMinToMarket,
    this.maxNotional,
    this.applyMaxToMarket,
    this.maxNumOrders,
    this.maxNumAlgoOrders,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        filterType: json["filterType"],
        minPrice: json["minPrice"],
        maxPrice: json["maxPrice"],
        tickSize: json["tickSize"],
        minQty: json["minQty"],
        maxQty: json["maxQty"],
        stepSize: json["stepSize"],
        limit: json["limit"],
        minTrailingAboveDelta: json["minTrailingAboveDelta"],
        maxTrailingAboveDelta: json["maxTrailingAboveDelta"],
        minTrailingBelowDelta: json["minTrailingBelowDelta"],
        maxTrailingBelowDelta: json["maxTrailingBelowDelta"],
        bidMultiplierUp: json["bidMultiplierUp"],
        bidMultiplierDown: json["bidMultiplierDown"],
        askMultiplierUp: json["askMultiplierUp"],
        askMultiplierDown: json["askMultiplierDown"],
        avgPriceMins: json["avgPriceMins"],
        minNotional: json["minNotional"],
        applyMinToMarket: json["applyMinToMarket"],
        maxNotional: json["maxNotional"],
        applyMaxToMarket: json["applyMaxToMarket"],
        maxNumOrders: json["maxNumOrders"],
        maxNumAlgoOrders: json["maxNumAlgoOrders"],
      );

  Map<String, dynamic> toJson() => {
        "filterType": filterType,
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        "tickSize": tickSize,
        "minQty": minQty,
        "maxQty": maxQty,
        "stepSize": stepSize,
        "limit": limit,
        "minTrailingAboveDelta": minTrailingAboveDelta,
        "maxTrailingAboveDelta": maxTrailingAboveDelta,
        "minTrailingBelowDelta": minTrailingBelowDelta,
        "maxTrailingBelowDelta": maxTrailingBelowDelta,
        "bidMultiplierUp": bidMultiplierUp,
        "bidMultiplierDown": bidMultiplierDown,
        "askMultiplierUp": askMultiplierUp,
        "askMultiplierDown": askMultiplierDown,
        "avgPriceMins": avgPriceMins,
        "minNotional": minNotional,
        "applyMinToMarket": applyMinToMarket,
        "maxNotional": maxNotional,
        "applyMaxToMarket": applyMaxToMarket,
        "maxNumOrders": maxNumOrders,
        "maxNumAlgoOrders": maxNumAlgoOrders,
      };
}
