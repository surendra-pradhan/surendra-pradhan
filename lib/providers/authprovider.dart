import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myshop/helpers/httpexception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _userToken;

  bool get authenticate {
    return _userToken != null;
  }

  Future<void> signUp(String name, String email, String password, int mobile,
      String refralCode) async {
    var headers = {'Cookie': 'PHPSESSID=ac244d6d5b97c35525074b31f6500682'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://capsodisha.com/phoenixKart/sapi312/webservice.php?method=userRegistration'));
    request.fields.addAll({
      'name': name,
      'mobile': mobile.toString(),
      'email': email,
      'password': password,
      'referal_code': ''
    });

    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      final responsedata = await response.stream.bytesToString();

      final res = json.decode(responsedata);
      print(res);

      if (response.statusCode != 200) {
        throw HttpException(res['err_msg']);
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("userToken", json.encode(res));
    } catch (err) {
      throw err;
    }

    // } catch (err) {
    //   throw err;
    // }
  }

  Future<void> signIn(String username, String password) async {
    var headers = {'Cookie': 'PHPSESSID=8c17b3687d906934f7a0d425492b46f7'};
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://capsodisha.com/phoenixKart/sapi312/webservice.php?method=getLoginDetails'));
    request.fields
        .addAll({'email': username, 'password': password, 'fcm_id': ''});

    request.headers.addAll(headers);
    try {
      http.StreamedResponse response = await request.send();

      final responsedata = await response.stream.bytesToString();

      final res = json.decode(responsedata);
      print(res['token_id']);
      _userToken = res['token_id'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("userToken", json.encode(res));
      if (response.statusCode != 200) {
        throw HttpException(res['err_msg']);
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> tryAutoLogin() async {
    print('hiiii');
    try {
      final prefs = await SharedPreferences.getInstance();

      final extractedData = json.decode(prefs.getString('userToken'));

      _userToken = extractedData['token_id'];

      print(extractedData);
      notifyListeners();
    } catch (er) {
      print(er);
    }
  }

  Future<void> logOut() async {
    _userToken = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
