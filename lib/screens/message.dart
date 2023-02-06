import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/voter.dart';
import '../utils/constant.dart';

class Message extends StatefulWidget {
  final Voter voter;

  const Message({Key? key, required this.voter}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: SingleChildScrollView(child: Text('Test'))),
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

  void _updateSuccessMessage(var e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: Constant.limit, milliseconds: 0)));
  }
}
