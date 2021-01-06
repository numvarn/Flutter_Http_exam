import 'package:flutter/material.dart';
import 'package:getAPI/get_api.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Get Thailand Covid Stat via API'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => GetAPI()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
