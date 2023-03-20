import 'package:Mugavan/models/booth.dart';
import 'package:Mugavan/models/voter.dart';
import 'package:Mugavan/screens/splash.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:flutter/material.dart';

import '../models/ward.dart';
import '../utils/constant.dart';
import '../utils/shared.dart';
import 'dashboard.dart';

class CreateVoter extends StatefulWidget {
  final Ward ward;
  final Booth booth;

  const CreateVoter({required this.ward, required this.booth, super.key});

  @override
  State<CreateVoter> createState() => _CreateVoterState();
}

class _CreateVoterState extends State<CreateVoter> {
  bool _isLoading = true;
  bool _isAccountExisting = false;

  RemoteService _remoteService = RemoteService();

  TextEditingController? phoneController;
  TextEditingController? memberIdController;
  TextEditingController? voterIdController;
  TextEditingController? voterNameController;
  TextEditingController? voterFnameController;
  TextEditingController? doorNoController;
  TextEditingController? ageController;

  final List<String> _sex = ['ஆண்', 'பெண்', 'மூன்றாம் பாலினத்தவர்'];
  final List<String> _eSex = ['male', 'female', 'transgender'];

  final List<String> _sential = ['தந்தை', 'கணவர்'];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Voter voter;

  String _selectSex = 'ஆண்';
  String _selectSential = 'தந்தை';

