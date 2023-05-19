import 'dart:ui';

import 'package:Mugavan/models/voter.dart';
import 'package:Mugavan/screens/add_new_voter.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class UnassignedWardVoters extends StatefulWidget {
  const UnassignedWardVoters({Key? key}) : super(key: key);

  @override
  State<UnassignedWardVoters> createState() => _UnassignedWardVotersState();
}

class _UnassignedWardVotersState extends State<UnassignedWardVoters> {
  RemoteService remoteService = RemoteService();

  final List<String> _tSex = ['ஆண்', 'பெண்', 'மூன்றாம் பாலினத்தவர்'];
  final List<String> _eSex = ['male', 'female', 'transgender'];

  List<int> assignIds = [];
  List<Voter>? _voters;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getWardsVoters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(Constant.wardName),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              color: Colors.white,
              onPressed: () {
                if (assignIds.isNotEmpty) {
                  showAlert();
                } else {
                  _updateSuccessMessage('ஒரு வாக்காளரையாவது இணைக்கவும்');
                }
              },
              child: Text(Constant.join,
                  style: TextStyle(
                      color: Color.fromRGBO(31, 71, 136, 1),
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : getOrderListWidget(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.primeColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewVoter(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getOrderListWidget() {
    if (_voters?.isNotEmpty ?? false) {
      var listView = GridView.builder(
        itemCount: _voters?.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                setState(() {
                  if (_voters?[index].isTaken == true) {
                    _voters?[index].isTaken = false;
                    assignIds.remove(_voters?[index].id);
                  } else {
                    _voters?[index].isTaken = true;
                    assignIds.add((_voters?[index].id)!);
                  }
                });
              },
              child: Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _voters?[index].sno.toString() ?? '0',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.black87),
                          ),
                          Checkbox(
                            focusColor: Colors.white,
                            value: _voters?[index].isTaken,
                            onChanged: (bool? value) {
                              setState(() {
                                _voters?[index].isTaken = value!;
                                if (value!) {
                                  assignIds.add((_voters?[index].id)!);
                                } else {
                                  assignIds.removeAt(index);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      Text(
                        _voters?[index].voterId ?? '',
                        style: TextStyle(fontSize: 26.0, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Flexible(
                        child: Text(
                          (_voters?[index].name.ta.toString().toUpperCase())!,
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.black87),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        _voters?[index].sentinal?.ta.toUpperCase() ?? '',
                        style: TextStyle(fontSize: 16.0, color: Colors.black87),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            _tSex[_eSex.indexOf((_voters?[index]
                                .sex
                                .toString()
                                .toLowerCase())!)],
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black87),
                          ),
                          Text(
                            'வயது : ${(_voters?[index].age.toString()) ?? 0}',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black87),
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
                      'assets/images/empty.png',
                      width: 300,
                    ),
                    SizedBox(height: 10),
                    Text('வார்டுயில் வாக்காளர்கள் இல்லை.')
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
    getWardsVoters();
  }

  Future<void> getWardsVoters() async {
    try {
      List<Voter> voters = await remoteService.getUnassingedVotersWithWard();
      setState(() {
        _isLoading = false;
        _voters = voters;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _voters = [];
      });
      _updateSuccessMessage(e);
    }
  }

  String changeTimeStampToDate(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp).toString();
  }

  void showAlert() {
    Widget cancelButton = TextButton(
      child: Text(Constant.no),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(Constant.join),
      onPressed: () async {
        Navigator.pop(context);
        assignVoters();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text('இவர்களை தங்களின் வாக்காளராக இணைக்கிறீர்களா ?'),
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

  assignVoters() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool isSuccess =
          await remoteService.assignVoters({'votersId': assignIds});
      if (isSuccess == true) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
