import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini/src/app.dart';
import 'package:mini/src/configs/api.dart';
import 'package:mini/src/configs/app_route.dart';
import 'package:mini/src/pages/model/Renalroom_model.dart';
import 'package:mini/src/services/network.dart';

class RoomSearchPage extends StatefulWidget {
  @override
  _RoomSearchPageState createState() => _RoomSearchPageState();
}

class _RoomSearchPageState extends State<RoomSearchPage> {

  Future<RentalroomModel> _RentalroomModel;
  List names = new List();
  List filteredNames = new List();
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTiTle = new Text('Seare Room');


  final TextEditingController _filter = new TextEditingController();
  _RoomSearchPageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    _getNames();
    super.initState();
  }
  Future<void> _getNames() async {
    List tempList = new List();
    _RentalroomModel = NetworkService().getAllRentalDio();
    if (_RentalroomModel.toString().isNotEmpty) {
      await _RentalroomModel.then((value) => {
        for (int i = 0; i < value.rentalroom.length; i++)
          {
            tempList.add(value.rentalroom[i]),
          }
      });
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (!_searchText.isEmpty) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        Rentalroom Room = filteredNames[i];
        if (Room.rentalroomName.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    } else {
      filteredNames = names;
    }
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        child: _buildListView(),
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
  ListView _buildListView() {
    return ListView.builder(
        itemCount: names==null ? 0 :filteredNames.length,
        itemBuilder: (context, index) {
          Rentalroom Room = filteredNames[index];

          return ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoute.roomDataiRoute,
                  arguments: Room);
            },
            title: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                       API.RENTALROOM_IMAGE + Room.picture),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ประเภท: "+
                            Room.categoryName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        Text(""+
                            Room.rentalroomName,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text("ราคา: "+
                            Room.rentalroomPrice +" บาท/เดือน",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.deepPurpleAccent,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTiTle,
      actions: [
        IconButton(
            onPressed: () {
              _searchPressed();
            },
            icon: _searchIcon)
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTiTle = new TextField(
          style: TextStyle(color: Colors.white, fontSize: 20),
          controller: _filter,
          decoration: new InputDecoration(
              suffixIcon: Icon(
                Icons.search,
              ),
              hintText: 'Search....'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTiTle = new Text('');
        filteredNames = names;
        _filter.clear();
      }
    });

  }

}
