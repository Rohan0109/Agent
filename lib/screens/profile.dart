import 'package:Mugavan/models/agent.dart';
import 'package:Mugavan/screens/dashboard.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';

class Profile extends StatefulWidget {
  const Profile();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isShow = false;

  String? teamSelectValue;

  TextEditingController? ntkIdController;
  TextEditingController? userNameController;
  TextEditingController? phonenumberController;
  TextEditingController? wardController;
  TextEditingController? subWardController;
  TextEditingController? talukController;

  String? countryValue;
  String? stateValue;
  String? cityValue;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> districts = [
    'அரியலூர்',
    'செங்கல்பட்டு',
    'சென்னை',
    'கோயம்புத்தூர்',
    'கடலூர்',
    'தருமபுரி',
    'திண்டுக்கல்',
    'ஈரோடு',
    'கள்ளக்குறிச்சி',
    'காஞ்சிபுரம்',
    'கன்னியாகுமரி',
    'கரூர்',
    'கிருட்டிணகிரி',
    'மதுரை',
    'மயிலாடுதுறை',
    'நாகப்பட்டினம்',
    'நாமக்கல்',
    'நீலகிரி',
    'பெரம்பலூர்',
    'புதுக்கோட்டை',
    'இராமநாதபுரம்',
    'இராணிப்பேட்டை',
    'சேலம்',
    'சிவகங்கை',
    'தென்காசி',
    'தஞ்சாவூர்',
    'தேனி',
    'தூத்துக்குடி',
    'திருச்சிராப்பள்ளி',
    'திருநெல்வேலி',
    'திருப்பத்தூர்',
    'திருப்பூர்',
    'திருவள்ளூர்',
    'திருவண்ணாமலை',
    'திருவாரூர்',
    'வேலூர்',
    'விழுப்புரம்',
    'விருதுநகர்'
  ];

  @override
  void initState() {
    super.initState();
    getAgent();
    phonenumberController = TextEditingController();
    ntkIdController = TextEditingController();
    userNameController = TextEditingController();
    wardController = TextEditingController();
    subWardController = TextEditingController();
    talukController = TextEditingController();
  }

  @override
  void dispose() {
    ntkIdController?.dispose();
    userNameController?.dispose();
    phonenumberController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'கணக்கு',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Outfit',
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 48,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(child: showLoading()),
    );
  }

  Widget showLoading() {
    if (_isShow) {
      return SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '* பெயர் அவசியம்';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'FullName',
                      ),
                      controller: userNameController,
                      maxLines: 1,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '* நாம் தமிழர் கட்சி எண் அவசியம்.';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'NTK Id',
                      ),
                      controller: ntkIdController,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone',
                      ),
                      controller: phonenumberController,
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return '* District is required';
                        }
                      },
                      borderRadius: BorderRadius.circular(8),
                      decoration: InputDecoration(
                          enabled: true,
                          labelText: 'District',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      items: districts
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (String? value) => {},
                      hint: Text(
                        'Choose your district',
                      ),
                    ),

                    // CSCPicker(
                    //   dropdownItemStyle:
                    //       FlutterFlowTheme.of(context).bodyText1.override(
                    //             fontFamily: 'Outfit',
                    //           ),
                    //   dropdownHeadingStyle:
                    //       FlutterFlowTheme.of(context).bodyText1.override(
                    //             fontFamily: 'Outfit',
                    //           ),
                    //   selectedItemStyle:
                    //       FlutterFlowTheme.of(context).bodyText1.override(
                    //             fontFamily: 'Outfit',
                    //           ),
                    //   dropdownDecoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       color: Colors.white,
                    //       border: Border.all(
                    //           color: Colors.grey.shade300, width: 1)),
                    //   onCountryChanged: (value) {
                    //     setState(() {
                    //       countryValue = value;
                    //     });
                    //   },
                    //   onStateChanged: (value) {
                    //     setState(() {
                    //       stateValue = value;
                    //     });
                    //   },
                    //   onCityChanged: (value) {
                    //     setState(() {
                    //       cityValue = value;
                    //     });
                    //   },
                    // ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '* Taluk is required';
                        } else {
                          return null;
                        }
                      },
                      controller: talukController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Taluk',
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '* Ward is required';
                        } else {
                          return null;
                        }
                      },
                      controller: wardController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ward',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '* Subward is required';
                        } else {
                          return null;
                        }
                      },
                      controller: subWardController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Subward',
                      ),
                    ),
                    SizedBox(height: 30),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 46,
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          updateAgent();
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [CircularProgressIndicator()],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void getAgent() async {
    Agent? agent = await RemoteService.getAgent();
    phonenumberController?.text = '${agent?.phone}';
    if ('${agent?.name}' != 'null') userNameController?.text = '${agent?.name}';
    if ('${agent?.ntkId}' != 'null') {
      ntkIdController?.text = '${agent?.ntkId}';
    }
    if ('${agent?.taluk}' != 'null') talukController?.text = '${agent?.taluk}';
    if ('${agent?.ward}' != 'null') wardController?.text = '${agent?.ward}';
    if ('${agent?.subWard}' != 'null') {
      subWardController?.text = '${agent?.subWard}';
    }
    setState(() {
      _isShow = true;
    });
  }

  Future<void> updateAgent() async {
    setState(() {
      _isShow = false;
    });
    Map<String, dynamic> data = {
      'name': '${userNameController?.text}',
      'ntkId': '${ntkIdController?.text}',
      'country': 'india',
      'state': 'tamilnadu',
      'district': '$cityValue',
      'taluk': '${talukController?.text}',
      'ward': '${wardController?.text}',
      'subWard': '${subWardController?.text}',
      'isActive': true
    };
    bool? isSuccess = await RemoteService.updateAgent(data);
    if (isSuccess!) {
      _isShow = true;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } else {
      _isShow = true;
    }
  }
}
