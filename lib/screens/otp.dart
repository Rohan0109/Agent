import 'package:Mugavan/screens/dashboard.dart';
import 'package:Mugavan/screens/select_geo_location.dart';
import 'package:Mugavan/screens/splash.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:Mugavan/utils/constant.dart';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/shared.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  String? phone;

  RemoteService remoteService = RemoteService();

  var _isLoading = false;

  TextEditingController? pinCodeController;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getPhoneNumber();
    super.initState();
    pinCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              Constant.account,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 1,
      ),
      body: showBody(),
    );
  }

  Widget showBody() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text(
              '$phone இந்த தொலைபேசிக்கு அனுப்பப்பட்ட ஒருமுறை கடவுச் சொல்லை அனுப்பவும்',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              validator: (value) {
                if (value == null || value.length != 4) {
                  return 'ஒருமுறை கடவுச் சொல்லை பதிவிடவும்';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              appContext: context,
              length: 4,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              enableActiveFill: false,
              autoFocus: true,
              showCursor: true,
              cursorColor: Colors.black,
              obscureText: false,
              hintCharacter: '-',
              controller: pinCodeController,
              onChanged: (_) => {},
            ),
            SizedBox(
              height: 20,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : MaterialButton(
                    padding: EdgeInsets.all(16.0),
                    minWidth: double.infinity,
                    height: 46,
                    color: Constant.primeColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        authOTP();
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
                  )
          ],
        ),
      ),
    );
  }

  Future<void> authOTP() async {
    setState(() {
      _isLoading = true;
    });
    try {
      Map<String, dynamic> maps = await remoteService
          .authOTP({'otp': pinCodeController?.text, 'phone': phone});
      storeData(maps);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  storeData(Map<String, dynamic> res) {
    setState(() {
      _isLoading = false;
    });
    if (res['Authorization'] != null && res['session'] == false) {
      Shared.setAuthShared(res).then((bool value) => {
            if (value)
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectGeoLocation()))
              }
            else
              {
                _updateSuccessMessage(
                    'Somthing went wrong please try again later.'),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Splash()))
              }
          });
    } else if (res['Authorization'] != null && res['session'] == true) {
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
    } else {
      _updateSuccessMessage('Somthing went wrong please try again later.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Splash()));
    }
  }

  void getPhoneNumber() async {
    Shared.getPhonenumber().then((value) => {
          setState(() {
            phone = value;
          })
        });
  }

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
