import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;

class GetAPI extends StatefulWidget {
  GetAPI({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GetAPIState createState() => _GetAPIState();
}

class _GetAPIState extends State<GetAPI> {
  var jsonData;
  Map<String, int> data = {};

  final keys = [
    'confirmed',
    'recovered',
    'hospitalized',
    'deaths',
    'newConfirmed',
    'newRecovered',
    'newHospitalized',
    'newDeaths'
  ];

  Future<String> _getCovid19TodayAPI() async {
    var response = await Http.get(
      "https://covid19.th-stat.com/api/open/today",
    );

    jsonData = json.decode(utf8.decode(response.bodyBytes));

    data['confirmed'] = jsonData['Confirmed'];
    data['recovered'] = jsonData['Recovered'];
    data['hospitalized'] = jsonData['Hospitalized'];
    data['deaths'] = jsonData['Deaths'];
    data['newConfirmed'] = jsonData['NewConfirmed'];
    data['newRecovered'] = jsonData['NewRecovered'];
    data['newHospitalized'] = jsonData['NewHospitalized'];
    data['newDeaths'] = jsonData['NewDeaths'];

    return "OK";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thai Covid-19 Today",
        ),
      ),
      body: Center(
          child: new FutureBuilder(
              future: _getCovid19TodayAPI(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // color: Colors.lightBlueAccent,
                          color: new Color(0x7134eb),
                          elevation: 1,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: new Container(
                            padding: new EdgeInsets.all(32.0),
                            child: new Column(
                              children: <Widget>[
                                new Text(
                                  '${data[keys[index]]}',
                                ),
                                new Text(
                                  '${keys[index]}',
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
