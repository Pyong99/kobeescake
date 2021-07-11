import 'dart:async';
import 'package:kobeescake/payment.dart';
import 'package:kobeescake/screens/homescreen.dart';
import 'package:kobeescake/user.dart';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final Payment payment;
  const PaymentScreen({Key? key, required this.user, required this.payment})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Payment', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink.shade700,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: WebView(
                  initialUrl:
                      'http://pyong27.com/s271147/kobeescake/php/generatebill.php?email=' +
                          widget.payment.email +
                          '&mobile=' +
                          widget.payment.phone +
                          '&name=' +
                          widget.payment.name +
                          '&amount=' +
                          widget.payment.amount,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Payment _pay = new Payment(
                      widget.payment.email,
                      widget.payment.phone,
                      widget.payment.name,
                      widget.payment.amount);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(user: widget.user),
                    ),
                  );
                  print(_pay);
                },
                child: Text(
                  'Return to Home Page',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
