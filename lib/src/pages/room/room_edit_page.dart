

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mini/src/configs/api.dart';
import 'package:mini/src/configs/app_route.dart';
import 'package:mini/src/pages/model/Renalroom_model.dart';

import 'package:mini/src/services/network.dart';
import 'package:flutter/material.dart';

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room'),
      ),
      body: Container(
        child: FutureBuilder<RentalroomModel>(
          future: NetworkService().getAllRentalDio(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: snapshot.data.rentalroom.length,
                itemBuilder: (context, index) {
                  var room = snapshot.data.rentalroom[index];
                  return Container(
                    color: Colors.black12,
                    child: ListTile(
                      title: Column(
                        children: [
                          room.picture != ""
                              ? Image.network(
                            API.RENTALROOM_IMAGE + room.picture,
                            height: 100,
                          )
                              : Image.asset(
                            'assets/images/no_photo.png',
                            height: 150,
                          ),
                          Text(room.categoryId ),
                          Text(room.rentalroomName),

                          Row(
                            children: [
                              Flexible(
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.pushNamed(context, AppRoute.roomManagementRoute,arguments: room);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.lightGreen,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Flexible(
                                child: IconButton(
                                  onPressed: (){
                                    _showMyDialog(room.rentalroomId);

                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
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
          Icons.add,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.roomManagementRoute);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _showMyDialog(String id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Delete Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Icon(Icons.delete ,size: 50 ,color: Colors.red,),
                SizedBox(height: 20,),
                Text('Would you like to delete ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();

                try{
                  final message = await NetworkService().deletRentalroomDio(id);
                  if(message=='Delete Successfully'){
                    Flushbar(
                      title: "Delete",
                      titleColor: Colors.green,
                      backgroundColor: Colors.black38,
                      icon: Icon(
                        Icons.save,
                        color: Colors.green,
                      ),
                      message: "Delete Successfully",
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }else{
                    Flushbar(
                      title: "Delete",
                      titleColor: Colors.red,
                      backgroundColor: Colors.black54,
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.pink,
                      ),
                      message: "Delete Failed!!",
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                  setState(() {

                  });
                }catch(ex){
                  Flushbar(
                    title: "Add",
                    titleColor: Colors.red,
                    backgroundColor: Colors.black38,
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.pink,
                    ),
                    message: "Add Failed!!",
                    duration: Duration(seconds: 5),
                  )..show(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}//class
