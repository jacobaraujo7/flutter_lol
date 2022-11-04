enum Position {
  top,
  jungle,
  middle,
  adc,
  support,
  ramdom,
}

class Summoner {
  final String nick;
  final Position position;

  factory Summoner.init() => const Summoner(nick: 'Add Nick', position: Position.ramdom);

  const Summoner({
    required this.nick,
    required this.position,
  });

  Summoner copyWith({
    String? nick,
    Position? position,
  }) {
    return Summoner(
      nick: nick ?? this.nick,
      position: position ?? this.position,
    );
  }

  @override
  String toString() {
    return '$nick(${position.name})';
  }
}
