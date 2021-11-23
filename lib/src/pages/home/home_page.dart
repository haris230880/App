import 'package:carousel_slider/carousel_slider.dart';
import 'package:mini/src/configs/app_route.dart';
import 'package:mini/src/configs/app_setting.dart';
import 'package:mini/src/widgets/manu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current =0 ;

  List<Map<String, String>> imgArray = [
    {
      "img":
      "http://www.doocondo.com/stocks/market/5237cmjks.jpg",
      "title": "คอนโดมิเนียม",
      "description":
      " อาคารที่บุคคลสามารถแยกการถือกรรมสิทธิ์ออกได้เป็นส่วนๆ โดยแต่ละส่วนประกอบด้วยกรรมสิทธิ์ในทรัพย์ส่วนบุคคลและกรรมสิทธิ์ร่วมในทรัพย์ส่วนกลาง",
      "price": "",
      "page" : "roomtype"
    },
    {
      "img":
      "https://f.hongpak.in.th/media/rooms/photos/13/0326/20130326121440-412.JPG",
      "title": "อพาร์ทเม้นท์",
      "description":
      " อาคารพักอาศัยเพื่อเช่า ซึ่งจะเป็นที่พักอาศัยหรืออาคารพักอาศัยที่ผู้อยู่อาศัยมีสิทธิ์แค่เพียงเช่าพักเท่านั้น โดยกรรมสิทธิ์ทั้งผืนดินและทั้งอาคารนั้นยังเป็นของเจ้าของอพาร์ทเม้นท์ ",
      "price": "",
      "page" : "roomtype"
    },
    {
      "img":
      "https://www.kobkid.com/wp-content/uploads/2018/06/mw960367054-267394-unsplash-1.jpg",
      "title": "แมนชั่น ",
      "description":
      "แมนชั่นจะคล้ายๆกับอพาร์ทเม้นท์ ที่มีความหรูหรามากกว่า มีสิ่งอำนวยความสะดวกมากกว่า มีขนาดใหญ่กว่า อพาร์ทเม้นอาจเป็นสตูดิโอห้องเดียว",
      "price": "",
      "page" : "roomtype"
    },
    {
      "img":
      "https://cf.bstatic.com/xdata/images/hotel/max1024x768/179978173.jpg?k=bebf25d11ff5f63b4940b15f7790492aed5d887bacbefc73475e79ceb828407d&o=&hp=1",
      "title": "หอพัก ",
      "description":
      "อาคารที่พักอาศัยสำหรับนักเรียนนักศึกษา เป็นต้น แบ่งซอยเป็นห้อง ๆ มีทั้งแยกประเภทเป็นชายหญิง หรือเป็นหอรวม.",
      "price": "",
      "page" : "roomtype"
    },
  ];
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/2019-09-10.jpg'),
              ),
              accountName: Text('Haris mama'),
              accountEmail: Text('624235009@pari.skru.ac.th'),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
            ),
            ...MenuViewModel()
                .items
                .map((e) => ListTile(
                      leading: Icon(
                        e.icon,
                        color: e.iconColor,
                      ),
                      title: Text(e.title),
                      onTap: () {
                        e.onTap(context);
                      },
                    ))
                .toList(),
            Spacer(),

          ],
        ),
      ),
      appBar: AppBar(
        title: Text('HOME'),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset('packages/flutter_login/assets/images/ecorp.png',scale: 10,),
            Text(
              'E-Commerce',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontFamily: ''),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoute.roomtypeRoute);
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: Colors.blue.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/room.png'),
                        scale: 10,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Room',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoute.roomSearchRoute);
                  },

                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: Colors.blue.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/search.png'),
                        scale: 10,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'search',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoute.googleMapRoute);
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: Colors.blue.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/map.png'),
                        scale: 10,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Map',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              width: 300,
              height: 30,
              child: Divider(
                color: Colors.blue,
                thickness: 10,
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 5,
              margin: EdgeInsets.all(15),

            ),
            SizedBox(height: 10),
            CarouselSlider(
              items: imgArray
                  .map((item) => GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, item["page"]);
                },
                    child: Container(
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.4),
                                blurRadius: 8,
                                spreadRadius: 0.3,
                                offset: Offset(0, 3))
                          ]),
                          child: AspectRatio(
                            aspectRatio: 2 / 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                item["img"],
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            Text(item["price"],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.orange)),
                            Text(item["title"],
                                style:
                                TextStyle(fontSize: 32, color: Colors.black)),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 8),
                              child: Text(
                                item["description"],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                ),
              ),
                  ))
                  .toList(),
              options: CarouselOptions(
                  height: 530,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  aspectRatio: 4 / 4,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  // viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),

          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(  backgroundColor: Colors.deepPurpleAccent.shade700,
        tooltip: 'ADD',
        child: Icon(
          Icons.search,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.roomSearchRoute);
        },),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
} //end
