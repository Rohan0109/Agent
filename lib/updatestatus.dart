import 'package:agent_login/people.dart';
import 'package:agent_login/service/display_peoples.dart';
import 'package:agent_login/service/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //use MaterialApp() widget like this

        home: UpdatePageWidget() //create new widget class for this 'home' to
        // escape 'No MediaQuery widget found' error
        );
  }
}
*/
class UpdatePageWidget extends StatefulWidget {
  const UpdatePageWidget({super.key});

  @override
  _UpdatePageWidgetState createState() => _UpdatePageWidgetState();
}

class _UpdatePageWidgetState extends State<UpdatePageWidget> {
  List<String> status = ["positive", "negative", "Neutral"];
  List percentage = ["10", "20", "30", "40", "50", "60", "80", "90", "100"];
  String? dropDownValue_status;
  String? dropDownValue_percent;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final display = ModalRoute.of(context)!.settings.arguments as Display;
    var id = display.id;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Status',
              style: FlutterFlowTheme.of(context).title3.override(
                    fontFamily: 'Outfit',
                  ),
            ),
          ],
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: LinearPercentIndicator(
                    percent: 1,
                    width: MediaQuery.of(context).size.width,
                    lineHeight: 12,
                    animation: true,
                    progressColor: Color(0xFE510069),
                    backgroundColor: FlutterFlowTheme.of(context).lineColor,
                    barRadius: Radius.circular(0),
                    padding: EdgeInsets.zero,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                          child: Text(
                            'status',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFEFFFFFF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 16, 16, 16),
                                    child: Text(
                                      display.name,
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Outfit',
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8, 0, 0, 8),
                                        child: DropdownButton(
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Outfit',
                                                color: Colors.black,
                                              ),
                                          elevation: 2,
                                          hint: Text("Status"),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          value: dropDownValue_status,
                                          onChanged: (status) {
                                            setState(() {
                                              dropDownValue_status =
                                                  status.toString();
                                            });
                                          },
                                          items: status.map((itemone) {
                                            return DropdownMenuItem(
                                                value: itemone,
                                                child: Text(itemone));
                                          }).toList(),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 0, 16),
                                        child: DropdownButton(
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Outfit',
                                                color: Colors.black,
                                              ),
                                          elevation: 2,
                                          hint: Text("Percentage"),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          value: dropDownValue_percent,
                                          onChanged: (percentage) {
                                            setState(() {
                                              dropDownValue_percent =
                                                  percentage.toString();
                                            });
                                          },
                                          items: percentage.map((itemtwo) {
                                            return DropdownMenuItem(
                                                value: itemtwo,
                                                child: Text(itemtwo));
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.15, 0.05),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            print("Press");
                            var response = await RemoteService()
                                .updatePeopleStatus(id, dropDownValue_status,
                                    dropDownValue_percent);
                            if (response == true) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PeopleWidget()));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Status Updated !"),
                              ));
                            }
                          },
                          text: 'Submit',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: Color(0xFF0F0F0F),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: (8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
