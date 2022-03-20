import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RtnwMoreInfo extends StatefulWidget {
  const RtnwMoreInfo({Key? key}) : super(key: key);


  @override
  _RtnwMoreInfoState createState() => _RtnwMoreInfoState();
}

class _RtnwMoreInfoState extends State<RtnwMoreInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Want more info?"),
        automaticallyImplyLeading: true,
      ),
      body: const Center(
        child: ElevatedButton(
          onPressed: _launchURL,
          child: Text('Get the App'),
        ),
      )
    );
  }
}

_launchURL() async {
  const url = 'https://www.thewealthyniche.com/app';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}