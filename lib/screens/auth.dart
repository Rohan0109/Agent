import 'package:Mugavan/screens/dashboard.dart';
import 'package:Mugavan/screens/profile.dart';
import 'package:Mugavan/service/remote_service.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';

import '../flutter_flow/flutter_flow_widgets.dart';

class Auth extends StatefulWidget {
  String phonenumber;

  Auth({required this.phonenumber});

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  var _isShowButton = true;

  TextEditingController? pinCodeController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pinCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Enter Pin Code Below',
          style: FlutterFlowTheme.of(context).bodyText1,
        ),
        actions: const [],
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Confirm your Code',
                    style: FlutterFlowTheme.of(context).title3,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                              ),
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      enableActiveFill: false,
                      autoFocus: true,
                      showCursor: true,
                      cursorColor: Colors.black,
                      obscureText: false,
                      hintCharacter: '-',
                      pinTheme: PinTheme(
                        fieldHeight: 60,
                        fieldWidth: 60,
                        borderWidth: 2,
                        borderRadius: BorderRadius.circular(12),
                        shape: PinCodeFieldShape.box,
                        activeColor: Colors.black,
                        inactiveColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        selectedColor: Colors.black,
                        activeFillColor:
                            FlutterFlowTheme.of(context).primaryColor,
                        inactiveFillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        selectedFillColor: Colors.black,
                      ),
                      controller: pinCodeController,
                      onChanged: (_) => {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
              child: _isShowButton
                  ? FFButtonWidget(
                      onPressed: () {
                        authOTP();
                      },
                      text: 'Confirm & Continue',
                      options: FFButtonOptions(
                        width: 270,
                        height: 50,
                        color: FlutterFlowTheme.of(context).primaryText,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                        elevation: 2,
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> authOTP() async {
    setState(() {
      _isShowButton = false;
    });
    Map<String, dynamic> data = {
      'otp': pinCodeController?.text,
      'phone': widget.phonenumber
    };
    Map<String, dynamic>? res = await RemoteService.authOTP(data);
    if (res!['accessToken'] != null && res!['session'] == 'AUTHORIZED') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Profile()));
    } else if (res!['accessToken'] != null && res!['session'] == 'UPDATED') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Dashboard()));
    } else {
      setState(() {
        _isShowButton = true;
      });
    }
  }
}
