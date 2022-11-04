import 'package:flutter_lol/src/domain/entities/summoner.dart';

class Team {
  final Summoner topLaner;
  final Summoner jugleLaner;
  final Summoner bottomLaner;
  final Summoner middleLaner;
  final Summoner supportLaner;

  const Team({
    required this.topLaner,
    required this.jugleLaner,
    required this.bottomLaner,
    required this.middleLaner,
    required this.supportLaner,
  });

  @override
  String toString() {
    return '''top - $topLaner
jungle - $jugleLaner
mid - $middleLaner
bot - $bottomLaner | $supportLaner
''';
  }
}
