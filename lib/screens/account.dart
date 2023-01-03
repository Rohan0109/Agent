import 'package:Mugavan/flutter_flow/flutter_flow_widgets.dart';
import 'package:Mugavan/screens/signup.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../models/agent.dart';
import '../service/remote_service.dart';
import '../utils/shared.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool _isShow = false;

  String? teamSelectValue;

  TextEditingController? ntkIdController;
  TextEditingController? userNameController;
  TextEditingController? phonenumberController;
  TextEditingController? wardController;
  TextEditingController? SubwardController;
  TextEditingController? talukController;
  TextEditingController? countryController;
  TextEditingController? stateController;
  TextEditingController? cityController;

  String? countryValue;
  String? stateValue;
  String? cityValue;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getAgent();
    phonenumberController = TextEditingController();
    ntkIdController = TextEditingController();
    userNameController = TextEditingController();
    wardController = TextEditingController();
    SubwardController = TextEditingController();
    talukController = TextEditingController();
    countryController = TextEditingController();
    stateController = TextEditingController();
    cityController = TextEditingController();
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
        automaticallyImplyLeading: false,
        title: Text('Account'),
        actions: [
          IconButton(
            icon: Icon(Icons.login_sharp, color: Colors.white),
            onPressed: () {
              showAlertDialog(context);
            },
          )
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
                    SizedBox(
                      height: 20,
                    ),
                    ProfilePicture(
                      name: '${userNameController?.text}',
                      radius: 50,
                      fontsize: 50,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '* Name is required';
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
                          return '* NTK Id is required';
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
                      controller: SubwardController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Subward',
                      ),
                    ),
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'City',
                      ),
                      controller: cityController,
                      maxLines: 1,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'State',
                      ),
                      controller: stateController,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Country',
                      ),
                      controller: countryController,
                      maxLines: 1,
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
                        'Update',
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
      SubwardController?.text = '${agent?.subWard}';
    }
    if ('${agent?.district}' != 'null') {
      cityController?.text = '${agent?.district}';
    }
    if ('${agent?.state}' != 'null') {
      stateController?.text = '${agent?.state}';
    }
    if ('${agent?.country}' != 'null') {
      countryController?.text = '${agent?.country}';
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
      'country': '$countryValue',
      'state': '$stateValue',
      'district': '$cityValue',
      'taluk': '${talukController?.text}',
      'ward': '${wardController?.text}',
      'subWard': '${SubwardController?.text}',
      'isActive': true
    };
    bool? isSuccess = await RemoteService.updateAgent(data);
    if (isSuccess!) {
      _isShow = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Updated"),
          duration: Duration(seconds: 1, milliseconds: 0)));
    } else {
      _isShow = true;
    }
  }

  showAlertDialog(BuildContext context) {
    Widget logout = TextButton(
      child: Text('Log out'),
      onPressed: () async {
        var isRemove = await Shared.removeAll();
        if (isRemove) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignUp()));
        } else
          print("");
      },
    );

    Widget cancel = TextButton(
        onPressed: () => Navigator.of(context).pop(), child: Text('Cancel'));

    AlertDialog alert = AlertDialog(
      content: Text('Are you sure want to Log out ?'),
      actions: [cancel, logout],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
