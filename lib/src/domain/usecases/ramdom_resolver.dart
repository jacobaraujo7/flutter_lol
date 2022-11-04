import 'package:flutter_lol/src/domain/entities/summoner.dart';
import 'package:flutter_lol/src/domain/exceptions/game_exception.dart';
import 'package:fpdart/fpdart.dart';

abstract class RamdomResolver {
  Either<GameException, List<Summoner>> call(List<Summoner> summoners);
}

class RamdomResolverImpl implements RamdomResolver {
  @override
  Either<GameException, List<Summoner>> call(List<Summoner> summoners) {
    summoners.shuffle();
    var remainSet = remainPositions(summoners);

    while (summoners.where((e) => e.position == Position.ramdom).isNotEmpty) {
      final index = summoners.indexWhere((e) => e.position == Position.ramdom);
      final position = remainSet.first;
      summoners[index] = summoners[index].copyWith(position: position);

      remainSet = remainPositions(summoners);
    }

    if (remainSet.isNotEmpty) {
      final text = remainSet.map((e) => e.name).join(', ');
      return GameException.left('Necessário cubrir mais lanes: ($text);');
    }

    return right(summoners);
  }

  Set<Position> remainPositions(List<Summoner> summoners) {
    final map = summoners //
        .map(_mapToPosition)
        .fold<Map<Position, int>>({}, _mapPositions);

    final diffSet = Position.values.toSet();
    diffSet.remove(Position.ramdom);
    diffSet.removeWhere(map.keys.contains);

    for (var key in map.keys) {
      if (key == Position.ramdom) {
        continue;
      }
      if (map[key]! < 2) {
        diffSet.add(key);
      }
    }

    return diffSet;
  }

  Position _mapToPosition(Summoner summoner) {
    return summoner.position;
  }

  Map<Position, int> _mapPositions(Map<Position, int> mapPositions, Position position) {
    if (mapPositions.containsKey(position)) {
      mapPositions[position] = mapPositions[position]! + 1;
    } else {
      mapPositions[position] = 1;
    }
    return mapPositions;
  }
}
