import 'package:flutter_lol/src/domain/entities/rift.dart';
import 'package:flutter_lol/src/domain/entities/team.dart';
import 'package:flutter_lol/src/domain/exceptions/game_exception.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/summoner.dart';

abstract class CreateRift {
  Either<GameException, Rift> call(List<Summoner> summoners);
}

class CreateRiftImpl implements CreateRift {
  @override
  Either<GameException, Rift> call(List<Summoner> summoners) {
    summoners.shuffle();

    final blueTeam = Team(
      topLaner: summoners.firstWhere((e) => e.position == Position.top),
      jugleLaner: summoners.firstWhere((e) => e.position == Position.jungle),
      bottomLaner: summoners.firstWhere((e) => e.position == Position.adc),
      middleLaner: summoners.firstWhere((e) => e.position == Position.middle),
      supportLaner: summoners.firstWhere((e) => e.position == Position.support),
    );
    final redTeam = Team(
      topLaner: summoners.lastWhere((e) => e.position == Position.top),
      jugleLaner: summoners.lastWhere((e) => e.position == Position.jungle),
      bottomLaner: summoners.lastWhere((e) => e.position == Position.adc),
      middleLaner: summoners.lastWhere((e) => e.position == Position.middle),
      supportLaner: summoners.lastWhere((e) => e.position == Position.support),
    );

    final rift = Rift(blueTeam: blueTeam, redTeam: redTeam);

    return right(rift);
  }
}
