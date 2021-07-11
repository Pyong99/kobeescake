import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kobeescake/screens/loginscreen.dart';

void main() => runApp(RegisterScreen());

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late double screenHeight;
  bool _isChecked = false;

  GlobalKey<FormState> _key = new GlobalKey();
  late String name, email, phone, password;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          backgroundColor: Colors.pink.shade50,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: <Widget>[
              Container(
                height: 700,
                margin: EdgeInsets.only(top: screenHeight / 7),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      child: new Form(
                        key: _key,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  onSaved: (String? value) {
                                    name = value!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    prefixIcon: Icon(Icons.person),
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.pink.shade900,
                                          width: 2.0),
                                    ),
                                  )),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (String? value) {
                                    email = value!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.pink.shade900,
                                          width: 2.0),
                                    ),
                                  )),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                keyboardType: TextInputType.phone,
                                onSaved: (String? value) {
                                  phone = value!;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.pink.shade900,
                                        width: 2.0),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: _confirmPasswordController,
                                onSaved: (String? value) {
                                  password = value!;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.lock),
                                  contentPadding: EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.pink.shade900,
                                        width: 2.0),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Checkbox(
                                        value: _isChecked,
                                        onChanged: (bool? value) {
                                          _onChanged(value!);
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: _showEULA,
                                        child: Text(
                                            'I agree to Terms & Conditions  ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    minWidth: 115,
                                    height: 50,
                                    child: Text('Register',
                                        style: TextStyle(
                                          fontSize: 20,
                                        )),
                                    color: Colors.pink.shade900,
                                    textColor: Colors.white,
                                    elevation: 10,
                                    onPressed: _acceptRegister,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already register? ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0)),
                        GestureDetector(
                          onTap: _loginScreen,
                          child: Text(
                            "Back to Login",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink.shade800),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset(
        'assets/images/Logo.png',
        fit: BoxFit.cover,
      ),
    );
  }

  void _acceptRegister() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Register"),
          content: new Container(
            height: 50,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: _showEULA,
                  child: Text(
                      'I agree to Terms & Conditions and confirm all the information is correct',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: _onRegister,
            ),
            new TextButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onRegister() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept Terms & Condition",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      Navigator.of(context).pop();
      return;
    }
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill in all the information",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM);
      Navigator.of(context).pop();
      return;
    } else {
      if (email.contains(RegExp(r'[@]')) == false) {
        Fluttertoast.showToast(
            msg: "Please enter valid email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
        Navigator.of(context).pop();
        return;
      }
      if (password != confirmPassword) {
        Fluttertoast.showToast(
            msg: "Please make sure passwords are matched",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
        Navigator.of(context).pop();
        return;
      }
    }
    http.post(
        Uri.parse("https://pyong27.com/s271147/kobeescake/php/register.php"),
        body: {
          "name": name,
          "email": email,
          "password": password
        }).then((response) {
      if (response.body == 'failed') {
        Fluttertoast.showToast(
            msg: "Register failed. Please try again",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
      } else {
        Fluttertoast.showToast(
            msg:
                "Register success.Please check your email for verification link.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM);
        _loginScreen();
      }
    });
  }

  void _loginScreen() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  void _onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void _showEULA() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("End-User License Agreement (EULA)"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                          text:
                              "This End-User License Agreement is a legal agreement between you and Kobees Cake. Our EULA was created by EULA Template for Kobees Cake. This EULA agreement governs your acquisition and use of our Kobees Cake software  directly from Kobees Cake or indirectly through a Kobees Cake authorized reseller or distributor. Please read this EULA agreement carefully before completing the installation process and using the Kobees Cake software. It provides a license to use the Kobees Cake software and contains warranty information and liability disclaimers. If you register for a free trial of the Kobees Cake software, this EULA agreement will also govern that trial. By clicking 'accept' or installing and/or using the Kobees Cake software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement. This EULA agreement shall apply only to the Software supplied by Kobees Cake herewith regardless of whether other software is referred to or described herein. The terms also apply to any Kobees Cake updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply.",
                        )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
