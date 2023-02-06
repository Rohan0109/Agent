import 'package:Mugavan/models/assembly.dart';
import 'package:Mugavan/models/booth.dart';
import 'package:Mugavan/models/district.dart';
import 'package:Mugavan/models/localbody.dart';
import 'package:Mugavan/models/parliament.dart';
import 'package:Mugavan/models/taluk.dart';
import 'package:Mugavan/models/ward.dart';
import 'package:Mugavan/screens/new_voter.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class NewProfile extends StatefulWidget {
  const NewProfile({super.key});

  @override
  _NewProfileState createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  RemoteService remoteService = RemoteService();

  bool isLoading = true;
  bool _isTalukLoading = false;
  bool _isParliamentLoading = false;
  bool _isAssemblyLoading = false;
  bool _isLocalbodyLoading = false;
  bool _isWardLoading = false;
  bool _isBoothLoading = false;

  List<District> _districts = [
    District(
        createdAt: 1,
        code: 1,
        district:
            DistrictClass(en: '--Select District --', ta: '-- மாவட்டம் --'),
        stateId: 0,
        countryId: 0,
        updatedAt: 0,
        id: 0)
  ];

  List<Taluk> _taluks = [
    Taluk(
        taluk: TalukClass(en: '--Select Taluk --', ta: '-- தாலுகா --'),
        assemblyId: 0,
        parliamentId: 0,
        districtId: 0,
        stateId: 0,
        country: 0,
        createdAt: 0,
        updatedAt: 0,
        code: 0,
        id: 0)
  ];

  List<Parliament> _parliaments = [
    Parliament(
        parliamentNo: 0,
        parliamentName: ParliamentName(
            en: '--Select Parliament --', ta: '-- பாராளுமன்றம் --'),
        typeOfParliament: 'none',
        districtId: 0,
        stateId: 0,
        countryId: 0,
        createdAt: 0,
        updatedAt: 0,
        id: 0)
  ];

  List<Assembly> _assemblies = [
    Assembly(
        assemblyNo: 0,
        assembly:
            AssemblyClass(en: '--Select Assembly --', ta: '-- சட்டசபை --'),
        typeOfAssembly: 'none',
        parliamentId: 0,
        districtId: 0,
        stateId: 0,
        countryId: 0,
        createdAt: 0,
        updatedAt: 0,
        id: 0)
  ];

  List<Localbody> _localbodies = [
    Localbody(
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
        code: 0)
  ];

  List<Ward> _wards = [
    Ward(
        wardNo: 0,
        localbodyId: 0,
        talukId: 0,
        assemblyId: 0,
        parliamentId: 0,
        districtId: 0,
        stateId: 0,
        countryId: 0,
        createdAt: 0,
        updatedAt: 0,
        id: 0)
  ];

  List<Booth> _booths = [
    Booth(
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
        id: 0)
  ];

  // Country? _country;
  // Province? _province;
  District? _district;
  Taluk? _taluk;
  Parliament? _parliament;
  Assembly? _assembly;
  Localbody? _localbody;
  Ward? _ward;
  Booth? _booth;

  bool isCountrySelected = true;
  bool isStateSelected = true;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getDistricts();
    _taluk = _taluks[0];
    _parliament = _parliaments[0];
    _assembly = _assemblies[0];
    _localbody = _localbodies[0];
    _ward = _wards[0];
    _booth = _booths[0];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constant.appAccount,
              style: TextStyle(fontSize: 18.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'நாடு : இந்தியா',
                  style: TextStyle(fontSize: 10.0),
                ),
                Text(
                  'மாநிலம் : தமிழ்நாடு',
                  style: TextStyle(fontSize: 10.0),
                )
              ],
            )
          ],
        ),
        centerTitle: false,
        elevation: 1,
      ),
      body: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : showLoading()),
    );
  }

  Widget showLoading() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                validator: (District? value) {
                  if (value == null || value.id == 0) {
                    return '* மாவட்டம் தேவை';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    enabled: true,
                    labelText: 'மாவட்டம்',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
                items: _districts
                    ?.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.district.ta.toString()),
                        ))
                    .toList(),
                value: _district,
                isDense: true,
                isExpanded: true,
                hint: Text(
                  'உங்கள் மாவட்டத்தைத் தேர்ந்தெடுக்கவும்',
                ),
                onChanged: (District? value) {
                  if (value?.id != 0) {
                    getTaluks(value?.id);
                    getParliaments(value?.id);
                    getAssemblies(value?.id);
                    getLocalbodies(value?.id);
                  }
                },
              ),
              SizedBox(height: 14),
              Container(
                  child: _isTalukLoading
                      ? Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField(
                          validator: (Taluk? value) {
                            if (value == null || value.id == 0) {
                              return '* தாலுகா தேவை';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'தாலுகா',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          items: _taluks
                              ?.map((e) => DropdownMenuItem(
                                    enabled: true,
                                    value: e,
                                    child: Text(e.taluk.ta.toString()),
                                  ))
                              .toList(),
                          value: _taluk,
                          isDense: true,
                          isExpanded: true,
                          hint: Text(
                            'உங்கள் தாலுகாவைத் தேர்ந்தெடுக்கவும்',
                          ),
                          onChanged: (Object? value) {},
                        )),
              SizedBox(height: 14),
              Container(
                  child: _isParliamentLoading
                      ? Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField(
                          validator: (Parliament? value) {
                            if (value == null || value.id == 0) {
                              return '* பாராளுமன்றம் தேவை';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'பாராளுமன்றம்',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          items: _parliaments
                              ?.map((e) => DropdownMenuItem(
                                    enabled: true,
                                    value: e,
                                    child: Text(e.parliamentName.ta.toString()),
                                  ))
                              .toList(),
                          value: _parliament,
                          isDense: true,
                          isExpanded: true,
                          hint: Text(
                            'உங்கள் பாராளுமன்றத்தை தேர்ந்தெடுங்கள்',
                          ),
                          onChanged: (Object? value) {},
                        )),
              SizedBox(
                height: 14,
              ),
              Container(
                  child: _isAssemblyLoading
                      ? Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField(
                          validator: (Assembly? value) {
                            if (value == null || value.id == 0) {
                              return '* சட்டசபை தேவை';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'சட்டசபை',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          items: _assemblies
                              ?.map((e) => DropdownMenuItem(
                                    enabled: true,
                                    value: e,
                                    child: Text(e.assembly.ta.toString()),
                                  ))
                              .toList(),
                          value: _assembly,
                          isDense: true,
                          isExpanded: true,
                          hint: Text(
                            'உங்கள் சட்டசபையைத் தேர்ந்தெடுக்கவும்',
                          ),
                          onChanged: (Object? value) {},
                        )),
              SizedBox(
                height: 14,
              ),
              Container(
                  child: _isLocalbodyLoading
                      ? Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField(
                          validator: (Localbody? value) {
                            if (value == null || value.id == 0) {
                              return '* உள்ளாட்சி தேவை';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'உள்ளாட்சி',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          items: _localbodies
                              ?.map((e) => DropdownMenuItem(
                                    enabled: true,
                                    value: e,
                                    child: Text(e.localbody.ta.toString()),
                                  ))
                              .toList(),
                          value: _localbody,
                          isDense: true,
                          isExpanded: true,
                          hint: Text(
                            'உங்கள் உள்ளாட்சியைத் தேர்ந்தெடுக்கவும்',
                          ),
                          onChanged: (Localbody? value) {
                            if (value?.id != 0) {
                              getWards(value?.id);
                            }
                          },
                        )),
              SizedBox(
                height: 14,
              ),
              Container(
                  child: _isWardLoading
                      ? Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField(
                          validator: (Ward? value) {
                            if (value == null || value.id == 0) {
                              return '* வார்டு தேவை';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'வார்டு',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          items: _wards
                              ?.map((e) => DropdownMenuItem(
                                    enabled: true,
                                    value: e,
                                    child: Text(e.wardNo.toString()),
                                  ))
                              .toList(),
                          value: _ward,
                          isDense: true,
                          isExpanded: true,
                          hint: Text(
                            'உங்கள் வார்டைத் தேர்ந்தெடுக்கவும்',
                          ),
                          onChanged: (Ward? value) {
                            _ward = value!;
                            if (value?.id != 0) {
                              getBooths(value!);
                            }
                          },
                        )),
              SizedBox(
                height: 14,
              ),
              Container(
                  child: _isBoothLoading
                      ? Center(child: CircularProgressIndicator())
                      : DropdownButtonFormField(
                          // validator: (Booth? value) {
                          //   if (value == null || value.id == 0) {
                          //     return '* வாக்கு சாவடி தேவை';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'வாக்கு சாவடி',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          items: _booths
                              ?.map((e) => DropdownMenuItem(
                                    enabled: true,
                                    value: e,
                                    child: Text(e.name.ta.toString()),
                                  ))
                              .toList(),
                          value: _booth,
                          isDense: true,
                          isExpanded: true,
                          hint: Text(
                            'உங்கள் வாக்கு சாவடியைத் தேர்ந்தெடுக்கவும்',
                          ),
                          onChanged: (Booth? value) {
                            setState(() {
                              _booth = value;
                            });
                          },
                        )),
              SizedBox(height: 20),
              MaterialButton(
                padding: EdgeInsets.all(16.0),
                minWidth: double.infinity,
                height: 46,
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewVoter(
                                  ward: _ward!,
                                  booth: _booth!,
                                )));
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      Constant.next,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void getDistricts() async {
    try {
      List<District> districts = await remoteService.getDistricts();
      setState(() {
        _districts = List.of(_districts)..addAll(districts);
        _district = _districts[0];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getTaluks(districtId) async {
    setState(() {
      _isTalukLoading = true;
      _taluks.clear();
      _taluks.add(Taluk(
          taluk: TalukClass(en: '--Select Taluk --', ta: '-- தாலுகா --'),
          assemblyId: 0,
          parliamentId: 0,
          districtId: 0,
          stateId: 0,
          country: 0,
          createdAt: 0,
          updatedAt: 0,
          code: 0,
          id: 0));
      _taluk = _taluks[0];
    });
    try {
      List<Taluk> taluks = await remoteService.getTaluks(districtId);
      setState(() {
        _taluks = List.of(_taluks)..addAll(taluks);
        _isTalukLoading = false;
      });
    } catch (e) {
      setState(() {
        _isTalukLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getParliaments(districtId) async {
    setState(() {
      _isParliamentLoading = true;
      _parliaments.clear();
      _parliaments.add(Parliament(
          parliamentNo: 0,
          parliamentName: ParliamentName(
              en: '--Select Parliament --', ta: '-- பாராளுமன்றம் --'),
          typeOfParliament: 'none',
          districtId: 0,
          stateId: 0,
          countryId: 0,
          createdAt: 0,
          updatedAt: 0,
          id: 0));
      _parliament = _parliaments[0];
    });
    try {
      List<Parliament> parliaments =
          await remoteService.getParliaments(districtId);
      setState(() {
        _parliaments = List.of(_parliaments)..addAll(parliaments);
        _isParliamentLoading = false;
      });
    } catch (e) {
      setState(() {
        _isParliamentLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getAssemblies(districtId) async {
    setState(() {
      _isAssemblyLoading = true;
      _assemblies.clear();
      _assemblies.add(Assembly(
          assemblyNo: 0,
          assembly:
              AssemblyClass(en: '--Select Assembly --', ta: '-- சட்டசபை --'),
          typeOfAssembly: 'none',
          parliamentId: 0,
          districtId: 0,
          stateId: 0,
          countryId: 0,
          createdAt: 0,
          updatedAt: 0,
          id: 0));
      _assembly = _assemblies[0];
    });
    try {
      List<Assembly> assemblies = await remoteService.getAssemblies(districtId);
      setState(() {
        _assemblies = List.of(_assemblies)..addAll(assemblies);
        _isAssemblyLoading = false;
      });
    } catch (e) {
      setState(() {
        _isAssemblyLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getLocalbodies(districtId) async {
    setState(() {
      _isLocalbodyLoading = true;
      _localbodies.clear();
      _localbodies.add(Localbody(
          localbody: LocalbodyClass(
              en: '--Select Localbody --', ta: '-- உள்ளாட்சி --'),
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
          code: 0));
      _localbody = _localbodies[0];
    });
    try {
      List<Localbody> localbodies =
          await remoteService.getLocalbodies(districtId);
      setState(() {
        _localbodies = List.of(_localbodies)..addAll(localbodies);
        _isLocalbodyLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLocalbodyLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getWards(localbodyId) async {
    setState(() {
      _isWardLoading = true;
      _wards.clear();
      _wards.add(Ward(
          wardNo: 0,
          localbodyId: 0,
          talukId: 0,
          assemblyId: 0,
          parliamentId: 0,
          districtId: 0,
          stateId: 0,
          countryId: 0,
          createdAt: 0,
          updatedAt: 0,
          id: 0));
      _ward = _wards[0];
    });

    try {
      List<Ward> wards = await remoteService.getWards(localbodyId);
      setState(() {
        _wards = List.of(_wards)..addAll(wards);
        _isWardLoading = false;
      });
    } catch (e) {
      setState(() {
        _isWardLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getBooths(Ward ward) async {
    setState(() {
      _isBoothLoading = true;
      _booths.clear();
      _booths.add(Booth(
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
          id: 0));
      _booth = _booths[0];
    });
    try {
      List<Booth> booths = await remoteService.getBooths(ward);
      setState(() {
        _booths = List.of(_booths)..addAll(booths);
        _isBoothLoading = false;
      });
    } catch (e) {
      setState(() {
        _isBoothLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
