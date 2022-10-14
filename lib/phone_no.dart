import 'package:agent_login/service/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'otppage.dart';

class PhoneNoWidget extends StatefulWidget {
  const PhoneNoWidget({Key? key}) : super(key: key);

  @override
  _PhoneNoWidgetState createState() => _PhoneNoWidgetState();
}

class _PhoneNoWidgetState extends State<PhoneNoWidget>
    with TickerProviderStateMixin {
  late RemoteService remoteService;
  var phonenumber = "";
  TextEditingController? phoneNumberController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    remoteService = new RemoteService();

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
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 30,
          ),
          onPressed: () async {},
        ),
        title: Text(
          'Phone Sign In',
          style: FlutterFlowTheme.of(context).title3.override(
                fontFamily: 'Outfit',
              ),
        ),
        actions: [],
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
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
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
              padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
              child: IntlPhoneField(
                decoration: InputDecoration(
                  //decoration for Input Field
                  labelText: 'Phone Number',

                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.purple,
                    ),
                  ),
                ),
                initialCountryCode: 'IN', //default contry code, NP for Nepal
                onChanged: (phone) {
                  phonenumber = phone.number;
                },
              )),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
            child: FFButtonWidget(
              onPressed: () async {
                var response = await remoteService.get_otp(phonenumber);

                if (response == true) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          OtppageWidget(phonenumber: phonenumber)));
                } else {
                  print("error");
                }
              },
              text: 'Sign in ',
              options: FFButtonOptions(
                width: 270,
                height: 50,
                color: Color(0xFF141618),
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFFF1F4F8),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                elevation: 2,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
