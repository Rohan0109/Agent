import 'package:Mugavan/service/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

import '../models/Troop.dart';

class UpdateTroop extends StatefulWidget {
  final Troop troop;

  const UpdateTroop({super.key, required this.troop});

  @override
  State<UpdateTroop> createState() => _UpdateTroopState();
}

class _UpdateTroopState extends State<UpdateTroop> {
  String statusValue = '';
  String statusPercentageValue = '';
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  List<String> status = ['POSITIVE', 'NEGATIVE', 'NEUTRAL'];
  List<String> statusPercentage = [
    '0',
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100'
  ];

  TextEditingController? voterIdController;
  TextEditingController? wardController;
  TextEditingController? subWardController;
  TextEditingController? nameController;
  TextEditingController? fatherNameController;
  TextEditingController? typeController;
  TextEditingController? labNameController;

  @override
  void initState() {
    super.initState();
    statusValue = widget.troop.activity.status.toString().toUpperCase();
    statusPercentageValue = widget.troop.activity.statusPercentage.toString();
    voterIdController = TextEditingController(text: widget.troop.voterId);
    wardController = TextEditingController(text: widget.troop.ward);
    subWardController = TextEditingController(text: widget.troop.subWard);
    nameController = TextEditingController(text: widget.troop.name);
    fatherNameController = TextEditingController(text: widget.troop.fatherName);
    typeController = TextEditingController();
    labNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromRGBO(31, 71, 136, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              updateTroop();
            },
          )
        ],
        elevation: 0,
        title: const Text(
          'Update Troop',
        ),
      ),
      body: _status
          ? SingleChildScrollView(child: accounts())
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget accounts() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Stack(fit: StackFit.loose, children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ProfilePicture(
                        name: widget.troop.name,
                        radius: 50,
                        fontsize: 50,
                      ),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
        Container(
          color: Color(0xffFFFFFF),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Troop Information',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Ward',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Ward'),
                  enabled: !_status,
                  autofocus: !_status,
                  controller: wardController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'SubWard',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'SubWard'),
                  enabled: !_status,
                  autofocus: !_status,
                  controller: subWardController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'VoterId',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration:
                      const InputDecoration(hintText: 'Enter Your Name'),
                  enabled: !_status,
                  autofocus: !_status,
                  controller: voterIdController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Name',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration:
                      const InputDecoration(hintText: 'Enter Your Name'),
                  enabled: !_status,
                  autofocus: !_status,
                  controller: nameController,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'FatherName',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                TextField(
                  decoration:
                      const InputDecoration(hintText: 'Enter Your FatherName'),
                  enabled: !_status,
                  autofocus: !_status,
                  controller: fatherNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Status',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                DropdownButtonFormField(
                  value: statusValue,
                  items: status
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    statusValue = value!;
                  },
                  hint: Text('Status'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Status Percentage',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6,
                ),
                DropdownButtonFormField(
                  value: statusPercentageValue,
                  items: statusPercentage
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      statusPercentageValue = value!;
                    });
                  },
                  hint: Text('Status Percentage'),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> updateTroop() async {
    if (statusValue.isNotEmpty && statusPercentageValue.isNotEmpty) {
      setState(() {
        _status = false;
      });
      Map<String, dynamic> data = {
        'id': widget.troop.id,
        'status': statusValue.toUpperCase(),
        'statusPercentage': int.parse(statusPercentageValue)
      };
      bool? isSuccess = await RemoteService.updateTroop(data);
      if (isSuccess!) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Updated Successfully'),
            duration: Duration(seconds: 3, milliseconds: 0)));
        Navigator.pop(context);
      }
    }
  }
}
