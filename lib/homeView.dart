import 'package:flutter/material.dart';
import 'package:jikan_dart/jikan_dart.dart';
import 'package:jikanganai/models/currentA_model.dart';
import 'package:jikanganai/services.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:io';
import 'package:jikanganai/details.dart';
import 'package:async/async.dart';

List<String> titleList;

class HomeWidget extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeWidget> {
  Future<CurrentSeason> _loadAnime;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      const SliverAppBar(
        leading: Icon(Icons.live_tv),
        pinned: false,
        expandedHeight: 100.0,
        flexibleSpace: FlexibleSpaceBar(
          title: Text('Anime Encyclopedia'),
        ),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          Center(
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Popular this Season',
                      style: TextStyle(fontFamily: 'Saira', fontSize: 30)))),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 500.0,
            child: FutureBuilder<CurrentSeason>(
                future: getCurrentAnime(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 20,
                        itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    toDetailsScreen(context,
                                        '${snapshot.data.anime[index].malId}');
                                  },
                                  //child: Container( child: Text("Hi"),
                                  child: Column(children: <Widget>[
                                    Text(
                                      '${snapshot.data.anime[index].title}',
                                      style: TextStyle(
                                          fontFamily: 'RedHatDisplay',
                                          fontSize: 20),
                                    ),
                                    ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            image:
                                                '${snapshot.data.anime[index].imageUrl}'))
                                  ])),
                            ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ]),
      )
    ]);
  }
}
