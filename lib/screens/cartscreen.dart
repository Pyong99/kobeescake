import 'dart:convert';
import 'package:kobeescake/screens/checkoutscreen.dart';
import 'package:kobeescake/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cached_network_image/cached_network_image.dart';

class CartScreen extends StatefulWidget {
  final User user;
  const CartScreen({Key? key, required this.user}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List _cartList = [];
  String _titlecenter = "No product in cart...";
  double _totalprice = 0.0;
  late double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    _loadMyCart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Cart',
            style: TextStyle(
                //color: Colors.black)),
                )),
        backgroundColor: Colors.pink.shade700,
      ),
      body: Center(
        child: Column(
          children: [
            if (_cartList.isEmpty)
              Flexible(
                  child: Center(
                      child:
                          Text(_titlecenter, style: TextStyle(fontSize: 18))))
            else
              Flexible(
                  child: OrientationBuilder(builder: (context, orientation) {
                return GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 1,
                    children: List.generate(_cartList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(1),
                          child: Container(
                              child: Card(
                                  child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  height: orientation == Orientation.portrait
                                      ? 100
                                      : 150,
                                  width: orientation == Orientation.portrait
                                      ? 100
                                      : 150,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "http://pyong27.com/s271147/kobeescake/images/product/${_cartList[index]['prid']}.jpg",
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                              ),
                              Container(
                                  height: screenHeight / 2,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(_cartList[index]['prname'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Container(
                                                height: 28,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.pink.shade700,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 4,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ]),
                                                child: IconButton(
                                                  icon: Icon(Icons.remove,
                                                      size: 17,
                                                      color: Colors.white),
                                                  onPressed: () {
                                                    _modQty(
                                                        index, "removecart");
                                                  },
                                                ),
                                              ),
                                              Text(
                                                _cartList[index]['cartqty'],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              Container(
                                                height: 28,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.pink.shade700,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 3,
                                                        blurRadius: 4,
                                                        offset: Offset(0, 3),
                                                      )
                                                    ]),
                                                child: IconButton(
                                                  icon: Icon(Icons.add,
                                                      size: 17,
                                                      color: Colors.white),
                                                  onPressed: () {
                                                    _modQty(index, "addcart");
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            "RM " +
                                                (int.parse(_cartList[index]
                                                            ['cartqty']) *
                                                        double.parse(
                                                            _cartList[index]
                                                                ['prprice']))
                                                    .toStringAsFixed(2),
                                            style: TextStyle(
                                                color: Colors.red.shade800,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [],
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete,
                                          color: Colors.grey.shade700),
                                      onPressed: () {
                                        _deleteCartDialog(index);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))));
                    }));
              })),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Text('TOTAL',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(
                            "RM " + _totalprice.toStringAsFixed(2),
                            style: TextStyle(
                                color: Colors.red.shade800,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pink.shade900,
                            shape: StadiumBorder()),
                        onPressed: () {
                          _payDialog();
                        },
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _loadMyCart() {
    http.post(
        Uri.parse("http://pyong27.com/s271147/kobeescake/php/loadcart.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No product in cart";
        _cartList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _cartList = jsondata["cart"];
        _titlecenter = "";
        _totalprice = 0.0;
        print(_cartList);
        for (int i = 0; i < _cartList.length; i++) {
          _totalprice = _totalprice +
              double.parse(_cartList[i]['prprice']) *
                  int.parse(_cartList[i]['cartqty']);
        }
      }
      setState(() {});
    });
  }

  void _modQty(int index, String action) {
    http.post(
        Uri.parse("http://pyong27.com/s271147/kobeescake/php/updatecart.php"),
        body: {
          "email": widget.user.email,
          "op": action,
          "prid": _cartList[index]['prid'],
          "cartqty": _cartList[index]['cartqty']
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Item successfully edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink.shade50,
            textColor: Colors.black,
            fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Item failed to be edited",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink.shade50,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }

  void _deleteCartDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete from your cart?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteCart(index);
                    },
                  ),
                  TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  void _deleteCart(int index) {
    http.post(
        Uri.parse("http://pyong27.com/s271147/kobeescake/php/deletecart.php"),
        body: {
          "email": widget.user.email,
          "prid": _cartList[index]['prid']
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Item successfully deleted from cart",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink.shade50,
            textColor: Colors.black,
            fontSize: 16.0);
        _loadMyCart();
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Item failed to be deleted from cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink.shade50,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }

  void _payDialog() {
    if (_totalprice == 0.0) {
      Fluttertoast.showToast(
          msg: "Shopping cart is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink.shade50,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else {
      showDialog(
          builder: (context) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: new Text(
                    'Proceed to checkout?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => CheckOutScreen(
                                  user: widget.user, totalPrice: _totalprice)),
                        );
                      },
                    ),
                    TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ]),
          context: context);
    }
  }
} //end cart screen
