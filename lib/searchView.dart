import 'package:flutter/material.dart';
import 'models/currentA_model.dart';
import 'services.dart';
import 'homeView.dart';
import 'models/currentA_model.dart';
import 'models/details_model.dart';
import 'details.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

import 'services.dart';

List<String> hello;

class SearchList extends StatefulWidget {
  String url = 'https://api.jikan.moe/v3';

  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = new Text(
    "Anime Search",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }
  /*Future getTitleData() {
    AsyncSnapshot snapshot;
    if (snapshot.connectionState == ConnectionState.done) {
      hello.add(getCurrentAnime());
      for (int i = 0; i < 20; i++) {
        _list.add('${snapshot.data.anime[i].title}');
      }
    }
  }*/

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    init();
  }

  void init() {
    _list = List();
    _list.add("Naruto Shippuden");
    _list.add("Neon Genisis Evangellion");
    _list.add("Soul Eater");
    _list.add("Durarara");
    _list.add("Beastars");
    _list.add("Jujustu Kaisen");
    _list.add("One Piece");
    _list.add("Bleach");
    _list.add("Jojo's Bizarre Adventure");
    _list.add("Hunter x Hunter");
    _list.add("Boku No Hero Academia");
    _list.add("Sword Art Online");
    _list.add("Made In the Abyss");
    _list.add("A Place Further Than The Universe");
    _list.add("Dorehedoro");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _IsSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => new ChildItem(contact)).toList();
    } else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _searchQuery,
                autofocus: true,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "Search...",
                    hintStyle: new TextStyle(color: Colors.white)),
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search);
      this.appBarTitle = new Text("Anime Search");
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class ChildItem extends StatelessWidget {
  final String name;

  ChildItem(this.name);

  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(this.name));
  }
}
