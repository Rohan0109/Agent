import 'dart:async';
import 'dart:convert';

import 'package:agent_login/service/people_json.dart';
import 'package:agent_login/shared_pref.dart';
import 'package:http/http.dart' as http;

import 'display_peoples.dart';

class RemoteService {
  display_people() async {
    var client = http.Client();
    var accessToken = await Share_pref().get_accessToken();

    var uri = Uri.parse(
        'https://dev-sangam.gateway.apiplatform.io/v1/getAssignedPeople');

    var response = await client.get(uri, headers: {
      "pkey": "3fdabdac7be3f1483fd675c4334d4a72",
      "apikey": " 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH",
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    if (response.statusCode == 200) {
      var json = response.body;
      print("json");
      print(json);
      return displayFromJson(json);
    }
  }

  assignpeople(List<int> ids) async {
    var accessToken = await Share_pref().get_accessToken();
    Map data = {"peopleIdList": ids};
    var client = http.Client();
    var body = json.encode(data);
    var uri = Uri.parse(
        'https://dev-sangam.gateway.apiplatform.io/v1/assignAgentForPeople');

    var response = await client.patch(uri, body: body, headers: {
      "pkey": " 3fe5847e511aafce3fe2d16bbd581823",
      "apikey": " 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH",
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }

  Future<List<People>?> getpeople() async {
    var client = http.Client();
    var accessToken = await Share_pref().get_accessToken();

    var uri =
        Uri.parse('https://dev-sangam.gateway.apiplatform.io/v1/getWardPeople');

    var response = await client.get(uri, headers: {
      "pkey": "3fdabdac7be3f1483fd675c4334d4a72",
      "apikey": " 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH",
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    if (response.statusCode == 200) {
      var json = response.body;
      print("people");
      return peopleFromJson(json);
    }
  }

  Future<Map<String, dynamic>?> getprofile() async {
    var client = http.Client();
    var accessToken = await Share_pref().get_accessToken();

    var uri =
        Uri.parse('https://dev-sangam.gateway.apiplatform.io/v1/getAgent');

    var response = await client.get(uri, headers: {
      "pkey": "3fdabdac7be3f1483fd675c4334d4a72",
      "apikey": " 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH",
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    if (response.statusCode == 200) {
      var json_data = json.decode(response.body);

      return json_data["data"];
    }
  }

  get_otp(var phone) async {
    Map data = {"phoneNumber": phone};
    var client = http.Client();
    var body = json.encode(data);
    var uri =
        Uri.parse('https://dev-sangam.gateway.apiplatform.io/v1/addAgent');
    var response = await client.post(uri, body: body, headers: {
      "pkey": " 3fe5847e511aafce3fe2d16bbd581823",
      "apikey": " 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH",
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  auth_otp(var phone, var otp) async {
    Map data = {"otp": otp, "phoneNumber": phone};

    var client = http.Client();
    var body = json.encode(data);
    var uri =
        Uri.parse('https://dev-sangam.gateway.apiplatform.io/v1/agentAuth');
    var response = await client.patch(uri, body: body, headers: {
      "pkey": " 3fe5847e511aafce3fe2d16bbd581823",
      "apikey": " 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH",
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      var mapobject = jsonDecode(response.body);

      Share_pref().shared_preferences(
          mapobject["data"]["phoneNumber"],
          mapobject["data"]["isAuthorized"],
          mapobject["data"]["accessToken"],
          mapobject["data"]["id"]);
      return true;
    } else {
      return false;
    }
  }

  update_profile(var name, var country, var state, var district, var taluk,
      var email, var subward, var ward) async {
    var accessToken = await Share_pref().get_accessToken();
    Map data = {
      "name": name,
      "subWard": subward,
      "ward": ward,
      "country": country.split(" ")[1],
      "state": state,
      "district": district,
      "taluk": taluk,
      "email": email

      /*  "name":"rohan",
       "subWard" :"NEE",
       "ward":"east",
       "country":"india",
       "state":"tamilnadu",
       "district":"trichy",
       "taluk":"asw",
       "email":"rohan@gmail.com"*/
    };
    var client = http.Client();
    var body = json.encode(data);
    var uri =
        Uri.parse('https://dev-sangam.gateway.apiplatform.io/v1/updateAgent');

    var response = await client.patch(uri, body: body, headers: {
      "pkey": " 3fe5847e511aafce3fe2d16bbd581823",
      "apikey": " 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH",
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }

  updatePeopleStatus(var id, var status, var percentage) async {
    var accessToken = await Share_pref().get_accessToken();
    Map data = {
      "peopleId": id,
      "status": status,
      "statusPercentage": percentage
    };
    var client = http.Client();
    var body = json.encode(data);
    var uri = Uri.parse(
        'https://dev-sangam.gateway.apiplatform.io/v1/updatePeopleStatus');

    var response = await client.patch(uri, body: body, headers: {
      "pkey": " 3fe5847e511aafce3fe2d16bbd581823",
      "apikey": " 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH",
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }
}
