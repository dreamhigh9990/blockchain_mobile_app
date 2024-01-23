
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class CryptoPriceWidget extends StatefulWidget {
  final String symbol;

  CryptoPriceWidget(this.symbol);

  @override
  _CryptoPriceWidgetState createState() => _CryptoPriceWidgetState();
}

class _CryptoPriceWidgetState extends State<CryptoPriceWidget> {
  late IOWebSocketChannel channel;
  String livePrice = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    try {
      channel = IOWebSocketChannel.connect(
          'wss://stream.binance.com:9443/ws/${widget.symbol.toLowerCase()}@ticker');

      channel.stream.listen(
        (message) {
          try {
            final Map<String, dynamic> data = jsonDecode(message);
            final String lastPrice = data['c']; // 'c' represents the last price
            setState(() {
              livePrice = lastPrice;
              isLoading = false;
            });
          } catch (error) {
            print('Error decoding message: $error');
          }
        },
        onDone: () {
          print('WebSocket Closed for ${widget.symbol}');
        },
        onError: (error) {
          print('WebSocket Error for ${widget.symbol}: $error');
        },
      );
    } catch (error) {
      print('Error connecting to WebSocket: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(height: 5, width: 30, child: LinearProgressIndicator())
        : Text(
            livePrice,
            style: const TextStyle(
              color: Color(0xFF61DA01),
              fontSize: 12,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
