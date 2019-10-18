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

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _goalShieldingPages = [
      GoalSelectionScreen(),
      GoalShieldingSelectionScreen(),
      GoalShieldingInternalisationScreen()
    ];
    final _controller = new PageController();
    const _kDuration = const Duration(milliseconds: 300);
    const _kCurve = Curves.ease;

    print("Calling Build In Goal Shielding Screen");
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
      body: Column(
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
          Container(
            // color: Colors.lightBlue[50],
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Visibility(
                  visible: _index > 0,
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
                      _controller.previousPage(
                          duration: _kDuration, curve: _kCurve);
                    },
                  ),
                ),
                Visibility(
                  visible: _index < _goalShieldingPages.length,
                  child: FlatButton(
                    child: Row(
                      children: <Widget>[
                        Text("Weiter"),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        _index++;
                      });
                      _controller.nextPage(
                          duration: _kDuration, curve: _kCurve);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
