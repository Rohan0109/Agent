import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/assembly.dart';
import '../models/booth.dart';
import '../models/district.dart';
import '../models/localbody.dart';

import '../models/parliament.dart';
import '../models/taluk.dart';
import '../models/ward.dart';

class Constant {
  // static const url = 'https://dev-sangam.gateway.apiplatform.io';
  // static Map<String, String> headers = {
  //   'pkey': ' 3fe5847e511aafce3fe2d16bbd581823',
  //   'apikey': ' 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH',
  //   'Content-Type': 'application/json',
  // };
  static const url = 'https://sangam.gateway.apiplatform.io';
  static Map<String, String> headers = {
    'pkey': ' 3fe5847e511aafce3fe2d16bbd581823',
    'apikey': ' 0tF4kEqjlaKiGeZfN1vOSoSMtwHRqdNH',
    'Content-Type': 'application/json',
  };
  static const duration = 1;

  static const limit = 3;

  static const appColor = 0xFF0000FF;

  static const Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  static const MaterialColor primeColor = MaterialColor(appColor, color);

  static const MaterialColor cardColor = MaterialColor(0xFFFFFFFF, color);

  static const appName = 'முகவன்';

  static const no = 'இல்லை';

  static const logout = 'வெளியேறு';

  static const appAccount = 'முகவர் கணக்கு';

  static const submit = 'சமர்ப்பி';

  static const voter = 'வாக்காளர்கள்';

  static const join = 'இணை';

  static const account = 'கணக்கு';

  static const next = 'அடுத்து';

  static const boothName = 'வாக்குச்சாவடி';

  static const wardName = 'வார்டு';

  static var district = District(
      createdAt: 1,
      code: 1,
      district: DistrictClass(en: '--Select District --', ta: '-- மாவட்டம் --'),
      stateId: 0,
      countryId: 0,
      updatedAt: 0,
      id: 0);

  static var taluk = Taluk(
      taluk: TalukClass(en: '--Select Taluk --', ta: '-- தாலுகா --'),
      assemblyId: 0,
      parliamentId: 0,
      districtId: 0,
      stateId: 0,
      country: 0,
      createdAt: 0,
      updatedAt: 0,
      code: 0,
      id: 0);

  static var parliament = Parliament(
      parliamentNo: 0,
      parliamentName: ParliamentName(
          en: '--Select Parliament --', ta: '-- பாராளுமன்றம் --'),
      typeOfParliament: 'none',
      districtId: 0,
      stateId: 0,
      countryId: 0,
      createdAt: 0,
      updatedAt: 0,
      id: 0);

  static var assembly = Assembly(
      assemblyNo: 0,
      assembly: AssemblyClass(en: '--Select Assembly --', ta: '-- சட்டசபை --'),
      typeOfAssembly: 'none',
      parliamentId: 0,
      districtId: 0,
      stateId: 0,
      countryId: 0,
      createdAt: 0,
      updatedAt: 0,
      id: 0);

  static var localbody = Localbody(
      localbody:
          LocalbodyClass(en: '--Select Localbody --', ta: '-- உள்ளாட்சி --'),
      type: 'type',
      category: 'category',
      assemblyId: 0,
      parliamentId: 0,
      districtId: 0,
      stateId: 0,
      countryId: 0,
      createdAt: 0,
      updatedAt: 0,
      id: 0,
      code: 0);

  static var ward = Ward(
      ward: WardClass(en: '--Select Ward--', ta: '--வார்டு--'),
      localbodyId: 0,
      talukId: 0,
      assemblyId: 0,
      parliamentId: 0,
      districtId: 0,
      stateId: 0,
      countryId: 0,
      createdAt: 0,
      updatedAt: 0,
      id: 0);

  static var booth = Booth(
      name: Name(en: '--Select Booth--', ta: '-- வாக்கு சாவடி --'),
      boothNo: 0,
      type: 'type',
      address: 'address',
      noOfVoters: 0,
      startingNo: 0,
      endingNo: 0,
      men: 0,
      women: 0,
      transgenders: 0,
      wardId: 0,
      localbodyId: 0,
      talukId: 0,
      assemblyId: 0,
      parliamentId: 0,
      districtId: 0,
      stateId: 0,
      countryId: 0,
      createdAt: 0,
      updatedAt: 0,
      code: '0',
      id: 0);
}
