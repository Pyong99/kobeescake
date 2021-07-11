import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kobeescake/screens/homescreen.dart';
import 'package:kobeescake/screens/registerscreen.dart';
import 'package:kobeescake/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(LoginScreen());
bool rememberMe = false;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double screenHeight;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _recoverEmailController = new TextEditingController();
  bool rememberme = false;

  @override
  void initState() {
    loadPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.pink.shade50,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
              height: 550,
              margin: EdgeInsets.only(top: screenHeight / 4.5),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Login",
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
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink.shade900, width: 50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.pink.shade900, width: 2.0),
                                ),
                              )),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink.shade900, width: 5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink.shade900, width: 2.0),
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
                                    value: rememberMe,
                                    onChanged: (bool? value) {
                                      _onChanged(value!);
                                    },
                                  ),
                                  Text('Remember me ',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                minWidth: 100,
                                height: 50,
                                child: Text('Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                                color: Colors.pink.shade900,
                                textColor: Colors.white,
                                elevation: 10,
                                onPressed: _userLogin,
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
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account? ",
                          style: TextStyle(fontSize: 18.0)),
                      GestureDetector(
                        onTap: _registerUser,
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink.shade800),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Forgot your password? ",
                          style: TextStyle(fontSize: 18.0)),
                      GestureDetector(
                        onTap: _forgotPassword,
                        child: Text(
                          "Reset password",
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
        ));
  }

  void _userLogin() {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();

    http.post(Uri.parse("https://pyong27.com/s271147/kobeescake/php/login.php"),
        body: {
          "email": _email,
          "password": _password,
        }).then((response) {
      print(response.body);

      if (response.body == "failed") {
        Fluttertoast.showToast(
            msg: "Login failed. Please try again",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink.shade50,
            textColor: Colors.black,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Login success",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.pink.shade50,
            textColor: Colors.black,
            fontSize: 16.0);

        List userlist = response.body.split(",");
        User user = User(
          email: _email,
          password: _password,
          name: userlist[1],
          quantity: userlist[2],
          rating: userlist[3],
          credit: userlist[4],
          status: userlist[5],
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen(user: user)));
      }
    }).catchError((err) {
      print(err);
    });
  }

  void _registerUser() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => RegisterScreen()));
  }

  void _forgotPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Forgot Password?"),
          content: new Container(
            height: 50,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _recoverEmailController,
                  decoration: InputDecoration(
                    labelText: 'Enter your recovery email',
                    labelStyle: TextStyle(fontSize: 14),
                    prefixIcon: Icon(Icons.email),
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.pink.shade900, width: 5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.pink.shade900, width: 2.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new TextButton(
              child: new Text(
                "Submit",
                style: TextStyle(color: Colors.pink.shade800),
              ),
              onPressed: () {
                print(_recoverEmailController.text);
                resetPassword(_recoverEmailController.text.toString());
                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: new Text(
                "Cancel",
                style: TextStyle(color: Colors.pink.shade800),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    rememberMe = prefs.getBool("rememberme") ?? false;
    if (email.length > 1) {
      setState(() {
        _emailController.text = email;
        _passwordController.text = password;
        rememberMe = true;
      });
    }
  }

  _onChanged(bool value) {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();

    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Email/Password is empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.pink.shade50,
        textColor: Colors.black,
        fontSize: 16.0,
      );

      return;
    }
    setState(() {
      rememberMe = value;
      savePref(value, _email, _password);
    });
  }

  Future<void> savePref(bool value, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setString("email", email);
      await prefs.setString("password", password);
      await prefs.setBool("rememberme", value);
      Fluttertoast.showToast(
        msg: "Preferences stored.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.pink.shade50,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      return;
    } else {
      await prefs.setString("email", '');
      await prefs.setString("password", '');
      await prefs.setBool("rememberme", false);
      Fluttertoast.showToast(
        msg: "Preferences removed.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.pink.shade50,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      setState(() {
        _emailController.text = "";
        _passwordController.text = "";
        rememberMe = false;
      });
      return;
    }
  }

  void resetPassword(String resetEmail) {
    http.post(
        Uri.parse(
            "https://pyong27.com/s271147/kobeescake/php/forgotpassword.php"),
        body: {
          "email": resetEmail,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
          msg: "Reset Password Complete.Please check your email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink.shade50,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Reset password failed. Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.pink.shade50,
          textColor: Colors.black,
          fontSize: 16.0,
        );
      }
    });
  }
}