  @override
  void initState() {
    getPhoneNumber();
    phoneController = TextEditingController();
    memberIdController = TextEditingController();
    voterIdController = TextEditingController();
    voterNameController = TextEditingController();
    voterFnameController = TextEditingController();
    doorNoController = TextEditingController();
    ageController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              Constant.appAccount,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 1,
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : showLoading(),
      ),
    );
  }

  Widget showLoading() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                          maxLength: 10,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10) {
                              return 'அலைபேசி எண் தேவை';
                            } else {
                              return null;
                            }
                          },
                          controller: phoneController,
                          decoration: InputDecoration(
                              hintText: 'அலைபேசி எண்னை பதிவிடவும்',
                              labelText: 'அலைபேசி எண்',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)))),
                    ),
                    IconButton(
                        onPressed: () {
                          if ((phoneController?.text.isNotEmpty)! &&
                              (phoneController?.text.length == 10)!) {
                            getVoterDetailsWithPhone((phoneController?.text)!);
                          } else {
                            _updateSuccessMessage(
                                'தங்களின் தொலைபேசி எண்ணை பதிவிடவும்');
                          }
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Constant.primeColor,
                        ))
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
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
                            getVoterDetails(value.toUpperCase().toString());
                          }
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if ((voterIdController?.text.isNotEmpty)!) {
                            getVoterDetails((voterIdController?.text)!);
                          } else {
                            _updateSuccessMessage(
                                'தங்களின் வாக்காளர் எண்ணை பதிவிடவும்');
                          }
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Constant.primeColor,
                        ))
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'வாக்காளரின் வயது தேவை';
                    } else {
                      return null;
                    }
                  },
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
                  height: 20,
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
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'வாக்காளரின் தந்தை/கணவர் பெயர் தேவை';
                    } else {
                      return null;
                    }
                  },
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
                  validator: (value) {
                    if (value == null) {
                      return '* வாக்காளரின் தந்தை/கணவர் தேவை';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabled: true,
                      labelText: 'தந்தை/கணவர்',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  items: _sential
                      ?.map((e) => DropdownMenuItem(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'வீட்டு எண் தேவை';
                    } else {
                      return null;
                    }
                  },
                  controller: doorNoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'வீட்டு எண்ணை பதிவிடவும்',
                      labelText: 'வீட்டு எண்'),
                ),
                SizedBox(height: 20),
                MaterialButton(
                  padding: EdgeInsets.all(16.0),
                  minWidth: double.infinity,
                  height: 46,
                  color: Constant.primeColor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (_isAccountExisting) {
                        createAgent(voter.id);
                      } else {
                        createVoter();
                      }
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
            )),
      ),
    );
  }

  void getPhoneNumber() async {
    Shared.getPhonenumber().then((value) => {
          setState(() {
            phoneController?.text = value;
          }),
          getVoterDetailsWithPhone(phoneController?.text.toString() ?? '')
        });
  }

  void createVoter() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> data = {
      'voterId': voterIdController?.text.toUpperCase(),
      'name': {
        'en': voterNameController?.text.toString().toLowerCase(),
        'ta': voterNameController?.text.toString().toLowerCase()
      },
      'sentinal': {
        'en': voterFnameController?.text.toString().toLowerCase(),
        'ta': voterFnameController?.text.toString().toLowerCase()
      },
      'doorNo': doorNoController?.text.toString().toLowerCase(),
      'age': int.parse((ageController?.text.toString())!),
      'sex':
          _eSex[_sex.indexOf(_selectSex.toString())].toString().toLowerCase(),
      'wardId': widget.ward.id,
      'talukId': widget.ward.talukId,
      'localbodyId': widget.ward.localbodyId,
      'assemblyId': widget.ward.assemblyId,
      'parliamentId': widget.ward.parliamentId,
      'districtId': widget.ward.districtId,
      'stateId': widget.ward.stateId,
      'countryId': widget.ward.countryId,
      'phone': phoneController?.text.toString()
    };

    data['isFather'] = (_selectSential.toString() == 'தந்தை') ? true : false;

    if (widget.booth.id != 0) {
      data['boothId'] = widget.booth.id;
    }

    if ((memberIdController?.text.toString())!.isNotEmpty) {
      data['memberId'] = memberIdController?.text.toString();
    }
    try {
      Map<String, dynamic> maps = await _remoteService.createVoter(data);
      createAgent(maps['upsertedId']);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getVoterDetails(String voterId) async {
    setState(() {
      _isLoading = true;
      _isAccountExisting = false;
    });
    try {
      List<Voter> voters = await _remoteService.getVoter(voterId);
      if (voters.isNotEmpty) {
        setState(() {
          _isAccountExisting = true;
          voter = voters[0];
          phoneController?.text = voter.phone ?? '';
          voterIdController?.text = voter.voterId;
          voterNameController?.text = voter.name.ta ?? '';
          voterFnameController?.text = voter.sentinal?.ta ?? '';
          doorNoController?.text = voter.doorNo.toString();
          ageController?.text = voter.age.toString();
          _selectSex = _sex[_eSex.indexOf(voter.sex?.toLowerCase() ?? 'male')];
          _selectSential = voter.isFather ?? false ? _sential[0] : _sential[1];

          memberIdController?.text = voter.memberId ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isAccountExisting = false;
        });
        _updateSuccessMessage(
            'தங்களின் வாக்காளர் விவரம் இல்லை. புதிதாக இணைக்கவும்');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isAccountExisting = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void getVoterDetailsWithPhone(String phone) async {
    setState(() {
      _isLoading = true;
      _isAccountExisting = false;
    });
    try {
      List<Voter> voters = await _remoteService.getVoterWithPhone(phone);
      if (voters.isNotEmpty) {
        setState(() {
          _isAccountExisting = true;
          voter = voters[0];
          phoneController?.text = voter.phone ?? '';
          voterIdController?.text = voter.voterId;
          voterNameController?.text = voter.name.ta;
          voterFnameController?.text = voter.sentinal?.ta ?? '';
          doorNoController?.text = voter.doorNo.toString();
          ageController?.text = voter.age.toString();
          _selectSex = _sex[_eSex.indexOf(voter.sex?.toLowerCase() ?? 'male')];
          _selectSential = voter.isFather ?? false ? _sential[0] : _sential[1];
          memberIdController?.text = voter.memberId ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _isAccountExisting = false;
        });
        _updateSuccessMessage(
            'தங்களின் வாக்காளர் விவரம் இல்லை. புதிதாக இணைக்கவும்');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isAccountExisting = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void createAgent(int voterId) async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, dynamic> maps = await _remoteService.createAgent({
        'voterId': [voterId]
      });
      storeData(maps);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _updateSuccessMessage(e);
      });
    }
  }

  storeData(Map<String, dynamic> res) {
    setState(() {
      _isLoading = false;
    });
    if (res['Authorization'] != null && res['session'] == true) {
      Shared.setShared(res).then((value) => {
            if (value)
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Dashboard()))
              }
            else
              {
                _updateSuccessMessage(
                    'Somthing went wrong please try again later.'),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Splash()))
              }
          });
    }
  }

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
