import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task3/widgets/reusablecard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String airname;
  String aircountry;
  String airheadquarters;
  String imageurl;
  Map airlines = {};
  List data2 = [];
  int page = 1;

  Future<Map> getData() async {
    Response response = await Dio()
        .get("https://api.instantwebtools.net/v1/passenger?page=$page&size=8");
    page++;
    return response.data;
  }

  @override
  void initState() {
    getData().then((data) {
      setState(() {
        airlines = data;
        data2 = airlines['data'];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(data2);
    setState(() {
      getData();
    });

    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: Text('Task 3'),
        centerTitle: true,
      ),
      body: Container(
        child: GridView.builder(
          itemCount: data2.length,
          itemBuilder: (BuildContext context, int index) {
            airname = airlines['data'].elementAt(index)['airline']["name"];
            aircountry =
                airlines['data'].elementAt(index)['airline']["country"];
            airheadquarters =
                airlines['data'].elementAt(index)['airline']["head_quaters"];
            imageurl = airlines['data'].elementAt(index)['airline']["logo"];
            return Reusablecard(
              aircountry: aircountry,
              airheadquarters: airheadquarters,
              airname: airname,
              imageurl: imageurl,
            );
          },
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        ),
      ),
    );
  }
}
