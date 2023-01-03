import 'dart:async';
import 'dart:convert';

import 'package:Mugavan/models/agent.dart';
import 'package:Mugavan/utils/Constant.dart';
import 'package:Mugavan/utils/shared.dart';
import 'package:http/http.dart' as http;

import '../models/People.dart';
import '../models/Troop.dart';

class RemoteService {
  static var client = http.Client();

  // display_people() async {
  //   var client = http.Client();
  //   var accessToken = await Share_pref().get_accessToken();
  //
  //   var uri = Uri.parse(
  //       'https://dev-sangam.gateway.apiplatform.io/v1/getAssignedPeople');
  //
  //   var response = await client.get(uri, headers: {
  //     'pkey': '3fdabdac7be3f1483fd675c4334d4a72',
  //     'apikey': ' 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH',
  //     'Content-Type': 'application/json',
  //     'accessToken': accessToken
  //   });
  //
  //   if (response.statusCode == 200) {
  //     var json = response.body;
  //     print('json');
  //     print(json);
  //     return displayFromJson(json);
  //   }
  // }

  static Future<bool> createAccount(Map<String, String> data) async {
    var response = await client.post(Uri.parse('${Constant.url}/v1/addAgent'),
        body: json.encode(data), headers: Constant.headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> authOTP(
      Map<String, dynamic> data) async {
    var response = await client.patch(Uri.parse('${Constant.url}/v1/agentAuth'),
        body: json.encode(data), headers: Constant.headers);
    if (response.statusCode == 201) {
      await Shared.setShared(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  static Future<Agent?> getAgent() async {
    Map<String, String> headers = Constant.headers;
    headers['accessToken'] = await Shared.getAccessToken();
    var response = await client.get(Uri.parse('${Constant.url}/v1/getAgent'),
        headers: headers);
    if (response.statusCode == 200) {
      return agentFromJson(response.body).elementAt(0);
    } else {
      return null;
    }
  }

  static Future<bool?> updateAgent(Map<String, dynamic> data) async {
    Map<String, String> headers = Constant.headers;
    headers['accessToken'] = await Shared.getAccessToken();
    var response = await client.patch(
        Uri.parse('${Constant.url}/v1/updateAgent'),
        body: json.encode(data),
        headers: headers);
    if (response.statusCode == 200) {
      await Shared.updatedSession();
      return true;
    } else {
      return null;
    }
  }

  static Future<List<Troop>?> getTroops() async {
    Map<String, String> headers = Constant.headers;
    headers['accessToken'] = await Shared.getAccessToken();
    var response = await client.get(
        Uri.parse('${Constant.url}/v1/getAssignedPeople'),
        headers: headers);
    if (response.statusCode == 200) {
      return troopFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<bool?> updateTroop(Map<String, dynamic> data) async {
    Map<String, String> headers = Constant.headers;
    headers['accessToken'] = await Shared.getAccessToken();
    var response = await client.patch(
        Uri.parse('${Constant.url}/v1/update-troop'),
        body: json.encode(data),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }

  static Future<List<People>?> getPeoples() async {
    Map<String, String> headers = Constant.headers;
    headers['accessToken'] = await Shared.getAccessToken();
    var response = await client
        .get(Uri.parse('${Constant.url}/v1/getWardPeople'), headers: headers);
    if (response.statusCode == 200) {
      return peopleFromJson(response.body);
    } else {
      return null;
    }
  }

  static Future<bool?> assignPeoples(Map<String, dynamic> data) async {
    Map<String, String> headers = Constant.headers;
    headers['accessToken'] = await Shared.getAccessToken();
    var response = await client.patch(
        Uri.parse('${Constant.url}/v1/assignAgentForPeople'),
        body: json.encode(data),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return null;
    }
  }
}
