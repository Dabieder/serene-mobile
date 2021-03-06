import 'package:serene/models/obstacle.dart';
import 'package:serene/models/outcome.dart';
import 'package:serene/services/data_service.dart';
import 'package:serene/viewmodels/base_view_model.dart';

class InitSessionViewModel extends BaseViewModel {
  int step = 0;

  var obstacles = <Obstacle>[
    Obstacle(
        name: "Überforderung",
        description: "Die Aufgaben sind zu schwer.",
        iconPath: "assets/icons/mathematics.png"),
    Obstacle(
        name: "Konzentration",
        description: "Ich kann mich nicht auf das Lernen konzentrieren.",
        iconPath: "assets/icons/brain.png"),
    Obstacle(
        name: "Lustlosigkeit",
        description: "Ich habe keine Lust, zu lernen.",
        iconPath: "assets/icons/computer.png"),
    Obstacle(
        name: "Ablenkungen",
        description: "Ich habe zu viele andere Sachen zu tun.",
        iconPath: "assets/icons/education.png"),
    Obstacle(
        name: "Gesundheit",
        description: "Ich fühle mich nicht fit genug zum Lernen.",
        iconPath: "assets/icons/anatomy.png"),
    Obstacle(
        name: "Lehrer",
        description: "Mein Lehrer ist immer an allem Schuld!",
        iconPath: "assets/icons/teacher.png"),
  ];

  var selectedObstacles = <Obstacle>[];

  var outcomes = <Outcome>[
    Outcome(
        name: "Stolz anderer Personen",
        description:
            "Dann sind andere Personen (z.B. meine Eltern) stolz auf mich.",
        iconPath: "assets/icons/mathematics.png"),
    Outcome(
        name: "Mein Stolz",
        description: "Dann bin ich selbst stolz auf mich.",
        iconPath: "assets/icons/mehappy.png"),
    Outcome(
        name: "Fähigkeiten",
        description: "Dann kann ich mich besser auf Englisch unterhalten.",
        iconPath: "assets/icons/user.png"),
    Outcome(
        name: "Lieder",
        description: "Dann kann ich meine Lieblingslieder besser verstehen.",
        iconPath: "assets/icons/musicnote.png"),
    Outcome(
        name: "Videospiele",
        description: "Dann kann ich meine Videospiele besser verstehen.",
        iconPath: "assets/icons/gamepad.png"),
    Outcome(
        name: "Arbeit",
        description:
            "Dann kriege ich eine bessere Arbeit wenn ich mit der Schule fertig bin.",
        iconPath: "assets/icons/teamwork.png"),
  ];

  DataService _dataService;

  InitSessionViewModel(this._dataService);

  var selectedOutcomes = <Outcome>[];

  outcomeSelected(Outcome outcome) {
    if (selectedOutcomes.contains(outcome)) {
      selectedOutcomes.remove(outcome);
    } else {
      selectedOutcomes.add(outcome);
    }

    notifyListeners();
  }

  obstacleSelected(Obstacle obstacle) {
    if (selectedObstacles.contains(obstacle)) {
      selectedObstacles.remove(obstacle);
    } else {
      selectedObstacles.add(obstacle);
    }

    notifyListeners();
  }

  bool canMoveNext() {
    return (step == 0 && selectedObstacles.length > 0) ||
        (step == 1 && selectedObstacles.length > 0) ||
        (step == 2 && selectedOutcomes.length > 0) ||
        (step == 3 && selectedOutcomes.length > 0);
  }

  saveSelected() async {
    await _dataService.saveSelectedOutcomes(selectedOutcomes);
    await _dataService.saveSelectedObstacles(selectedObstacles);
  }
}
