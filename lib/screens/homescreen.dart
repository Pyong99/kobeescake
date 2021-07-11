import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kobeescake/screens/cartscreen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kobeescake/screens/historyscreen.dart';
import 'package:kobeescake/screens/loginscreen.dart';
import 'package:kobeescake/screens/newproductscreen.dart';
import 'package:kobeescake/screens/profilescreen.dart';
import 'package:kobeescake/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double screenHeight;
  late double screenWidth;
  List productlist = [];
  String _titlecenter = "Loading...";
  TextEditingController _searchController = new TextEditingController();
  int cartitem = 0;

  @override
  void initState() {
    super.initState();
    _loadProduct(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: new AppBar(
        title: Text('Menu'),
        centerTitle: true,
        backgroundColor: Colors.pink[700],
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
                height: 150.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {},
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                          icon: new Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CartScreen(user: widget.user)));
                          }),
                    ],
                  ),
                )),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Hi, " + widget.user.name,
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              decoration: BoxDecoration(color: Colors.pink[700]),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("My Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.article),
                title: Text("Purchase History"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => HistoryScreen(
                                user: widget.user,
                              )));
                }),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text("Setting"),
                onTap: () {}),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: _logout),
          ],
        ),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: [
                TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search products here",
                    suffixIcon: IconButton(
                      onPressed: () => _searchProduct(_searchController.text),
                      icon: Icon(
                        Icons.search,
                        color: Colors.pink.shade900,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide:
                          BorderSide(color: Colors.pink.shade900, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide:
                          BorderSide(color: Colors.pink.shade900, width: 2),
                    ),
                  ),
                ),
                if (productlist.isEmpty)
                  Flexible(child: Center(child: Text(_titlecenter)))
                else
                  Flexible(
                      child: Center(
                          child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio:
                                  (screenWidth / screenHeight) / 0.93,
                              children:
                                  List.generate(productlist.length, (index) {
                                return Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Card(
                                      elevation: 10,
                                      child: SingleChildScrollView(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            height: screenHeight / 5,
                                            width: screenWidth / 1.1,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://pyong27.com/s271147/kobeescake/images/product/${productlist[index]['prid']}.jpg",
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 0, 0),
                                              child: Text(
                                                  productlist[index]['name'],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900))),
                                          SizedBox(height: 10),
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 0, 0, 0),
                                              child: Text(
                                                  "RM " +
                                                      productlist[index]
                                                          ['price'],
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500))),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 0, 0, 0),
                                            child: Row(
                                              children: [
                                                Text(
                                                    productlist[index]
                                                        ['rating'],
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                SizedBox(width: 5),
                                                RatingBarIndicator(
                                                  rating: double.parse(
                                                      productlist[index]
                                                          ['rating']),
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 20,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Center(
                                            child: TextButton(
                                                child: Text("Add to cart",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                    )),
                                                style: ButtonStyle(
                                                    padding: MaterialStateProperty
                                                        .all<EdgeInsets>(
                                                            EdgeInsets.all(15)),
                                                    backgroundColor: MaterialStateProperty.all<Color>(
                                                        Colors.pink.shade900),
                                                    shape: MaterialStateProperty.all<
                                                            RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(18.0),
                                                            side: BorderSide(color: Colors.pink.shade900)))),
                                                onPressed: () => {_addToCart(index)}),

                                            // TextButton(
                                            //   style:ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            //     RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               20.0)),))
                                            //   // minWidth: 100,
                                            //   // height: 40,
                                            //   // child: TextButton('Add to Cart!',
                                            //   //     style: TextStyle(
                                            //   //       fontSize: 14,
                                            //   //     )),
                                            //   // color: Colors.pink.shade900,
                                            //   // textColor: Colors.white,
                                            //   //elevation: 5,
                                            // onPressed: null,
                                            // ),
                                          )
                                        ],
                                      )),
                                    ));
                              })))),
              ],
            )),
      ),
      floatingActionButton: _getFAB(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _loadProduct(String search) {
    http.post(
        Uri.parse("https://pyong27.com/s271147/kobeescake/php/loadproduct.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No product";
        productlist = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        productlist = jsondata["products"];
        print(productlist);
        productlist = jsondata["products"];
        setState(() {});
      }
    });
  }

  void _logout() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => LoginScreen()));
  }

  _searchProduct(String search) {
    print(search);
    http.post(
        Uri.parse("https://pyong27.com/s271147/kobeescake/php/loadproduct.php"),
        body: {
          "name": search,
        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No product found";
        productlist = [];
        setState(() {});
        return;
      } else {
        setState(() {
          print(productlist);
          var jsondata = json.decode(response.body);
          productlist = jsondata["products"];
        });
        FocusScope.of(context).requestFocus(new FocusNode());
      }
    });
  }

  _addToCart(int index) {
    if (widget.user.email == '') {
      print("no email");
    } else {
      String prid = productlist[index]['prid'];
      http.post(
          Uri.parse("http://pyong27.com/s271147/kobeescake/php/addtocart.php"),
          body: {"email": widget.user.email, "prid": prid}).then((response) {
        print(response.body);
        if (response.body == "failed") {
          Fluttertoast.showToast(
              msg: "Item failed to be added to cart",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.pink.shade50,
              textColor: Colors.black,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Item successfully added to cart",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.pink.shade50,
              textColor: Colors.black,
              fontSize: 16.0);
          _loadCart();
        }
      });
    }
  }

  void _loadCart() {
    http.post(
        Uri.parse("http://pyong27.com/s271147/kobeescake/php/loadcartno.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        cartitem = int.parse(response.body);
      });
    });
  }

  Widget _getFAB() {
    if (widget.user.email == "noreply@pyong27.com") {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewProductScreen()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.pink.shade900,
      );
    } else {
      return Container();
    }
  }
}
