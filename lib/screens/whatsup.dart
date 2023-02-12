import 'dart:io';

import 'package:Mugavan/models/message.dart';
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

  Future<void> _refresh() async {
    setState(() {
      _isLoading:
      true;
      _messages.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.white),
            onPressed: () {
              showAlertDialog(context);
            },
          ),
        ],
        elevation: 0,
        title: const Text(
          'பகிரி',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : getMessageWidgets(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getMessageWidgets() {
    if (_messages?.isNotEmpty ?? false) {
      var listView = GridView.builder(
        itemCount: _messages?.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
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
                        (_messages?[index]?.message.toString())!,
                        style: TextStyle(fontSize: 26.0, color: Colors.white),
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

  String changeTimeStampToDate(int timeStamp) {
    return DateTime.fromMillisecondsSinceEpoch(timeStamp).toString();
  }

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
