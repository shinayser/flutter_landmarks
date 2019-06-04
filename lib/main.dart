import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:landmarks_flutter/views/landmark_cell.dart';
import 'package:landmarks_flutter/models/data.dart';

void main() {
  loadData().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landmarks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Landmarks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showFavoritesOnly = false;
  List<SliverToBoxAdapter> _landmarkWidgets;

  @override
  void initState() {
    super.initState();
    _landmarkWidgets =
        List<SliverToBoxAdapter>.generate(landmarkData.length, (index) {
      return SliverToBoxAdapter(
        child: LandmarkCell(
          landmark: landmarkData[index],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(widget.title),
              backgroundColor: Colors.white,
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 5.0),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Show Favorites Only',
                      style: TextStyle().copyWith(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Spacer(),
                  CupertinoSwitch(
                    value: _showFavoritesOnly,
                    onChanged: (state) {
                      setState(() {
                        _showFavoritesOnly = state;
                      });
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Divider(indent: 15.0),
            ),
          ]..addAll(_landmarkWidgets),
        ),
      ),
    );
  }
}
