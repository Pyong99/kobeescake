import 'dart:convert';
//import 'package:kobeescake/payment.dart';
import 'package:kobeescake/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryScreen extends StatefulWidget {
  final User user;
  //final Payment payment;
  const HistoryScreen({Key? key, required this.user}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late double screenHeight, screenWidth;
  List _receiptList = [];
  String email = "";
  @override
  void initState() {
    super.initState();
    _loadReceipt();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade700,
        centerTitle: true,
        title: Text('Purchase History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton.icon(
              onPressed: () => {_loadReceipt()},
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: Text(''),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.pink.shade900,
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(width: 15),
                Expanded(
                    flex: 3,
                    child: Text('Order ID',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),
                Container(
                    height: 50, child: VerticalDivider(color: Colors.grey)),
                SizedBox(width: 15),
                Expanded(
                    flex: 3,
                    child: Text('Amount (RM)',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis)),
                Container(
                    height: 50, child: VerticalDivider(color: Colors.grey)),
                SizedBox(width: 15),
                Expanded(
                    flex: 4,
                    child: Text('Date Purchased',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis))
              ],
            ),
          ),
          Flexible(child: OrientationBuilder(builder: (context, orientation) {
            return GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 9,
                children: List.generate(_receiptList.length, (index) {
                  return Column(
                    children: [
                      Container(
                          height: 50,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                              children: [
                                SizedBox(width: 15),
                                Expanded(
                                    flex: 3,
                                    child: Text(
                                        _receiptList[index]['receiptid'],
                                        style: TextStyle(fontSize: 17),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Colors.grey.shade400)),
                                SizedBox(width: 15),
                                Expanded(
                                    flex: 3,
                                    child: Text(_receiptList[index]['amount'],
                                        style: TextStyle(fontSize: 17),
                                        maxLines: 2,
                                        overflow: TextOverflow.fade)),
                                Container(
                                    height: 50,
                                    child: VerticalDivider(
                                        color: Colors.grey.shade400)),
                                SizedBox(width: 15),
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                        _convert(_receiptList[index]['date']),
                                        style: TextStyle(fontSize: 18),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          )),
                    ],
                  );
                }));
          })),
        ],
      ),
    );
  }

  _loadReceipt() {
    http.post(
        Uri.parse("http://pyong27.com/s271147/kobeescake/php/loadreceipt.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body != "nodata") {
        var jsondata = json.decode(response.body);
        _receiptList = jsondata["receipt"];
        print(jsondata);
      } else {
        print("Failed");
        return;
      }
    });
    setState(() {});
  }

  String _convert(receiptList) {
    var time = receiptList.split(".");
    String a = time[0];
    return a;
  }
} //end recent payment screen
