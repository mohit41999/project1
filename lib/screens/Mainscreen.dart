import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task3/widgets/reusablecard.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String airname;
  String aircountry;
  String airheadquarters;
  String imageurl;
  ScrollController _scrollController = new ScrollController();

  bool isLoading = false;

  List names = [];
  int page = 0;

  final dio = new Dio();
  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      final response = await dio.get(
          "https://api.instantwebtools.net/v1/passenger?page=$page&size=8");
      List tempList = [];
      page++;

      for (int i = 0; i < response.data['data'].length; i++) {
        tempList.add(response.data['data'][i]);
      }

      setState(() {
        isLoading = false;
        names.addAll(tempList);
      });
    }
  }

  @override
  void initState() {
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      child: GridView.builder(
        controller: _scrollController,
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          try {
            airname = names.elementAt(index)['airline']["name"];

            aircountry = names.elementAt(index)['airline']["country"];
            airheadquarters = names.elementAt(index)['airline']["head_quaters"];
            imageurl = names.elementAt(index)['airline']["logo"];
          } catch (e) {
            try {
              airname = names.elementAt(index)['airline'][index]["name"];
              aircountry = names.elementAt(index)['airline'][index]["country"];
              airheadquarters =
                  names.elementAt(index)['airline'][index]["head_quaters"];
              imageurl = names.elementAt(index)['airline'][index]["logo"];
            } catch (e) {}
          }

          return Reusablecard(
            aircountry: aircountry,
            airheadquarters: airheadquarters,
            airname: airname,
            imageurl: imageurl,
          );
        },
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }
}
