import 'package:Mugavan/models/voter.dart';
import 'package:Mugavan/screens/peoples.dart';
import 'package:Mugavan/screens/update_troop.dart';
import 'package:flutter/material.dart';

import '../service/remote_service.dart';
import '../utils/constant.dart';

class MyPeopleList extends StatefulWidget {
  const MyPeopleList({Key? key}) : super(key: key);

  @override
  State<MyPeopleList> createState() => _MyPeopleListState();
}

class _MyPeopleListState extends State<MyPeopleList>
    with AutomaticKeepAliveClientMixin {
  RemoteService remoteService = RemoteService();

  List<Voter>? _voters;
  bool _isLoading = true;

  final List<String> _tSex = ['ஆண்', 'பெண்', 'மூன்றாம் பாலினத்தவர்'];
  final List<String> _eSex = ['male', 'female', 'transgender'];

  @override
  void initState() {
    getMyVoters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(Constant.voter),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: MySearchDelegate(_voters!));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                getMyVoters();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : getOrderListWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _navigationToPeoplePage();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getOrderListWidget() {
    if (_voters?.isNotEmpty ?? false) {
      var listView = GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _voters?.length,
        itemBuilder: (BuildContext context, int index) {
          var _isShow = _voters?[index].isTaken;
          return GestureDetector(
              onLongPress: () {
                // setState(() {
                //   _isShow =
                // });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateTroop(voter: _voters![index]),
                  ),
                );
              },
              child: Card(
                elevation: 1,
                color: Color.fromRGBO(33, 150, 243, 1.0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.blue.shade50,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (_voters?[index]?.voterId.toString())!,
                        style: TextStyle(fontSize: 26.0, color: Colors.white),
                      ),
                      Text(
                        (_voters?[index]?.name.ta.toString().toUpperCase())!,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      Text(
                        (_voters?[index]
                            ?.sentinal
                            .ta
                            .toString()
                            .toUpperCase())!,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${_tSex[_eSex.indexOf((_voters?[index]?.sex.toString().toLowerCase())!)]}',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                          Text(
                            'வயது : ${(_voters?[index]?.age.toString())!}',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                        ],
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('${Constant.voter} .${Constant.no}'),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              _navigationToPeoplePage();
                            },
                            child: Text(
                              Constant.join,
                              style:
                                  TextStyle(fontSize: 18.0, color: Colors.blue),
                            ),
                          ),
                        )
                      ],
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

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
      _voters?.clear();
    });
    getMyVoters();
  }

  getMyVoters() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Voter> voters = await remoteService.getAassingedVotersWithWard();
      setState(() {
        _isLoading = false;
        _voters = voters;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  String changeTimeStampToDate(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp).toString();
  }

  void _navigationToPeoplePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Peoples()));
  }

  @override
  bool get wantKeepAlive => true;

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}

class MySearchDelegate extends SearchDelegate {
  late List<Voter> _voters;
  late String selectedResult;

  MySearchDelegate(this._voters);

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Voter> suggestedVoters = [];
    query.isEmpty
        ? suggestedVoters = _voters
        : suggestedVoters.addAll(_voters.where(
            (element) =>
                element.name.ta.toLowerCase().contains(query.toLowerCase()),
          ));

    return ListView.builder(
        itemCount: suggestedVoters.length,
        itemBuilder: (context, position) => ListTile(
              title: Text(suggestedVoters[position].name.ta.toString()),
            ));
  }
}
