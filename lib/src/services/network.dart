import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:mini/src/configs/api.dart';
import 'package:mini/src/pages/model/Renalroom_model.dart';

import 'package:mini/src/pages/model/typeroom_model.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
class NetworkService {
  NetworkService._internal();

  static final NetworkService _instace = NetworkService._internal();

  factory NetworkService() => _instace;

  static final Dio _dio = Dio();



  Future<String> validateUserLoginDio(String username, String password) async {
    FormData data = FormData.fromMap({
      'username': username,
      'password': password,
    });
    try {
      //var url = API.BASE_URL + '/flutterapp/f_user_login.php';
      //var url = API.BASE_URL + '/api/user';
      var url = API.BASE_URL + '/flutterapi/api/user';
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200) {
        var jsonString = response.data;
        // var jsonMap = json.encode(jsonString);
        String username = jsonString["username"];
        print('username = ' + username);
        String password = jsonString["password"];
        print('password = ' + password);
        if (username != 'failed') {
          return 'pass';
        } else {
          return 'failed';
        }
      } else {
        return 'failed';
      }
    } catch (Exception) {
      throw Exception('Network failed');
    }
  }
  Future<TypeRoomModel> getAllCategoryDio() async {
    //var url = API.BASE_URL + '/flutterapp/getAllGames_7.php';
    var url = API.BASE_URL + API.CATEGORY_URL;
    print('url getAllCategoryDio() = ' + url);
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return typeRoomModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<RentalroomModel> getAllRentalDio() async {
    //var url = API.BASE_URL + '/flutterapp/getAllGames_7.php';
    var url = API.BASE_URL + API.RENTALROOM_URL;
    print('url getAllRentalDio() = ' + url);
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      print(response.data);
      return rentalroomModelFromJson(json.encode(response.data));
    }
    throw Exception('Network failed');
  }
  Future<String> editRentalroomDio(File imageFile, Rentalroom room) async {
    FormData data = FormData.fromMap({
      'rentalroom_name': room.rentalroomName,
      'rentalroom_price': room.rentalroomPrice,
      'rentalroom_phone': room.rentalroomPhone,
      'picture': room.picture,

      // if (imageFile != null)
      //   'photo': await MultipartFile.fromFile(
      //     imageFile.path,
      //     contentType: MediaType('image', 'jpg'),
      //   ),
      if (imageFile != null)
        'picture': room.picture
      else
        'picture': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response =
    await _dio.post(API.BASE_URL + API.RENTALROOM_URL + '/' + room.rentalroomId, data: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data > 0) {
        return 'Edit Successfully';
      } else {
        return 'Edit Failed';
      }
    }
    throw Exception('Network failed');
  }
  Future<String> addRentalroomDio(File imageFile, Rentalroom room) async {
    FormData data = FormData.fromMap({
      'rentalroom_name': room.rentalroomName,
      'rentalroom_price': room.rentalroomPrice,
      'rentalroom_phone': room.rentalroomPhone,
      'picture': room.picture,
      //'game_img': game.gameImg,

      if (imageFile != null)
        'picture': 'has_image'
      else
        'picture': 'no_image',
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });
    try {
      final response = await _dio.post(API.BASE_URL + API.RENTALROOM_URL, data: data);
      print(response);
      if (response != null) {
        if (response.statusCode == 200) {
          print(response.data);
          if (response.data > 0) {
            return 'Add Successfully';
          } else {
            return 'Add Failed';
          }
        }
      } else {
        print('response is nulllllll');
      }
    } catch (DioError) {
      print('Exception --> response is nulllllll');
      print(DioError.toString());
      throw DioError();
    }
  }
  Future<String> deletRentalroomDio(String id) async {
    print(API.BASE_URL + API.RENTALROOM_URL + '/' + id);
    final response = await _dio.delete(API.BASE_URL + API.RENTALROOM_URL + '/' + id);

    if (response.statusCode == 200) {
      if (response.data > 0) {
        return 'Delete Successfully';
      } else {
        return 'Delete Failed';
      }
    }
    throw Exception('Network failed');
  } //end
} //
