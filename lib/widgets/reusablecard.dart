import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reusablecard extends StatefulWidget {
  final String airname;
  final String aircountry;
  final String airheadquarters;
  final String imageurl;

  const Reusablecard(
      {Key key,
      this.airname,
      this.aircountry,
      this.airheadquarters,
      this.imageurl})
      : super(key: key);

  @override
  _ReusablecardState createState() => _ReusablecardState();
}

class _ReusablecardState extends State<Reusablecard> {
  @override
  Widget build(BuildContext context) {
    String url = widget.imageurl;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      image: DecorationImage(
                          image: NetworkImage(
                            "$url",
                          ),
                          fit: BoxFit.contain)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.cyan),
                            child: Text(
                              "Featured",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                        Icon(
                          Icons.favorite,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "\$12112",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.airname,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.aircountry,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                CupertinoIcons.location,
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Text(
                                  widget.airheadquarters,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
