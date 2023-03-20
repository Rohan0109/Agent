import 'package:Mugavan/models/activity.dart';
import 'package:Mugavan/models/party.dart' as py;
import 'package:Mugavan/screens/history.dart';
import 'package:Mugavan/screens/whatsup.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/party.dart';
import '../models/voter.dart';
import '../utils/constant.dart';

class UpdateMyVoter extends StatefulWidget {
  final Voter voter;

  const UpdateMyVoter({super.key, required this.voter});

  @override
  State<UpdateMyVoter> createState() => _UpdateMyVoterState();
}

class _UpdateMyVoterState extends State<UpdateMyVoter> {
  RemoteService remoteService = RemoteService();

  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
  bool _isVoterLoading = false;
  Color _color = Colors.blue;

  Activity? activity;

  List<Activity> _activities = [];

  List<Party> _parties = [
    Party(
        name: py.Name(en: '--Select District --', ta: '-- கட்சி --'),
        short: py.Name(en: '--Select District --', ta: '-- கட்சி --'),
        imageUrl: 'imageUrl',
        createdAt: 0,
        updatedAt: 0,
        id: 0)
  ];

  Party? selectedParty;
  String statusPercentageValue = '0';

  final FocusNode myFocusNode = FocusNode();

  final List<String> _tSex = ['ஆண்', 'பெண்', 'மூன்றாம் பாலினத்தவர்'];
  final List<String> _eSex = ['male', 'female', 'transgender'];

  List<String> statusPercentage = [
    '0',
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100'
  ];

  TextEditingController? voterIdController;
  TextEditingController? nameController;
  TextEditingController? fatherNameController;
  TextEditingController? phonenumberController;
  TextEditingController? doorNoController;
  TextEditingController? ageController;
  TextEditingController? sexController;
  TextEditingController? commandController;

  @override
  void initState() {
    selectedParty = _parties[0];
    getParties();
    super.initState();
    voterIdController = TextEditingController(text: widget.voter.voterId);
    nameController = TextEditingController(text: widget.voter.name.ta);
    fatherNameController =
        TextEditingController(text: widget.voter.sentinal?.ta);
    phonenumberController = TextEditingController(text: widget.voter.phone);
    doorNoController =
        TextEditingController(text: widget.voter.doorNo.toString());
    ageController = TextEditingController(text: widget.voter.age.toString());
    sexController = TextEditingController(
        text: _tSex[_eSex.indexOf(widget.voter.sex?.toLowerCase() ?? 'male')]);
    commandController = TextEditingController();
  }

