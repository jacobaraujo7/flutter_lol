import 'package:flutter_lol/src/domain/entities/summoner.dart';
import 'package:flutter_lol/src/domain/usecases/ramdom_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../matchers/either_matcher.dart';

void main() {
  late RamdomResolver usecase;

  setUp(() {
    usecase = RamdomResolverImpl();
  });
  test('should return the same list after validation', () {
    final summoners = [
      const Summoner(nick: 'S1', position: Position.jungle),
      const Summoner(nick: 'S2', position: Position.middle),
      const Summoner(nick: 'S3', position: Position.middle),
      const Summoner(nick: 'S4', position: Position.ramdom),
      const Summoner(nick: 'S5', position: Position.top),
      const Summoner(nick: 'S6', position: Position.support),
      const Summoner(nick: 'S7', position: Position.adc),
      const Summoner(nick: 'S8', position: Position.support),
      const Summoner(nick: 'S9', position: Position.ramdom),
      const Summoner(nick: 'S10', position: Position.top),
    ];
    final result = usecase.call(summoners);

    expect(result, isRight);
  });

  test('if miss lane, return a GameException', () {
    final result = usecase.call([
      const Summoner(nick: 'S1', position: Position.jungle),
      const Summoner(nick: 'S2', position: Position.middle),
      const Summoner(nick: 'S3', position: Position.middle),
      const Summoner(nick: 'S4', position: Position.jungle),
      const Summoner(nick: 'S5', position: Position.top),
      const Summoner(nick: 'S6', position: Position.jungle),
      const Summoner(nick: 'S7', position: Position.adc),
      const Summoner(nick: 'S8', position: Position.jungle),
      const Summoner(nick: 'S9', position: Position.jungle),
      const Summoner(nick: 'S10', position: Position.jungle),
    ]);

    expect(result, isLeft);
  });
}
