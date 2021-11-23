import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mini/src/configs/api.dart';
import 'package:mini/src/configs/app_route.dart';
import 'package:mini/src/pages/model/Renalroom_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';

class RoomDetailPage extends StatefulWidget {
  @override
  _RoomCetailPageState createState() => _RoomCetailPageState();
}

class _RoomCetailPageState extends State<RoomDetailPage> {

  Rentalroom _RoomModel;

  @override
  void initState() {
    _RoomModel = Rentalroom();
    super.initState();
  }

  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    _speak() async {
      print(await flutterTts.getLanguages);
      await flutterTts.speak("ชื่อ: " + _RoomModel.rentalroomName
          + "ราคา: " + _RoomModel.rentalroomPrice + "บาทต่อเดือน"+"จำนวนห้องว่าง: "
          + _RoomModel.rentalroomApprove + "ห้อง"
          +"เบอร์โทรศัพท์: " + _RoomModel.rentalroomPhone
          +"ประเภทห้อง: " + _RoomModel.rentalroomLimitedroomSex);

    }

    _stop() async {
      print(await flutterTts.getLanguages);
      await flutterTts.stop();
    }

    Object arguments = ModalRoute.of(context).settings.arguments;
    if (arguments is Rentalroom) {
      _RoomModel = arguments;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_RoomModel.categoryName),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [

            Container(

              child: Card(

                color: Colors.blue.shade50,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                elevation: 9,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [

                    Stack(
                      children: [
                        Image.network(
                            API.RENTALROOM_IMAGE + _RoomModel.picture),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'รายละเอียด',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("ชื่อ: " + _RoomModel.rentalroomName),
                    Text("ราคา: " + _RoomModel.rentalroomPrice + "บาทต่อเดือน"),
                    Text("จำนวนห้องว่าง: " + _RoomModel.rentalroomApprove + "ห้อง"),
                    Text("เบอร์โทรศัพท์: " + _RoomModel.rentalroomPhone),
                    Text("ประเภทห้อง: " + _RoomModel.rentalroomLimitedroomSex),
                    SizedBox(
                      height: 10,
                    ),
                    Text("สิ่งอำนวยความสะดวก: " + _RoomModel.rentalroomFacilities,overflow: TextOverflow.clip,),
                    SizedBox(
                      height: 10,
                    ),
                    Text("ที่อยู่: " + _RoomModel.rentalroomNameLocation),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.volume_down,
                            color: Colors.black,
                          ),
                          onPressed: () => _speak(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.volume_off,
                            color: Colors.black,
                          ),
                          onPressed: () => _stop(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Share.share(_RoomModel.rentalroomName);
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                          onPressed: () {},
                          child: const Text('ความคิดเห็น',style: TextStyle(fontSize: 17,color: Colors.black),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent.shade700,
        tooltip: 'ADD',
        child: Icon(
          Icons.map,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.googleMapRoute);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}




