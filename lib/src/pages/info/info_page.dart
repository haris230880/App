import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini/src/pages/pages.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('My Info'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xfffA770EF),
                  Color(0xfffCF8BF3),

                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
               //stops: [0.5,1]
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/2019-09-10.jpg')
              ),
              Text(
                'Haris mama',
                style: TextStyle(
                    fontSize: 30, color: Colors.orange, ),
              ),
              Text(
                'student',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.amberAccent,
                    ),
              ),
              SizedBox(
                width: 150,
                height: 30,
                child: Divider(
                  color: Colors.amber.shade100,
                  thickness: 3,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.accessibility_new,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Nickname : Ris',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.orange,
                         ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_ic_call_outlined,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'telephone number : 095055555',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.orange,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_to_home_screen,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'major : it',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.orange,
                         ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
