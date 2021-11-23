import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini/src/configs/api.dart';
import 'package:mini/src/configs/app_route.dart';
import 'package:mini/src/pages/model/typeroom_model.dart';
import 'package:mini/src/services/network.dart';

class TypeRoom_Page extends StatefulWidget {
  @override
  _TypeRoom_PageState createState() => _TypeRoom_PageState();
}


class _TypeRoom_PageState extends State<TypeRoom_Page> {
  Future<TypeRoomModel> _TypeRoomModel;
  @override
  void initState() {
    _TypeRoomModel = NetworkService().getAllCategoryDio();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TypeRoomModel'),
      ),
      body: Container(

        child: FutureBuilder<TypeRoomModel>(
          future: _TypeRoomModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.categorys.length,
                  itemBuilder: (context, index) {
                    var type = snapshot.data.categorys[index];
                    return ListTile(

                      onTap: () {
                        Navigator.pushNamed(context, AppRoute.roomSearchRoute,
                            arguments: type);
                      },
                      title: Row(
                        children: [
                          SizedBox(
                            width: 100,

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                API.CATEGORY_IMAGE + type.categoryImage,
                                  ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("ประเภท:"+
                                    type.categoryId,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    type.categoryName,
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,

                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),


                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                  strokeWidth: 10,
                ),
              );
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




}//
