import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercovid19tracker/countryList.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'countryList.dart';

class DetailPage extends StatelessWidget {

  DetailPage({@required this.countryName});
  final String countryName ;

  Future<Album> fetchAlbum() async {
    final response = await http.get(
      'https://corona.lmao.ninja/v2/countries/$countryName',
      headers: {HttpHeaders.authorizationHeader: "Basic your_api_token_here"},
    );
    final responseJson = json.decode(response.body);

    return Album.fromJson(responseJson);
  }
  @override
  Widget build(BuildContext context) {
    Future<Album> futureAlbum;
      futureAlbum = fetchAlbum();
      return Scaffold(
          appBar: AppBar(
            title: Text(countryName),
          ),
          body: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Global States',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Cases', value: snapshot.data.cases.toString()),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Today Cases',
                          value: snapshot.data.todayCases.toString()),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Death', value: snapshot.data.deaths.toString()),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Today Deaths',
                          value: snapshot.data.todayDeaths.toString()),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Recovered',
                          value: snapshot.data.recovered.toString()),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Roday Recovered',
                          value: snapshot.data.todayRecovered.toString()),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Active', value: snapshot.data.active.toString()),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Critical',
                          value: snapshot.data.critical.toString()),
                      SizeBoxWidget(),
                      ReusableRow(
                          label: 'Test', value: snapshot.data.tests.toString()),
                      SizeBoxWidget(),

                    ],
                  ),
                );
                //Text(snapshot.data.cases.toString());
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            },
          )

      );
    }
  }


class ReusableRow extends StatelessWidget {
  ReusableRow({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
class SizeBoxWidget extends StatelessWidget {
  const SizeBoxWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Divider(
        color: Colors.white70,
      ),
    );
  }
}


class Album {
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;
  final int active;
  final int critical;
  final int tests;
  final int affectedCountries;

  Album(
      {this.cases,
        this.todayCases,
        this.deaths,
        this.todayDeaths,
        this.recovered,
        this.todayRecovered,
        this.active,
        this.critical,
        this.tests,
        this.affectedCountries});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      todayRecovered: json['todayRecovered'],
      active: json['active'],
      critical: json['critical'],
      tests: json['tests'],
      affectedCountries: json['affectedCountries'],
    );
  }
}
