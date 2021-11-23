


import 'package:mini/src/pages/map/google_map_page.dart';

import 'package:mini/src/pages/pages.dart';

import 'package:mini/src/pages/room/room_detail_page.dart';
import 'package:mini/src/pages/room/room_management_page.dart';
import 'package:mini/src/pages/room/room_edit_page.dart';
import 'package:mini/src/pages/room/room_type_page.dart';
import 'package:mini/src/pages/room/room_search_page.dart';

import 'package:flutter/material.dart';

class AppRoute{
  static const homeRoute ='home';
  static const infoRoute ='info';
  static const loginRoute ='login';
  static const roomtypeRoute ='roomtype';

  static const roomRoute ='room';
  static const roomManagementRoute ='roommanagementroute';
  static const roomDataiRoute ='roomdatai';
  static const roomSearchRoute ='roomsearch';
  static const  googleMapRoute ='googlemap';



  final _route = <String,WidgetBuilder>{
    homeRoute:(context)=>HomePage(),
    infoRoute:(context)=>InfoPage(),
    loginRoute:(context)=>LoginPage(),
    roomtypeRoute:(context)=>TypeRoom_Page(),

    roomRoute:(context)=>RoomPage(),
    roomManagementRoute:(context)=>RoomManagementPage(),
    roomDataiRoute:(context)=>RoomDetailPage(),
    roomSearchRoute:(context)=>RoomSearchPage(),
    googleMapRoute:(context)=>GoogleMapPage(),


  };

  get getAll => _route;
}
