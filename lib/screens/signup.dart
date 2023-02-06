import 'package:Mugavan/screens/auth.dart';
import 'package:Mugavan/service/remote_service.dart';
import 'package:Mugavan/utils/shared.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  RemoteService remoteService = RemoteService();

  var _isLoading = false;

  TextEditingController? phoneController;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'முகவர் கணக்கு',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 1,
      ),
      body: showBody(),
    );
  }

  Widget showBody() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('கணக்கை உருவாக்க அல்லது உள்செல்ல தொலைபேசியை பதிவிடவும்'),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'தொலைபேசி எண் தேவை';
                  } else if (!RegExp('^[6-9]\\d{9}\$').hasMatch(value)) {
                    return 'சரியான தொலைபேசி எண்ணை பதிவிடவும்';
                  } else {
                    return null;
                  }
                },
                controller: phoneController,
                decoration: InputDecoration(
                    hintText: 'தொலைபேசி எண்னை பதிவிடவும்',
                    labelText: 'தொலைபேசி எண்',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)))),
            SizedBox(
              height: 40.0,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : MaterialButton(
                    padding: EdgeInsets.all(16.0),
                    minWidth: double.infinity,
                    height: 46,
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String? phone = phoneController?.text.toString()!;
                        Shared.setPhonenumber(phone!);
                        createAccount();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'சமர்ப்பி',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void createAccount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool isSuccess = await remoteService
          .createAccount({'phone': phoneController?.text.toString()});
      if (isSuccess) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth()));
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
