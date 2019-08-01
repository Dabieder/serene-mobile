import 'package:flutter/material.dart';
import 'package:implementation_intentions/models/implementation_intention.dart';
import 'package:provider/provider.dart';

class GoalShielding extends StatefulWidget {
  @override
  _GoalShieldingState createState() => _GoalShieldingState();
}

class _GoalShieldingState extends State<GoalShielding> {
  List<String> hindrances = ["Watching TV", "Playing Games"];
  List<String> shields = ["Turn it off", "Curl into a ball and cry"];
  String selectedHindrance;

  buildObstacleDropdown() {
    final intention = Provider.of<ImplementationIntentionModel>(context);
    return DropdownButton<String>(
      value: selectedHindrance,
      onChanged: (String newValue) {
        intention.hindrance = newValue;
        setState(() {
          selectedHindrance = newValue;
        });
      },
      items: hindrances.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }

  buildShieldItem(String shield) {
    final intention = Provider.of<ImplementationIntentionModel>(context);

    return CheckboxListTile(
      title: Text(shield),
      value: intention.shieldingActions.contains(shield),
      onChanged: (bool value) {
        if (value)
          intention.addShieldingAction(shield);
        else
          intention.removeShieldingAction(shield);
      },
    );
  }

  buildShieldSelection() {
    return Column(children: <Widget>[
      for (var shield in shields) buildShieldItem(shield)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Text("My biggest obstacle is...", textAlign: TextAlign.left),
          SizedBox(height: 10),
          buildObstacleDropdown(),
          SizedBox(height: 10),
          Text("To overcome this, I will...", textAlign: TextAlign.left),
          SizedBox(height: 10),
          buildShieldSelection()
        ],
      ),
    );
  }
}
