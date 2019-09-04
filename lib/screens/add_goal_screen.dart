import 'package:flutter/material.dart';
import 'package:implementation_intentions/shared/text_styles.dart';
import 'package:implementation_intentions/shared/ui_helpers.dart';
import 'package:implementation_intentions/state/goal_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddGoalScreen extends StatefulWidget {
  @override
  _AddGoalScreenState createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = new TextEditingController(text: "");

    Future.delayed(Duration.zero, () {
      final appState = Provider.of<GoalState>(context);
      _textController.text = appState.currentGoal.goal;
    });
  }

  _canSubmit() {
    final appState = Provider.of<GoalState>(context);
    if (appState.currentGoal.goal != "") {
      return true;
    }
    return false;
  }

  _submitGoal() async {
    final appState = Provider.of<GoalState>(context);
    if (_canSubmit()) {
      await appState.saveCurrentGoal();
      Navigator.pop(context);
    } else {

    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final appState = Provider.of<GoalState>(context);
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      appState.currentGoal.deadline = picked;
  }

  Widget buildTextEntry() {
    final appState = Provider.of<GoalState>(context);

    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(5)),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(labelText: "Gib dein Lernziel ein"),
            keyboardType: TextInputType.text,
            maxLines: null,
            textInputAction: TextInputAction.done,
            onChanged: (text) {
              setState(() {
                appState.currentGoal.goal = text;
              });
            },
          ),
        )
      ],
    );
  }

  Widget buildDatePicker() {
    final appState = Provider.of<GoalState>(context);

    var date = appState.currentGoal.deadline ?? DateTime.now();
    var dateText = DateFormat('dd.MM.yyy').format(date);
    var timeText = DateFormat('kk:mm').format(date);
    return Column(
      children: <Widget>[
        Text(
          "Deadline",
          textAlign: TextAlign.left,
          style: subHeaderStyle,
        ),
        UIHelper.verticalSpaceMedium(),
        InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.black),
                  UIHelper.horizontalSpaceSmall(),
                  Text(
                    "$dateText",
                    style: pickerStyle,
                  ),
                  UIHelper.horizontalSpaceMedium(),
                  // Icon(Icons.timer, color: Colors.black),
                  // UIHelper.horizontalSpaceSmall(),
                  // Text(
                  //   "$timeText",
                  //   style: pickerStyle,
                  // ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neues Ziel'),
        actions: <Widget>[
          FlatButton.icon(
              textColor: Colors.white,
              icon: const Icon(Icons.save),
              label: Text("Speichern"),
              onPressed: () async {
                _submitGoal();
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UIHelper.verticalSpaceMedium(),
              buildTextEntry(),
              UIHelper.verticalSpaceLarge(),
              buildDatePicker(),
              UIHelper.verticalSpaceLarge(),
              SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: RaisedButton(
                    onPressed: () {
                      _submitGoal();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    child: Text("Speichern", style: TextStyle(fontSize: 20)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
