import 'package:flutter_lol/src/domain/exceptions/game_exception.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/summoner.dart';

abstract class VerifySummoners {
  Either<GameException, List<Summoner>> call(List<Summoner> summoners);
}

class VerifySummonersImpl implements VerifySummoners {
  @override
  Either<GameException, List<Summoner>> call(List<Summoner> summoners) {
    if (summoners.length != 10) {
      return GameException.left('Precisa ter exatamente 10 invocadores.');
    }

    return right(summoners);
  }
}
