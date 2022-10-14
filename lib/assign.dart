import 'package:agent_login/people.dart';
import 'package:agent_login/profile.dart';
import 'package:agent_login/service/people_json.dart';
import 'package:agent_login/service/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_widgets.dart';

class AssignWidget extends StatefulWidget {
  const AssignWidget({Key? key}) : super(key: key);

  @override
  _AssignWidgetState createState() => _AssignWidgetState();
}

class _AssignWidgetState extends State<AssignWidget> {
  @override
  void initState() {
    super.initState();

    getpeoples();

    //   getItem();
  }

  bool is_present = false;
  List<int> peopleIds = [];
  List<People>? people;
  var isLoaded = false;
  bool? checkboxListTileValue;
  var people_list = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static int _len = 10;
  List<bool> isChecked = List.generate(_len, (index) => false);

  getpeoples() async {
    print("Loading");
    people = await RemoteService().getpeople();

    //  if (people != null) {
    print("getpeople()");
    setState(() {
      isLoaded = true;
      is_present = true;
    });
    // }
    print(is_present);
  }

  @override
  Widget build(BuildContext context) {
    print(is_present);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.account_circle, color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileWidget()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.people_alt_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PeopleWidget()));
                },
              ),
            ],
          ),
        ),
      ),
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
              'Assign people',
              style: FlutterFlowTheme.of(context).title3.override(
                    fontFamily: 'Outfit',
                  ),
            ),
            Text(
              'Assign people for agent!!',
              style: FlutterFlowTheme.of(context).bodyText2.override(
                    fontFamily: 'Outfit',
                    fontSize: 12,
                  ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 12, 4),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 44,
              fillColor: FlutterFlowTheme.of(context).lineColor,
              icon: Icon(
                Icons.east,
                color: Color(0xFF0F0F0F),
                size: 24,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PeopleWidget()));
              },
            ),
          ),
        ],
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
                            'People',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                        child: Text(
                          '#',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(2, 12, 0, 0),
                        child: Text(
                          'Selected',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                    child: is_present ? listview() : Text("Loading")),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                        child: FFButtonWidget(
                          onPressed: () async {
                            /*  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AssignWidget()));*/

                            var people_id =
                                await RemoteService().assignpeople(peopleIds);
                            if (people_id == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("People Assigned !"),
                              ));
                            }
                          },
                          text: 'Assign',
                          options: FFButtonOptions(
                            width: 150,
                            height: 40,
                            color: Color(0xFF20222A),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void assingId(int index) {
    var id = people?[index].id;
    peopleIds.add(id!);
  }

  /* void removePeople(int index) {
    people?.remove(index);
  }*/

  Widget listview() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: people?.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
          child: Container(
            width: 100,
            height: 70,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: FlutterFlowTheme.of(context).lineColor,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Theme(
                      data: ThemeData(
                        unselectedWidgetColor:
                            FlutterFlowTheme.of(context).secondaryText,
                      ),
                      child: CheckboxListTile(
                        value: isChecked[index],
                        /* onChanged: (newValue) => setState(() =>
                                          checkboxListTileValue = newValue!),*/
                        onChanged: (checked) {
                          assingId(index);
                          setState(
                            () {
                              isChecked[index] = checked!;
                            },
                          );
                        },
                        title: Text(
                          people?[0].name ?? "",
                          style: FlutterFlowTheme.of(context).subtitle1,
                        ),
                        subtitle: Text(
                          'Status',
                          style:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFE510069),
                                  ),
                        ),
                        tileColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        activeColor: Color(0xFE510069),
                        checkColor: FlutterFlowTheme.of(context).primaryBtnText,
                        dense: false,
                        controlAffinity: ListTileControlAffinity.trailing,
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
