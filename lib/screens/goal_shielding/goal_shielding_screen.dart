import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serene/locator.dart';
import 'package:serene/screens/add_goal_screen.dart';
import 'package:serene/screens/goal_shielding/goal_selection_screen.dart';
import 'package:serene/screens/goal_shielding/goal_shielding_internalisation_screen.dart';
import 'package:serene/screens/goal_shielding/goal_shielding_selection_screen.dart';
import 'package:serene/services/data_service.dart';
import 'package:serene/viewmodels/add_goal_view_model.dart';
import 'package:serene/viewmodels/goal_shielding_view_model.dart';
import 'package:serene/widgets/serene_appbar.dart';
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
    var vm = Provider.of<GoalShieldingViewModel>(context);
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _index > 1 && _index < _goalShieldingPages.length - 1,
            child: FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(Icons.navigate_before),
                  Text(
                    "Zurück",
                    style: TextStyle(fontSize: 20),
                  ),
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
            visible: _index < _goalShieldingPages.length && vm.canMoveNext(),
            child: FlatButton(
              child: Row(
                children: <Widget>[
                  Text(
                    "Weiter",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.navigate_next)
                ],
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

  _buildAddGoalButton() {
    if (_index != 1) {
      return null;
    }
    return FloatingActionButton(
      backgroundColor: Colors.blue[400],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Icon(Icons.add),
      onPressed: () async {
        await showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.green,
                child: ChangeNotifierProvider(
                  create: (_) =>
                      AddGoalViewModel(dataService: locator.get<DataService>()),
                  child: AddGoalScreen(),
                ),
              );
            });
        Provider.of<GoalShieldingViewModel>(context, listen: false)
            .refetchGoals();
      },
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
        appBar: SereneAppBar(title: ""),
        floatingActionButton: _buildAddGoalButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        drawer: SereneDrawer(),
        // backgroundColor: Colors.amber,
        body: Stack(
          children: <Widget>[
            // _buildBackgroundImage(),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                      controller: _controller,
                      physics: NeverScrollableScrollPhysics(),
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
          ],
        ));
  }
}
