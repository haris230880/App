import 'package:another_flushbar/flushbar.dart';
import 'package:mini/src/configs/app_route.dart';
import 'package:mini/src/configs/app_setting.dart';
import 'package:mini/src/services/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHidden = false;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
@override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: Colors.blue.shade50,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xfffA770EF),
                      Color(0xfffCF8BF3),
                      Color(0xfffFDB99B),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5,1]
                ),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/search.png'),
                ),

                SizedBox(
                  height: 5,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: 'pacifico',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),

                      TextField(
                        controller: _usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'username',
                          hintText: 'xx@gmail.com',
                          icon: Icon(Icons.account_circle_sharp),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: isHidden,
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'password',
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: isHidden
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: togglePasswordVisibility,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final username = _usernameController.text;
                          final password = _passwordController.text;
                          print('login with $username $password');

                          final message = await NetworkService().validateUserLoginDio(username, password);
                          if (message != 'failed') {
                            print('Login seccess');
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString(AppSetting.userNameSetting, username);
                            prefs.setString(AppSetting.passwordSetting, password);

                            Navigator.pushNamed(context, AppRoute.homeRoute);
                          } else {
                            print('Login failed');
                            Flushbar(
                              title: "Login failed",
                              titleColor: Colors.blue,
                              backgroundColor: Colors.black54,
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.pink,
                              ),
                              message:
                                  "wrong,try again!!",
                              duration: Duration(seconds: 5),
                            )..show(context);
                          }
                        },
                        child: Text('LOGIN'),
                        style:
                            ElevatedButton.styleFrom(primary: Color(0XFFF651fff)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);
}
