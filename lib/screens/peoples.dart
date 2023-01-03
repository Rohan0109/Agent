import 'dart:ui';

import 'package:Mugavan/models/People.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:flutter/material.dart';

class Peoples extends StatefulWidget {
  const Peoples({Key? key}) : super(key: key);

  @override
  State<Peoples> createState() => _PeoplesState();
}

class _PeoplesState extends State<Peoples> {
  List<int> assignIds = [];
  List<People>? peoples;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getWardsPeoples();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('People List'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.white,
              onPressed: () {
                if (assignIds.isNotEmpty) {
                  showAlert();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('At least select one person'),
                      duration: Duration(seconds: 2, milliseconds: 0)));
                }
              },
              child: Text('Assign',
                  style: TextStyle(
                      color: Color.fromRGBO(31, 71, 136, 1),
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: isLoading
            ? getOrderListWidget()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget getOrderListWidget() {
    if (peoples?.isNotEmpty ?? false) {
      var listView = ListView.builder(
        itemCount: peoples?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blue.shade50,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              peoples?[index].name ?? '',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              changeTimeStampToDate(
                                      peoples?[index].createdAt ?? '')
                                  .substring(0, 11),
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Checkbox(
                              value: peoples?[index].isTaken,
                              onChanged: (bool? value) {
                                setState(() {
                                  peoples?[index].isTaken = value;
                                  if (value!)
                                    assignIds.add(peoples?[index].id);
                                  else
                                    assignIds.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
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
                      'images/empty.png',
                      width: 300,
                    ),
                    SizedBox(height: 10),
                    Text('No People Found')
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      peoples?.clear();
    });
    getWardsPeoples();
  }

  Future<void> getWardsPeoples() async {
    List<People>? peoples = await RemoteService.getPeoples();
    setState(() {
      this.peoples = peoples;
      isLoading = true;
    });
  }

  String changeTimeStampToDate(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp).toString();
  }

  void showAlert() {
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () async {
        Navigator.pop(context);
        assignPeoples();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        'Assign People',
      ),
      content: Text('Are you sure you want to Assign?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> assignPeoples() async {
    setState(() {
      isLoading = false;
    });
    Map<String, dynamic> data = {'peoples': assignIds};
    bool? isSuccess = await RemoteService.assignPeoples(data);
    if (isSuccess!) {
      for (var id in assignIds!) {
        peoples?.removeWhere((element) => element.id == id);
      }
      setState(() {
        isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('People assign successfully.'),
          duration: Duration(seconds: 2, milliseconds: 0)));
    } else {
      setState(() {
        isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong,Please try again later.'),
          duration: Duration(seconds: 2, milliseconds: 0)));
    }
  }
}
