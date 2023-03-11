import 'package:Mugavan/models/voter.dart';
import 'package:flutter/material.dart';

import '../models/activity.dart';
import '../utils/constant.dart';

class History extends StatefulWidget {
  final List<Activity> activities;
  final Voter voter;

  const History({Key? key, required this.activities, required this.voter})
      : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late final List<Activity> _activities;
  late final Voter _voter;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _activities = widget.activities;
      _voter = widget.voter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('வரலாறு'),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: getOrderListWidget(),
      ),
    );
  }

  Widget getOrderListWidget() {
    if (_activities.isNotEmpty) {
      var listView = ListView.builder(
        itemCount: _activities?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              child: Card(
            elevation: 1,
            color: Color.fromRGBO(255, 255, 255, 1.0),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.blue.shade50,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Card(
                          color:
                              (_activities[index].partyId[0].short.ta == 'நாதக')
                                  ? Colors.green
                                  : Colors.red,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.blue.shade50,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      Text(
                        changeTimeStampToDate(_activities[index].createdAt),
                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'முகவர் ${(_activities[index].agentId.toString())}',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.blue,
                            fontStyle: FontStyle.italic,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  Text(
                    'கட்சி : ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 0, 0, 0),
                    child: Text(
                      _activities[index].partyId[0].name.ta,
                      style: TextStyle(fontSize: 16.0, color: Colors.black54),
                    ),
                  ),
                  Text(
                    'கருத்து : ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black54),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 0, 0, 0),
                    child: _activities[index].command != null
                        ? Text(
                            _activities[index].command,
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black54),
                          )
                        : Text('-- கருத்து பதிவிடவில்லை --'),
                  ),
                ],
              ),
            ),
          ));
        },
      );

      return listView;
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty.png',
                      width: 300,
                    ),
                    SizedBox(height: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [Text('வரலாறு ${Constant.no}.')],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String changeTimeStampToDate(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp).toString();
  }
}
