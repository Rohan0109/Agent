import 'package:Mugavan/screens/auth.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../flutter_flow/flutter_flow_icon_button.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  var _isShowButton = true;

  var phonenumber = '';
  TextEditingController? phoneNumberController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    phoneNumberController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        // leading: FlutterFlowIconButton(
        //   borderColor: Colors.transparent,
        //   borderRadius: 30,
        //   borderWidth: 1,
        //   buttonSize: 60,
        //   icon: Icon(
        //     Icons.arrow_back_rounded,
        //     color: FlutterFlowTheme.of(context).secondaryText,
        //     size: 30,
        //   ),
        //   onPressed: () async {},
        // ),
        title: Text(
          'Phone Sign In',
          style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Outfit',
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                    child: Text(
                      'Type in your phone number below to register.',
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Outfit',
                          ),
                    )),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
              child: IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  phonenumber = phone.number;
                },
              )),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 44, 10, 44),
            child: _isShowButton
                ? FFButtonWidget(
                    onPressed: () async {
                      createAccount();
                    },
                    text: 'Sign in ',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50,
                      color: const Color(0xFF141618),
                      textStyle:
                          FlutterFlowTheme.of(context).subtitle2.override(
                                fontFamily: 'Outfit',
                                color: const Color(0xFFF1F4F8),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                      elevation: 2,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  )
                : CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  void createAccount() async {
    setState(() {
      _isShowButton = false;
    });
    Map<String, String> data = {'phone': phonenumber};

    bool isSucess = await RemoteService.createAccount(data);

    if (isSucess) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Auth(phonenumber: phonenumber)));
    } else {
      setState(() {
        _isShowButton = true;
      });
      print('error');
    }
  }
}
