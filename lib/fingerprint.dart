import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class HomePageAuthCheck extends StatefulWidget {
  @override
  _HomePageAuthCheckState createState() => _HomePageAuthCheckState();
}

class _HomePageAuthCheckState extends State<HomePageAuthCheck> {
  //variable to check is biometric is there or not
  bool _hasBiometricSenson;

  // list of finger print added in local device settings
  List<BiometricType> _availableBiomatrics;

  String _isAuthorized = "NOT AUTHORIZED";

  LocalAuthentication authentication = LocalAuthentication();

  //future function to check if biometric senson is available on device
  Future<void> _checkForBiometric() async {
    bool hasBiometric;

    try {
      hasBiometric = await authentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _hasBiometricSenson = hasBiometric;
    });
  }

//future function to get the list of Biometric or faceID added into device
  Future<void> _getListofBiometric() async {
    List<BiometricType> ListofBiometric;

    try {
      ListofBiometric = await authentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiomatrics = ListofBiometric;
    });
  }

  ////future function to check is the use is authorized or no
  Future<void> _getAuthentication() async {
    bool isAutherized = false;

    try {
      isAutherized = await authentication.authenticateWithBiometrics(
          localizedReason: "SCAN YOUR FINGER PRINT TO GET AUTHORIZED",
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _isAuthorized = isAutherized ? "AUTHORIZED" : "NOT AUTHORIZED";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter local Auth Package"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(" Is BioMetric Available ? : $_hasBiometricSenson"),
            RaisedButton(
              onPressed: () {
                _checkForBiometric();
              },
              color: Colors.blue,
              child: Text(
                "Check",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(" List of Available Biomatric LIST : $_availableBiomatrics"),
            RaisedButton(
              onPressed: () {
                _getListofBiometric();
              },
              color: Colors.blue,
              child: Text(
                "Check List",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(" Is AUTHORIED ? : $_isAuthorized"),
            RaisedButton(
              onPressed: () {
                _getAuthentication();
              },
              color: Colors.blue,
              child: Text(
                "AUTH",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
