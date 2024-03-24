import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hike Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HikeList(),
    );
  }
}

class Hike {
  final String title;
  final String content;

  Hike({required this.title, required this.content});

  factory Hike.fromJson(Map<String, dynamic> json) {
    return Hike(
      title: json['title']['rendered'],
      content: json['content']['rendered'],
    );
  }
}

class HikeList extends StatefulWidget {
  @override
  _HikeListState createState() => _HikeListState();
}

class _HikeListState extends State<HikeList> {
  late Future<List<Hike>> futureHikes;

  @override
  void initState() {
    super.initState();
    futureHikes = fetchHikes();
  }

  Future<List<Hike>> fetchHikes() async {
    final response = await http.get(Uri.parse('https://hikemaniak.co.ke/wp-json/wp/v2/hike'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Hike> hikes = jsonResponse.map((e) => Hike.fromJson(e)).toList();
      return hikes;
    } else {
      throw Exception('Failed to load hikes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hike Data'),
      ),
      body: Center(
        child: FutureBuilder<List<Hike>>(
          future: futureHikes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].content),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}