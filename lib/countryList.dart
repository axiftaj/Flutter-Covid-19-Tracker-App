import 'package:flutter/material.dart';
import 'details.dart';
import 'package:fluttercovid19tracker/details.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  Future<List<CountriesList>> _gerCountriesList() async {
    var data = await http.get("https://corona.lmao.ninja/v2/countries");
    var jsonData = json.decode(data.body);
    List<CountriesList> users = [];
    for (var u in jsonData) {
      CountriesList user = CountriesList(u["country"]);
      users.add(user);
    }

    print(users.length);
    return users;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _gerCountriesList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name.toString()),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                countryName: snapshot.data[index].name.toString(),
                                  )));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CountriesList {
  final String name;
  CountriesList(this.name);
}
