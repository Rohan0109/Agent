import 'dart:async';
import 'dart:convert';

import 'package:Mugavan/models/assembly.dart';
import 'package:Mugavan/models/booth.dart';
import 'package:Mugavan/models/district.dart';
import 'package:Mugavan/models/localbody.dart';
import 'package:Mugavan/models/message.dart';
import 'package:Mugavan/models/parliament.dart';
import 'package:Mugavan/models/party.dart';
import 'package:Mugavan/models/province.dart';
import 'package:Mugavan/models/taluk.dart';
import 'package:Mugavan/models/voter.dart';
import 'package:Mugavan/models/ward.dart';
import 'package:Mugavan/utils/constant.dart';
import 'package:Mugavan/utils/shared.dart';
import 'package:http/http.dart' as http;

import '../models/activity.dart';
import '../models/country.dart';

class RemoteService {
  final client = http.Client();

  Future<bool> createAccount(Map<String, dynamic> data) async {
    try {
      final response = await client.post(
          Uri.parse('${Constant.url}/v1/addAgent'),
          body: json.encode(data),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return true;
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> authOTP(Map<String, dynamic> data) async {
    try {
      final response = await client.patch(
          Uri.parse('${Constant.url}/v1/agentAuth'),
          body: json.encode(data),
          headers: Constant.headers);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Country>> getCountries() async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/country?id=105'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return countryFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Province>> getProvinces() async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/state?id=30'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return provinceFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<District>> getDistricts() async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/district?stateId=30'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return districtFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Taluk>> getTaluks(districtId) async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/taluk?districtId=$districtId'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return talukFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Parliament>> getParliaments(districtId) async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/parliament?districtId=$districtId'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return parliamentFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Assembly>> getAssemblies(districtId) async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/assembly?districtId=$districtId'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return assemblyFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Localbody>> getLocalbodies(districtId) async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/localbody?districtId=$districtId'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return localbodyFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Ward>> getWards(localbodyId) async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/ward?localbodyId=$localbodyId'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return wardFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Booth>> getBooths(Ward ward) async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/booth?wardId=${ward.id}'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return boothFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Voter>> getVoter(String voterId) async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/voter?voterId=$voterId'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return voterFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Voter>> getVoterWithPhone(String phone) async {
    try {
      final response = await client.get(
          Uri.parse('${Constant.url}/v1/voter?phone=$phone'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return voterFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createAgent(Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      final response = await client.patch(
          Uri.parse('${Constant.url}/v1/createAgent'),
          body: json.encode(data),
          headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Voter>> getUnassingedVotersWithWard() async {
    try {
      Voter voter = await Shared.getData();
      print(voter.wardId);
      final response = await client.get(
          Uri.parse(
              '${Constant.url}/v1/voter?wardId=${voter.wardId}&isTaken=false&isAgent=false'),
          headers: Constant.headers);
      if (response.statusCode == 200) {
        return voterFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> assignVoters(Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      var response = await client.patch(
          Uri.parse('${Constant.url}/v1/assing-me'),
          body: json.encode(data),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> unAssignVoters(Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      var response = await client.patch(
          Uri.parse('${Constant.url}/v1/resign-me'),
          body: json.encode(data),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Voter>> getAassingedVotersWithWard() async {
    try {
      Map<String, String> headers = Constant.headers;

      await Shared.getAccessToken()
          .then((value) => {headers['accessToken'] = value});
      var response = await client
          .get(Uri.parse('${Constant.url}/v1/getMyVoters'), headers: headers);
      if (response.statusCode == 200) {
        return voterFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Activity>> getVoterActivity(var id) async {
    try {
      Map<String, String> headers = Constant.headers;

      var response = await client.get(
          Uri.parse('${Constant.url}/v1/voteractivity?voterId=$id'),
          headers: headers);
      if (response.statusCode == 200) {
        return activityFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createVoterActivity(Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      var response = await client.post(
          Uri.parse('${Constant.url}/v1/create-voter-activity'),
          body: json.encode(data),
          headers: headers);
      if (response.statusCode == 201) {
        return true;
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateVoterActivity(Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      var response = await client.patch(
          Uri.parse('${Constant.url}/v1/update-voter-activity'),
          body: json.encode(data),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Voter>> getAgent() async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      var response = await client.get(Uri.parse('${Constant.url}/v1/get-agent'),
          headers: headers);
      if (response.statusCode == 200) {
        return voterFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Party>> getParties() async {
    try {
      Map<String, String> headers = Constant.headers;
      var response = await client.get(
          Uri.parse('${Constant.url}/v1/electionparties'),
          headers: headers);
      if (response.statusCode == 200) {
        return partyFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createVoter(Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      var response = await client.post(
          Uri.parse('${Constant.url}/v1/create-voter'),
          body: json.encode(data),
          headers: headers);
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateVoter(Map<String, dynamic> data) async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      var response = await client.patch(
          Uri.parse('${Constant.url}/v1/update-voter'),
          body: json.encode(data),
          headers: headers);
      if (response.statusCode == 200) {
        return true;
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Message>> getMessages(int id) async {
    try {
      Map<String, String> headers = Constant.headers;
      headers['accessToken'] = await Shared.getAccessToken();
      var response = await client.get(
          Uri.parse('${Constant.url}/v1/get-voter-message?id=$id'),
          headers: headers);
      if (response.statusCode == 200) {
        return messageFromJson(response.body);
      }
      throw 'StatusCode : ${response.statusCode}, message : ${response.body.toString()}';
    } catch (e) {
      rethrow;
    }
  }
}
