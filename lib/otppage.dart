import 'package:agent_login/profile.dart';
import 'package:agent_login/service/remote_service.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtppageWidget extends StatefulWidget {
 String phonenumber;
  OtppageWidget( {required this.phonenumber});
 // OtppageWidget(  {Key? key,required String? phonenumber }) : super(key: key);

  @override
  _OtppageWidgetState createState() => _OtppageWidgetState();
}

class _OtppageWidgetState extends State<OtppageWidget> {
  TextEditingController? pinCodeController;

  late RemoteService remoteService;
  final scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
    remoteService = new RemoteService();
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
        actions: [],
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Confirm your Code',
                    style: FlutterFlowTheme.of(context).title3,
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      textStyle: FlutterFlowTheme.of(context)
                          .subtitle2
                          .override(
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
                        activeColor:Colors.black,
                        inactiveColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                        selectedColor:
                        Colors.black,
                        activeFillColor:
                        FlutterFlowTheme.of(context).primaryColor,
                        inactiveFillColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                        selectedFillColor:
                        Colors.black,
                      ),
                      controller: pinCodeController,
                      onChanged: (_) => {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 44),
              child: FFButtonWidget(

                onPressed: ()  async {

                           var response = await remoteService.auth_otp(widget.phonenumber, pinCodeController?.text);
                            if (response == true){
                            print(widget.phonenumber);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ProfileWidget()));
                                            }
                          else{
                        print("error");
                              }
                },
                text: 'Confirm & Continue',
                options: FFButtonOptions(
                  width: 270,
                  height: 50,
                  color: FlutterFlowTheme.of(context).primaryText,
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).primaryBackground,
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
      ),
    );
  }
}
