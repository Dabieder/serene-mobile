import 'package:flutter/material.dart';
import 'package:serene/screens/goal_selection_screen.dart';
import 'package:serene/screens/goal_shielding_internalisation_screen.dart';
import 'package:serene/screens/goal_shielding_selection_screen.dart';
import 'package:serene/widgets/serene_drawer.dart';

class GoalShieldingScreen extends StatefulWidget {
  @override
  _GoalShieldingScreenState createState() => _GoalShieldingScreenState();
}

class _GoalShieldingScreenState extends State<GoalShieldingScreen> {
  int _index;
  final _controller = new PageController();
  final _kDuration = const Duration(milliseconds: 300);
  final _kCurve = Curves.ease;

  final List<Widget> _goalShieldingPages = [
    GoalSelectionScreen(),
    GoalShieldingSelectionScreen(),
    GoalShieldingInternalisationScreen()
  ];

  @override
  void initState() {
    super.initState();
    _index = 1;
  }

  _buildBottomNavigation() {
    print("index is $_index ");
    print("length is ${_goalShieldingPages.length} ");
    return Container(
      // color: Colors.lightBlue[50],
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _index > 1,
            child: FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.navigate_before),
                  Text("Zurück"),
                ],
              ),
              onPressed: () {
                setState(() {
                  _index--;
                });
                _controller.previousPage(duration: _kDuration, curve: _kCurve);
              },
            ),
          ),
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _index < _goalShieldingPages.length,
            child: FlatButton(
              child: Row(
                children: <Widget>[Text("Weiter"), Icon(Icons.navigate_next)],
              ),
              onPressed: () {
                setState(() {
                  _index++;
                });
                _controller.nextPage(duration: _kDuration, curve: _kCurve);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Calling Build In Goal Shielding Screen");
    if (_goalShieldingPages?.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        textTheme:
            TextTheme(title: TextStyle(color: Colors.black, fontSize: 22)),
        centerTitle: true,

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(""),
      ),
      drawer: SereneDrawer(),
      // backgroundColor: Colors.amber,
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Flexible(
              child: PageView.builder(
                controller: _controller,
                itemCount: _goalShieldingPages.length,
                itemBuilder: (context, index) {
                  return _goalShieldingPages[index];
                },
              ),
            ),
            _buildBottomNavigation()
          ],
        ),
      ),
    );
  }
}
