import 'team.dart';

class Rift {
  final Team blueTeam;
  final Team redTeam;

  const Rift({
    required this.blueTeam,
    required this.redTeam,
  });

  @override
  String toString() {
    return '''Rift

-- BLUE TEAM --
$blueTeam

-- RED TEAM --
$redTeam
''';
  }
}
