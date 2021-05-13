import 'package:flutter/material.dart';
import 'package:sqflite_login/ModelViewFolder/modelview.dart';
import 'package:sqflite_login/generated/l10n.dart';
import 'package:sqflite_login/model/dbModel.dart';
import 'package:sqflite_login/widgets/widgetFunctions.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _formKey;
  DataBaseClass dbInstance;
  @override
  void initState() {
    _formKey = GlobalKey();
    dbInstance = DataBaseClass.instance;
    super.initState();
  }

  @override
  void dispose() {
    _formKey = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(fit: StackFit.expand, children: [
        Container(
          child: Image.asset(
            'assets/food2.jpg',
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.dstOver,
            color: Colors.white30,
          ),
        ),
        Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidget(
                  label: S.of(context).Register,
                  fontcolor: Colors.amber[900],
                  fontsize: 60,
                  weight: FontWeight.bold,
                  font: 'Lobster'),
              textWidget(
                  label: S.of(context).Here,
                  fontcolor: Colors.amber[900],
                  fontsize: 60,
                  weight: FontWeight.bold,
                  font: 'Lobster'),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      formFieldWidget(
                          icon: Icons.person,
                          hint: S.of(context).hintname,
                          label: S.of(context).name,
                          context: context,
                          data: S.of(context).name,
                          pattern: getPattern(S.of(context).name),
                          hideText: false,
                          error: S.of(context).NameError,
                          type: false),

                      SizedBox(height: 20.0),
                      formFieldWidget(
                          icon: Icons.mobile_friendly,
                          hint: S.of(context).Contact_No,
                          label: S.of(context).contact,
                          context: context,
                          data: S.of(context).contact,
                          pattern: getPattern(S.of(context).contact),
                          hideText: false,
                          error: S.of(context).valid_contact,
                          type: false),
                      SizedBox(height: 20.0),
                      formFieldWidget(
                          icon: Icons.email,
                          hint: S.of(context).hintMail,
                          label: S.of(context).Email,
                          context: context,
                          data: S.of(context).Email,
                          pattern: getPattern(S.of(context).Email),
                          hideText: false,
                          error: S.of(context).Enter_Mail_ID,
                          type: false),
                      SizedBox(height: 20.0),
                      formFieldWidget(
                          icon: Icons.lock,
                          hint: S.of(context).Enter_password,
                          label: S.of(context).Password,
                          context: context,
                          data: S.of(context).Password,
                          pattern:getPattern(S.of(context).Password),
                          hideText: true,
                          error: S.of(context).Enter_valid_password,
                          type: false),
                      SizedBox(height: 20.0),
                      MaterialButton(
                        height: 50.0,
                        minWidth: 150.0,
                        color: Colors.green,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: Icon(Icons.login),
                        onPressed: () {
                          createRecord();
                        },
                      ),
                      SizedBox(height: 20.0),

                      // ignore: deprecated_member_use
                      FlatButton.icon(
                          color: Colors.white38,
                          height: 50.0,
                          minWidth: 150.0,
                          splashColor: Colors.teal,
                          icon: Icon(
                            Icons.login_rounded,
                            color: Colors.indigo[900],
                          ),
                          label: Text(
                            S.of(context).Login,
                            style: TextStyle(
                                color: Colors.indigo[900],
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );

  }

  void createRecord() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      insertData() ;
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (err) {
      String errorMessage = S.of(context).Registration_Failed;
      _showErrorDialog(errorMessage);
    }
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(S.of(context).An_Error_Occured),
              content: Text(msg),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text(S.of(context).okay),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }
}
