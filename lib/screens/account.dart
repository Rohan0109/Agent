import 'package:Mugavan/models/voter.dart';
import 'package:Mugavan/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../service/remote_service.dart';
import '../utils/constant.dart';
import '../utils/shared.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> with AutomaticKeepAliveClientMixin {
  RemoteService remoteService = RemoteService();

  Voter? _voter;

  bool _isLoading = true;

  String? teamSelectValue;

  final List<String> _tSex = ['ஆண்', 'பெண்', 'மூன்றாம் பாலினத்தவர்'];
  final List<String> _eSex = ['male', 'female', 'transgender'];

  TextEditingController? ntkIdController;
  TextEditingController? userNameController;
  TextEditingController? phonenumberController;
  TextEditingController? fnameController;
  TextEditingController? voterIdController;
  TextEditingController? doorNoController;
  TextEditingController? ageController;
  TextEditingController? sexController;

  String? countryValue;
  String? stateValue;
  String? cityValue;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getAgent();
    super.initState();
    fnameController = TextEditingController();
    phonenumberController = TextEditingController();
    ntkIdController = TextEditingController();
    userNameController = TextEditingController();
    voterIdController = TextEditingController();
    doorNoController = TextEditingController();
    ageController = TextEditingController();
    sexController = TextEditingController();
  }

  @override
  void dispose() {
    ntkIdController?.dispose();
    userNameController?.dispose();
    phonenumberController?.dispose();
    fnameController?.dispose();
    voterIdController?.dispose();
    doorNoController?.dispose();
    sexController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(Constant.account),
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
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : showLoading(),
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    getAgent();
  }

  Widget showLoading() {
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
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* முகவர் பெயர் தேவை';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'முகவர் பெயர்',
                        labelText: 'முகவர் பெயர்',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: userNameController,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* தந்தை/கணவர் பெயர் தேவை';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'தந்தை/கணவர் பெயர்',
                        labelText: 'தந்தை/கணவர் பெயர்',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: fnameController,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    enabled: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* வாக்காளர் எண் தேவை';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'வாக்காளர் எண்',
                        labelText: 'வாக்காளர் எண்',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: voterIdController,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'முகவர் பெயர்',
                        labelText: 'தொலைபேசி எண்',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: phonenumberController,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'கதவு எண்',
                        labelText: 'கதவு எண்',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: doorNoController,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'வயது',
                        labelText: 'வயது',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: ageController,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        hintText: 'பாலினம்',
                        labelText: 'பாலினம்',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    controller: sexController,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                    visible: false,
                    child: MaterialButton(
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

  void getAgent() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Voter> voters = await remoteService.getAgent();
      if (voters.isNotEmpty) {
        setState(() {
          _isLoading = false;
          _voter = voters[0];
          userNameController?.text = (_voter?.name.ta.toString())!;
          phonenumberController?.text = (_voter?.phone.toString())!;
          fnameController?.text = (_voter?.sentinal.ta.toString())!;
          voterIdController?.text = (_voter?.doorNo.toString())!;
          doorNoController?.text = (_voter?.doorNo.toString())!;
          ageController?.text = (_voter?.age.toString())!;
          sexController?.text =
              _tSex[_eSex.indexOf((_voter?.sex.toLowerCase().toString())!)];
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

  Future<void> updateAgent() async {
    // setState(() {
    //   _isLoading = false;
    // });
    // Map<String, dynamic> data = {
    //   'name': '${userNameController?.text}',
    //   'ntkId': '${ntkIdController?.text}',
    //   'country': '$countryValue',
    //   'state': '$stateValue',
    //   'district': '$cityValue',
    //   'taluk': '${talukController?.text}',
    //   'ward': '${wardController?.text}',
    //   'subWard': '${SubwardController?.text}',
    //   'isActive': true
    // };
    // bool? isSuccess = await RemoteService.updateAgent(data);
    // if (isSuccess!) {
    //   _isLoading = true;
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text("Updated"),
    //       duration: Duration(seconds: 1, milliseconds: 0)));
    // } else {
    //   _isLoading = true;
    // }
  }

  showAlertDialog(BuildContext context) {
    Widget logout = TextButton(
      child: Text(Constant.logout),
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
        onPressed: () => Navigator.of(context).pop(), child: Text(Constant.no));

    AlertDialog alert = AlertDialog(
      content: Text('முகவனில் இருந்து வெளியேற வேண்டுமா ?'),
      actions: [cancel, logout],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
