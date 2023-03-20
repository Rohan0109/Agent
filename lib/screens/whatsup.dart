import 'dart:io';

import 'package:Mugavan/models/message.dart';
import 'package:Mugavan/utils/shared.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/voter.dart';
import '../service/remote_service.dart';
import '../utils/constant.dart';

class WhatsUp extends StatefulWidget {
  final Voter voter;

  const WhatsUp({Key? key, required this.voter}) : super(key: key);

  @override
  State<WhatsUp> createState() => _WhatsUpState();
}

class _WhatsUpState extends State<WhatsUp> {
  bool _isLoading = true;
  List<Message> _messages = [];
  RemoteService remoteService = RemoteService();

  TextEditingController? messageController;

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
      _messages.clear();
    });
    getMessages();
  }

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    getMessages();
  }

  @override
  void dispose() {
    messageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: const Text(
          'பகிரி',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(child: getMessageWidgets()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 6.0, 16.0, 6.0),
                              child: TextFormField(
                                autofocus: true,
                                controller: messageController,
                                maxLines: null,
                                minLines: 1,
                                decoration: InputDecoration(
                                    hintText: 'கருத்தை பதிவிடவும்...',
                                    enabled: true,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Constant.primeColor, width: 5),
                                color: Constant.primeColor,
                                borderRadius: BorderRadius.circular(50.0)),
                            child: InkWell(
                                onTap: () {
                                  sendMessages();
                                },
                                borderRadius: BorderRadius.circular(100.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(Icons.send,
                                      size: 30.0, color: Colors.white),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget getMessageWidgets() {
    if (_messages.isNotEmpty) {
      var listView = ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: Card(
                color: Constant.cardColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        _messages[index].message.toString() ?? '',
                        style: TextStyle(fontSize: 18.0, color: Colors.black54),
                      ),
                      Text(
                        changeTimeStampToDate(_messages[index].createdAt),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 12.0, color: Colors.black54),
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
                    Text('பகிரியில் தகவல் ஏதும்  இல்லை')
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget logout = TextButton(
      child: Text('விடுவி'),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    Widget cancel = TextButton(
        onPressed: () => Navigator.of(context).pop(), child: Text('இல்லை'));

    AlertDialog alert = AlertDialog(
      content: ElevatedButton(
          onPressed: () => openWhatsup(widget.voter.phone, 'message'),
          child: Text('Open Whatsapp')),
      actions: [cancel, logout],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> openWhatsup(var number, var message) async {
    var whatsupIOS = 'https://wa.me/$number?text=${Uri.parse(message)}';
    var whatsupAD = 'whatsapp://send?phone=+91$number&text=$message';
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(whatsupIOS))) {
        await launchUrl(Uri.parse(whatsupIOS));
      } else {
        _updateSuccessMessage('WhatsApp is not install');
      }
    } else {
      // if (await canLaunchUrl(Uri.parse(whatsupAD))) {
      messageController?.clear();
      await launchUrl(Uri.parse(whatsupAD));
      // } else {
      //   _updateSuccessMessage('WhatsApp is not install');
      // }
    }
  }

  Future<void> getMessages() async {
    try {
      List<Message> messages = await remoteService.getMessages(widget.voter.id);
      setState(() {
        _isLoading = false;
        _messages = messages;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _updateSuccessMessage(e);
    }
  }

  Future<void> sendMessages() async {
    Map<String, dynamic> data = {
      'message': messageController?.text.toString(),
      'voterId': widget.voter.id,
      'sender': await Shared.getPhonenumber(),
      'receiver': widget.voter.phone
    };

    try {
      List<Message> messages = await remoteService.sendMessages(data);
      openWhatsup(widget.voter.phone, data['message']);
      setState(() {
        _isLoading = false;
        setState(() {
          _messages.add(messages[0]);
        });
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

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
