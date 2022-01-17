import 'package:flutter/material.dart';
import 'package:jikan_dart/jikan_dart.dart';
import 'package:jikanganai/models/details_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:jikanganai/services.dart';

void toDetailsScreen(BuildContext context, String id) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(animeInfo: id),
      ));
}

class DetailsScreen extends StatelessWidget {
  final animeInfo;

  DetailsScreen({Key key, @required this.animeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Details>(
        future: getDetails(animeInfo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: Text('${snapshot.data.title}'),
                  leading: IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () {
                      _backToList(context);
                    },
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    //add pressed code here
                  },
                  child: Icon(Icons.thumb_up),
                ),
                body: new SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: '${snapshot.data.imageUrl}',
                          ))
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child:
                                  Icon(Icons.star, color: Colors.orangeAccent)),
                          Text(
                            '${snapshot.data.score}',
                            style: TextStyle(fontSize: 20),
                          )
                        ]),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Synopsis',
                          style: TextStyle(fontFamily: 'Saira', fontSize: 23),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('${snapshot.data.synopsis}',
                          style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Type',
                          style: TextStyle(fontFamily: 'Saira', fontSize: 23),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('${snapshot.data.type}',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                )));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  void _backToList(BuildContext context) {
    Navigator.pop(context);
  }
}
