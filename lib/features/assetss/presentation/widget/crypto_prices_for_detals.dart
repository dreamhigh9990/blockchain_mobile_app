import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class CryptoPriceForDetailsWidget extends StatefulWidget {
  final String symbol;

  CryptoPriceForDetailsWidget(this.symbol);

  @override
  _CryptoPriceForDetailsWidgetState createState() =>
      _CryptoPriceForDetailsWidgetState();
}

class _CryptoPriceForDetailsWidgetState
    extends State<CryptoPriceForDetailsWidget> {
  late IOWebSocketChannel channel;
  String livePrice = '';

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    // Connect to the ticker price stream for the specified symbol
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/${widget.symbol.toLowerCase()}@ticker');
    // 'wss://stream.binance.com:9443/ws/${widget.symbol.toLowerCase()}@ticker');

    // Listen for WebSocket events
    channel.stream.listen(
      (message) {
        final Map<String, dynamic> data = jsonDecode(message);
        final String lastPrice = data['c']; // 'c' represents the last price
        setState(() {
          livePrice = lastPrice;
          print(livePrice);
        });
      },
      onDone: () {
        print('WebSocket Closed for ${widget.symbol}');
      },
      onError: (error) {
        print('WebSocket Error for ${widget.symbol}: $error');
      },
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return livePrice == ''
        ? SizedBox(height: 5, width: 30, child: LinearProgressIndicator())
        : Text(
            livePrice,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w900,
              height: 0.14,
            ),
          );
  }
}