  @override
  void dispose() {
    voterIdController?.dispose();
    nameController?.dispose();
    fatherNameController?.dispose();
    phonenumberController?.dispose();
    doorNoController?.dispose();
    ageController?.dispose();
    sexController?.dispose();
    commandController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showAlertDialog(context);
            },
          ),
        ],
        elevation: 0,
        title: const Text(
          'வாக்காளர்',
        ),
      ),
      body: RefreshIndicator(
          onRefresh: _refresh, child: SingleChildScrollView(child: accounts())),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    getParties();
  }

  Widget accounts() {
    return Column(
      children: <Widget>[
        _isLoading
            ? SizedBox(
                height: 300.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: 100.0,
                              color: _color,
                              child: Center(
                                child: Text(
                                  '$statusPercentageValue%',
                                  style: TextStyle(
                                      fontSize: 28.0, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  DropdownButtonFormField(
                                    validator: (Party? value) {
                                      if (value == null || value.id == 0) {
                                        return '* கட்சியை தேர்ந்தெடுக்கவும்';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        enabled: true,
                                        labelText: '* கட்சி',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    value: selectedParty,
                                    items: _parties
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child:
                                                  Text(e.short.ta.toString()),
                                            ))
                                        .toList(),
                                    onChanged: (Party? value) {
                                      setState(() {
                                        selectedParty = value!;
                                      });
                                    },
                                    hint: Text('கட்சி'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DropdownButtonFormField(
                                    validator: (String? value) {
                                      if (value == null || value == '0') {
                                        return '* சதவீதம் தேர்ந்தெடுக்கவும்';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                        enabled: true,
                                        labelText: '* சதவீதம்',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                    value: statusPercentageValue,
                                    items: statusPercentage
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        statusPercentageValue = value!;
                                      });
                                    },
                                    hint: Text('சதவீதம்'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
                      child: TextFormField(
                        controller: commandController,
                        maxLines: null,
                        minLines: 3,
                        decoration: InputDecoration(
                            labelText: 'கருத்து',
                            hintText: 'கருத்தை பதிவிடவும்...',
                            enabled: true,
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: true,
                            child: IconButton(
                                onPressed: () {
                                  if (phonenumberController?.text != null &&
                                      phonenumberController?.text.length ==
                                          10 &&
                                      (RegExp('^[6-9]\\d{9}\$').hasMatch(
                                          (phonenumberController?.text)!))) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WhatsUp(
                                                  voter: widget.voter,
                                                )));
                                  }
                                },
                                icon: Icon(
                                  Icons.whatsapp,
                                  color: Colors.green,
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                if (phonenumberController?.text != null &&
                                    phonenumberController?.text.length == 10 &&
                                    (RegExp('^[6-9]\\d{9}\$').hasMatch(
                                        (phonenumberController?.text)!))) {
                                  _makingPhoneCall(
                                      phonenumberController?.text!);
                                }
                              },
                              icon: Icon(
                                Icons.phone,
                                color: Colors.blueAccent,
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => History(
                                            activities: _activities,
                                            voter: widget.voter)));
                              },
                              child: Text('வரலாறு')),
                          OutlinedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                createVoterActivity();
                              }
                            },
                            child: Text('சமர்ப்பி'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        _isVoterLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: formKey2,
                child: Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'வாக்காளரின் தரவுகள்',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: voterIdController,
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
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'வாக்காளர் எண்',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          enabled: true,
                          autofocus: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'வாக்காளரின் பெயர் தேவை';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'வாக்காளர் பெயர்',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          enabled: true,
                          autofocus: false,
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'தந்தை/கணவர் பெயர்',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          enabled: true,
                          autofocus: false,
                          controller: fatherNameController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'தொலைபேசி எண் தேவை';
                            } else if (!RegExp('^[6-9]\\d{9}\$')
                                .hasMatch(value)) {
                              return 'சரியான தொலைபேசி எண்ணை பதிவிடவும்';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'தொலைபேசி எண்',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          enabled: true,
                          autofocus: false,
                          controller: phonenumberController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'விட்டு எண்',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          enabled: true,
                          autofocus: false,
                          controller: doorNoController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'வயது',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          enabled: true,
                          autofocus: false,
                          controller: ageController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              enabled: true,
                              labelText: 'பாலினம்',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          enabled: false,
                          autofocus: false,
                          controller: sexController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          minWidth: double.infinity,
                          height: 46,
                          color: Constant.primeColor,
                          textColor: Colors.white,
                          onPressed: () {
                            if (formKey2.currentState!.validate()) {
                              updatedVoter();
                            }
                          },
                          child: const Text(
                            'மேம்படுத்து',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
      ],
    );
  }

  createVoterActivity() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> data = {
      'countryId': widget.voter.countryId,
      'stateId': widget.voter.stateId,
      'districtId': widget.voter.districtId,
      'parliamentId': widget.voter.parliamentId,
      'assemblyId': widget.voter.assemblyId,
      'talukId': widget.voter.talukId,
      'localbodyId': widget.voter.localbodyId,
      'wardId': widget.voter.wardId,
      'voterId': widget.voter.id,
      'partyId': [selectedParty?.id],
      'percentage': statusPercentageValue.toString()
    };
    if ((commandController?.text.isNotEmpty)!) {
      data['command'] = commandController?.text;
    }
    try {
      bool isSuccess = await remoteService.createVoterActivity(data);
      if (isSuccess) {
        getVoterActivity();
        _updateSuccessMessage('வெற்றிகரமாக சேமிக்கப்பட்டதது');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }

  showAlertDialog(BuildContext context) {
    Widget logout = TextButton(
      child: Text('விடுவி'),
      onPressed: () async {
        Navigator.pop(context);
        resignVoter();
      },
    );

    Widget cancel = TextButton(
        onPressed: () => Navigator.of(context).pop(), child: Text('இல்லை'));

    AlertDialog alert = AlertDialog(
      content: Text('உங்கள் வாக்காளர் பட்டியலில் இருந்து விடுவிக்க வேண்டுமா ?'),
      actions: [cancel, logout],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> resignVoter() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool isSuccess = await remoteService.unAssignVoters({
        'votersId': [widget.voter.id]
      });
      if (isSuccess) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  Future<void> getParties() async {
    try {
      List<Party> parties = await remoteService.getParties();
      setState(() {
        _parties = List.of(_parties)..addAll(parties);
      });
      getVoterActivity();
    } catch (e) {
      _updateSuccessMessage(e);
    }
  }

  Future<void> getVoterActivity() async {
    setState(() {
      _activities.clear();
    });
    try {
      List<Activity> activities =
          await remoteService.getVoterActivity(widget.voter.id);
      if (activities.isNotEmpty) {
        Party party = activities.reversed.toList()[0].partyId[0];
        int index = 0;
        for (Party pt in _parties) {
          if (pt.short.ta == party.short.ta) {
            _color = pt.short.ta.toString() == 'நாதக'
                ? Colors.green.shade700
                : Colors.red.shade700;
            index = _parties.indexOf(pt);
            break;
          }
        }
        setState(() {
          _activities = activities.reversed.toList();
          selectedParty = _parties[index];
          statusPercentageValue = activities.reversed.toList()[0].percentage;
          _isLoading = false;
        });
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

  Future<void> updatedVoter() async {
    setState(() {
      _isVoterLoading = true;
    });

    Map<String, dynamic> data = {
      'voterId': voterIdController?.text.toString(),
      'name': {
        'en': nameController?.text.toLowerCase().toString(),
        'ta': nameController?.text.toLowerCase().toString(),
      },
      'sentinal': {
        'en': fatherNameController?.text.toLowerCase().toString(),
        'ta': fatherNameController?.text.toLowerCase().toString(),
      },
      'age': int.parse(ageController?.text.toString() ?? '0'),
      'doorNo': doorNoController?.text.toString(),
      'phone': phonenumberController?.text.toString()
    };

    try {
      bool isSuccess = await remoteService.updateVoter(data, widget.voter.id);
      if (isSuccess) {
        setState(() {
          _isVoterLoading = false;
          widget.voter.phone = (phonenumberController?.text)!;
        });
        _updateSuccessMessage('வெற்றிகரமாக சேமிக்கப்பட்டதது');
      } else {
        setState(() {
          _isVoterLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isVoterLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  Future<void> _makingPhoneCall(var phone) async {
    var url = Uri.parse('tel:+91$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
