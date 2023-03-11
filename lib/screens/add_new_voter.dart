import 'package:flutter/material.dart';

import '../models/assembly.dart';
import '../models/booth.dart';
import '../models/district.dart';
import '../models/localbody.dart';
import '../models/parliament.dart';
import '../models/taluk.dart';
import '../models/voter.dart';
import '../models/ward.dart';
import '../service/remote_service.dart';
import '../utils/constant.dart';

class AddNewVoter extends StatefulWidget {
  const AddNewVoter({Key? key}) : super(key: key);

  @override
  State<AddNewVoter> createState() => _AddNewVoterState();
}

class _AddNewVoterState extends State<AddNewVoter>
    with AutomaticKeepAliveClientMixin {
  RemoteService _remoteService = RemoteService();

  bool _isLoading = true;
  bool _isTalukLoading = false;
  bool _isParliamentLoading = false;
  bool _isAssemblyLoading = false;
  bool _isLocalbodyLoading = false;
  bool _isWardLoading = false;
  bool _isBoothLoading = false;

  List<District> _districts = [Constant.district];

  List<Taluk> _taluks = [Constant.taluk];

  List<Parliament> _parliaments = [Constant.parliament];

  List<Assembly> _assemblies = [Constant.assembly];

  List<Localbody> _localbodies = [Constant.localbody];

  List<Ward> _wards = [Constant.ward];

  List<Booth> _booths = [Constant.booth];

  Ward? _ward;
  District? _district;
  Taluk? _taluk;
  Parliament? _parliament;
  Assembly? _assembly;
  Localbody? _localbody;
  Booth? _booth;
  Voter? _voter;

  bool isCountrySelected = true;
  bool isStateSelected = true;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController? phoneController;
  TextEditingController? memberIdController;
  TextEditingController? voterIdController;
  TextEditingController? voterNameController;
  TextEditingController? voterFnameController;
  TextEditingController? doorNoController;
  TextEditingController? ageController;
  TextEditingController? motherTongueController;
  TextEditingController? casteController;
  TextEditingController? emailController;

  final List<String> _sex = ['ஆண்', 'பெண்', 'மூன்றாம் பாலினத்தவர்'];
  final List<String> _eSex = ['male', 'female', 'transgender'];

  final List<String> _sential = ['தந்தை', 'கணவர்'];

  String _selectSex = 'ஆண்';
  String _selectSential = 'தந்தை';

  bool _isVoterGeoLocationExpansion = false;

  @override
  void initState() {
    getDistricts();
    _taluk = _taluks[0];
    _parliament = _parliaments[0];
    _assembly = _assemblies[0];
    _localbody = _localbodies[0];
    _ward = _wards[0];
    _booth = _booths[0];

    phoneController = TextEditingController();
    memberIdController = TextEditingController();
    voterIdController = TextEditingController();
    voterNameController = TextEditingController();
    voterFnameController = TextEditingController();
    doorNoController = TextEditingController();
    ageController = TextEditingController();
    motherTongueController = TextEditingController();
    casteController = TextEditingController();
    emailController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'புதிய வாக்காளர்',
              style: TextStyle(fontSize: 18.0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          child:
              _isLoading ? Center(child: CircularProgressIndicator()) : body()),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExpansionTile(
                maintainState: true,
                initiallyExpanded: _isVoterGeoLocationExpansion,
                title: Text('வாக்காளரின் இருப்பிட தகவல்'),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: DropdownButtonFormField(
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
                          .map((e) => DropdownMenuItem(
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
                                        child: Text(
                                            e.parliamentName.ta.toString()),
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
                                  getWards(value?.id ?? 0);
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
                                        child: Text(e.ward.ta.toString()),
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
                  Visibility(
                    visible: false,
                    child: Container(
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
                                        borderRadius:
                                            BorderRadius.circular(8))),
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
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ExpansionTile(
                maintainState: true,
                initiallyExpanded: true,
                title: Text('வாக்காளரின் அத்யாவசிய  தகவல்'),
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'வாக்காளரின் பெயர் தேவை';
                      } else {
                        return null;
                      }
                    },
                    controller: voterNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'வாக்காளரின் பெயர்',
                      hintText: 'வாக்காளரின் பெயரை பதிவிடவும்',
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    maxLength: 10,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 10) {
                        return 'வாக்காளர் எண் தேவை';
                      } else {
                        return null;
                      }
                    },
                    controller: voterIdController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'வாக்காளர் என்னை பதிவிடவும்',
                        labelText: 'வாக்காளர் எண்'),
                    onChanged: (value) {
                      if (value.length == 10) {
                        // getVoterDetails(value.toUpperCase().toString());
                      }
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'வாக்காளரின் வயது',
                      hintText: 'வாக்காளரின் வயதை பதிவிடவும்',
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return '* பாலினம் தேவை';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        enabled: true,
                        labelText: 'பாலினம்',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    items: _sex
                        ?.map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    value: _selectSex,
                    isDense: true,
                    isExpanded: true,
                    hint: Text(
                      'உங்கள் பாலினத்தைத் தேர்ந்தெடுக்கவும்',
                    ),
                    onChanged: (String? value) {},
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: voterFnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'வாக்காளரின் தந்தை/கணவர் பெயர்',
                      hintText: 'வாக்காளரின் தந்தை/கணவர் பெயரை பதிவிடவும்',
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                        enabled: true,
                        labelText: 'தந்தை/கணவர்',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    items: _sential
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    value: _selectSential,
                    isDense: true,
                    isExpanded: true,
                    hint: Text(
                      'தந்தை/கணவர் தேர்ந்தெடுக்கவும்',
                    ),
                    onChanged: (String? value) {
                      _selectSential = value!;
                    },
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                      maxLength: 10,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty || value.length != 10) {
                      //     return 'அலைபேசி எண் தேவை';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: 'அலைபேசி எண்னை பதிவிடவும்',
                          labelText: 'அலைபேசி எண்',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)))),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(height: 20),
              ExpansionTile(
                maintainState: true,
                title: Text('வாக்காளரின்  கூடுதல் தகவல்'),
                children: [
                  TextFormField(
                      controller: memberIdController,
                      decoration: InputDecoration(
                          hintText: 'கட்சியின் உறுப்பினர் எண்னை பதிவிடவும்',
                          labelText: 'கட்சியின் உறுப்பினர் எண்',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)))),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: doorNoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'வீட்டு எண்ணை பதிவிடவும்',
                        labelText: 'வீட்டு எண்'),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: motherTongueController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'தாய்மொழியைப் பதிவிடவும்',
                        labelText: 'தாய்மொழி'),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: casteController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'குடியைப் பதிவிடவும்',
                        labelText: 'குடி'),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'மின்னஞ்சல் முகவரியைப் பதிவிடவும்',
                        labelText: 'மின்னஞ்சல் முகவரி'),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                padding: EdgeInsets.all(16.0),
                minWidth: double.infinity,
                height: 46,
                color: Constant.primeColor,
                textColor: Colors.white,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    createVoter();
                  } else {
                    setState(() {
                      _isVoterGeoLocationExpansion = true;
                    });
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      Constant.submit,
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
      List<District> districts = await _remoteService.getDistricts();
      setState(() {
        _districts = List.of(_districts)..addAll(districts);
      });
      getAgent();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getAgent() async {
    try {
      List<Voter> voters = await _remoteService.getAgent();
      if (voters.isNotEmpty) {
        for (var i = 0; i < _districts.length; i++) {
          if (voters[0].districtId == _districts[i].id) {
            setState(() {
              _voter = voters[0];
              _district = _districts[i];
              _isLoading = false;
            });
            getTaluks(_districts[i].id);
            getParliaments(_districts[i].id);
            getAssemblies(_districts[i].id);
            getLocalbodies(_districts[i].id);
            break;
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getTaluks(districtId) async {
    setState(() {
      _isTalukLoading = true;
      _taluks.clear();
      _taluks.add(Constant.taluk);
      _taluk = _taluks[0];
    });
    try {
      List<Taluk> taluks = await _remoteService.getTaluks(districtId);
      setState(() {
        _taluks = List.of(_taluks)..addAll(taluks);
        _isTalukLoading = false;
        for (var i = 0; i < _taluks.length; i++) {
          if (_voter?.talukId == _taluks[i].id) {
            _taluk = _taluks[i];
            break;
          }
        }
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
      _parliaments.add(Constant.parliament);
      _parliament = _parliaments[0];
    });
    try {
      List<Parliament> parliaments =
          await _remoteService.getParliaments(districtId);
      setState(() {
        _parliaments = List.of(_parliaments)..addAll(parliaments);
        _isParliamentLoading = false;
        for (var i = 0; i < _parliaments.length; i++) {
          if (_voter?.parliamentId == _parliaments[i].id) {
            _parliament = _parliaments[i];
            break;
          }
        }
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
      _assemblies.add(Constant.assembly);
      _assembly = _assemblies[0];
    });
    try {
      List<Assembly> assemblies =
          await _remoteService.getAssemblies(districtId);
      setState(() {
        _assemblies = List.of(_assemblies)..addAll(assemblies);
        _isAssemblyLoading = false;
        for (var i = 0; i < _assemblies.length; i++) {
          if (_voter?.assemblyId == _assemblies[i].id) {
            _assembly = _assemblies[i];
            break;
          }
        }
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
      _localbodies.add(Constant.localbody);
      _localbody = _localbodies[0];
    });
    try {
      List<Localbody> localbodies =
          await _remoteService.getLocalbodies(districtId);
      setState(() {
        _localbodies = List.of(_localbodies)..addAll(localbodies);
        _isLocalbodyLoading = false;
        for (var i = 0; i < _localbodies.length; i++) {
          if (_voter?.localbodyId == _localbodies[i].id) {
            _localbody = _localbodies[i];
            getWards(_localbody?.id ?? 0);
            break;
          }
        }
      });
    } catch (e) {
      setState(() {
        _isLocalbodyLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getWards(int localbodyId) async {
    setState(() {
      _isWardLoading = true;
      _wards.clear();
      _wards.add(Constant.ward);
      _ward = _wards[0];
    });
    try {
      List<Ward> wards = await _remoteService.getWards(localbodyId);
      setState(() {
        _wards = List.of(_wards)..addAll(wards);
        _isWardLoading = false;
        for (var i = 0; i < _wards.length; i++) {
          if (_voter?.wardId == _wards[i].id) {
            _ward = _wards[i];
            break;
          }
        }
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
      _booths.add(Constant.booth);
      _booth = _booths[0];
    });
    try {
      List<Booth> booths = await _remoteService.getBooths(ward);
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

  void createVoter() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> data = {
      'name': {
        'en': voterNameController?.text.toString().toLowerCase(),
        'ta': voterNameController?.text.toString().toLowerCase()
      },
      'isFather': (_selectSential.toString() == 'தந்தை') ? true : false,
      'sex':
          _eSex[_sex.indexOf(_selectSex.toString())].toString().toLowerCase(),
      'wardId': _ward?.id,
      'talukId': _ward?.talukId,
      'localbodyId': _ward?.localbodyId,
      'assemblyId': _ward?.assemblyId,
      'parliamentId': _ward?.parliamentId,
      'districtId': _ward?.districtId,
      'stateId': _ward?.stateId,
      'countryId': _ward?.countryId,
    };

    if (voterFnameController?.text.toString() != null) {
      data['sentinal'] = {
        'en': voterFnameController?.text.toString().toLowerCase(),
        'ta': voterFnameController?.text.toString().toLowerCase()
      };
    }
    if (voterIdController?.text.toString() != null) {
      data['voterId'] = voterIdController?.text.toString().toUpperCase();
    }
    if (ageController?.text.toString() != null &&
        (ageController?.text?.length)!! > 0) {
      data['age'] = int.parse((ageController?.text.toString())!);
    }
    if (doorNoController?.text.toString() != null) {
      data['doorNo'] = doorNoController?.text.toString();
    }
    if (_booth?.id != 0) {
      data['boothId'] = _booth?.id;
    }
    if ((memberIdController?.text.toString())!.isNotEmpty) {
      data['memberId'] = memberIdController?.text.toString();
    }
    if (phoneController?.text.toString() != null) {
      data['phone'] = phoneController?.text.toString();
    }
    if (motherTongueController?.text.toString() != null) {
      data['motherTongue'] = motherTongueController?.text.toString();
    }
    if (casteController?.text.toString() != null) {
      data['caste'] = casteController?.text.toString();
    }
    if (emailController?.text.toString() != null) {
      data['email'] = emailController?.text.toString();
    }

    try {
      Map<String, dynamic> response = await _remoteService.addNewVoter(data);
      Navigator.pop(context);
    } catch (e) {
      _updateSuccessMessage(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
