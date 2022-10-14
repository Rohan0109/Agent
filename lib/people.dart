import 'package:agent_login/profile_disabled.dart';
import 'package:agent_login/service/display_peoples.dart';
import 'package:agent_login/service/remote_service.dart';
import 'package:agent_login/updatestatus.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'assign.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //use MaterialApp() widget like this

        home: PeopleWidget() //create new widget class for this 'home' to
        // escape 'No MediaQuery widget found' error
        );
  }
}

class PeopleWidget extends StatefulWidget {
  const PeopleWidget({Key? key}) : super(key: key);

  @override
  _PeopleWidgetState createState() => _PeopleWidgetState();
}

class _PeopleWidgetState extends State<PeopleWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    displaypeoples();

    //   getItem();
  }

  List<Display>? displayPeople;
  var isLoaded = false;
  bool is_present = false;
  displaypeoples() async {
    print("Loading");
    displayPeople = await RemoteService().display_people();

    //  if (people != null) {
    print("displayPeople()");
    setState(() {
      isLoaded = true;
      is_present = true;
    });
    // }
    print(is_present);
  }

  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileviewWidget()));
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.people_alt_outlined,
                  color: Colors.purple,
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
              'My people',
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
                            'People',
                            style: FlutterFlowTheme.of(context).bodyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child:
                                is_present ? get_listview() : Text("Loading")),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FFButtonWidget(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AssignWidget()));
                          print("to assign widget");
                        },
                        text: 'Assign',
                        options: FFButtonOptions(
                          width: 130,
                          height: 40,
                          color: Colors.black87,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get_listview() {
    //  var listView =  ListView.builder(
    //      itemBuilder: itemBuilder
    //  );

    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: displayPeople?.length,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 0),
                child: ListTile(
                  title: Text(
                    displayPeople?[index].name ?? "",
                    style: FlutterFlowTheme.of(context).title3.override(
                          fontFamily: 'Outfit',
                        ),
                  ),
                  subtitle: Text(
                    "Status :  " + displayPeople![index].activity.status,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Outfit',
                        ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF303030),
                    size: 20,
                  ),
                  tileColor: Color(0xFFF5F5F5),
                  dense: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () {
                    routeToUpdateStatus(index);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void routeToUpdateStatus(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdatePageWidget(),
            settings: RouteSettings(arguments: displayPeople![index])));
  }
}
