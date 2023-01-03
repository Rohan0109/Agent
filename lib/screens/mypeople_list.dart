import 'package:Mugavan/models/Troop.dart';
import 'package:Mugavan/screens/peoples.dart';
import 'package:Mugavan/screens/update_troop.dart';
import 'package:flutter/material.dart';

import '../service/remote_service.dart';

class MyPeopleList extends StatefulWidget {
  const MyPeopleList({Key? key}) : super(key: key);

  @override
  State<MyPeopleList> createState() => _MyPeopleListState();
}

class _MyPeopleListState extends State<MyPeopleList> {
  List<Troop>? troops;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getTroops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('People List'),
        actions: const [],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: isLoading
            ? getOrderListWidget()
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Peoples()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getOrderListWidget() {
    if (troops?.isNotEmpty ?? false) {
      var listView = ListView.builder(
        itemCount: troops?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTroop(troop: troops![index]),
                  ),
                );
              },
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
                              troops?[index].name ?? '',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              changeTimeStampToDate(
                                      troops?[index].createdAt ?? '')
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
                          children: const [],
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
                    Text("No Troop Found")
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
      troops?.clear();
    });
    getTroops();
  }

  Future<void> getTroops() async {
    List<Troop>? troops = await RemoteService.getTroops();
    setState(() {
      this.troops = troops;
      this.isLoading = true;
    });
  }

  String changeTimeStampToDate(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp).toString();
  }
}
