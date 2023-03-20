import 'package:Mugavan/models/voter.dart';
import 'package:Mugavan/screens/auth.dart';
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
  final RemoteService _remoteService = RemoteService();

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
      // resizeToAvoidBottomInset: false,
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
                    enabled: true,
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
                    enabled: true,
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
                    enabled: true,
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
                    visible: true,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 46,
                      color: Constant.primeColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          updateAgent();
                        }
                      },
                      child: const Text(
                        'சமர்ப்பி',
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
      List<Voter> voters = await _remoteService.getAgent();
      if (voters.isNotEmpty) {
        setState(() {
          _voter = voters[0];
          userNameController?.text = _voter?.name.ta ?? '';
          phonenumberController?.text = _voter?.phone ?? '';
          fnameController?.text = _voter?.sentinal?.ta ?? '';
          voterIdController?.text = _voter?.voterId ?? '';
          doorNoController?.text = _voter?.doorNo ?? '';
          ageController?.text = _voter?.age.toString() ?? '0';
          sexController?.text =
              _tSex[_eSex.indexOf(_voter?.sex?.toLowerCase() ?? 'male')];
        });
      }
    } catch (e) {
      _updateSuccessMessage(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> updateAgent() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> data = {
      'name': {
        'en': userNameController?.text.toLowerCase(),
        'ta': userNameController?.text.toLowerCase()
      },
      'sentinal': {
        'en': fnameController?.text.toLowerCase(),
        'ta': fnameController?.text.toLowerCase()
      },
      'doorNo': doorNoController?.text ?? '',
      'age': int.parse(ageController?.text.toString() ?? '0')
    };
    try {
      bool isSuccess = await _remoteService.updateVoter(data, _voter?.id ?? 0);
      _updateSuccessMessage('வெற்றிகரமாக மேம்படுத்தப்பட்டது.');
    } catch (e) {
      _updateSuccessMessage(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  showAlertDialog(BuildContext context) {
    Widget logout = TextButton(
      child: Text(Constant.logout),
      onPressed: () async {
        var isRemove = await Shared.removeAll();
        if (isRemove) {
          navigateToSignUp();
        }
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

  void navigateToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Auth()));
  }
}
