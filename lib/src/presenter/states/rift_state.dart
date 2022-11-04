import 'package:flutter_lol/src/domain/entities/rift.dart';
import 'package:flutter_lol/src/domain/entities/summoner.dart';

class RiftState {
  final List<Summoner> summoners;
  final String errorMessage;
  final Rift? rift;

  factory RiftState.init() {
    final initialSummoners = <Summoner>[
      Summoner.init(),
      Summoner.init(),
      Summoner.init(),
      Summoner.init(),
      Summoner.init(),
      Summoner.init(),
      Summoner.init(),
      Summoner.init(),
      Summoner.init(),
      Summoner.init(),
    ];
    return RiftState._(initialSummoners, '', null);
  }

  const RiftState._(this.summoners, this.errorMessage, this.rift);

  RiftState copyWith({
    List<Summoner>? summoners,
    String? errorMessage,
    Rift? rift,
  }) {
    return RiftState._(
      summoners ?? this.summoners,
      errorMessage ?? this.errorMessage,
      rift ?? this.rift,
    );
  }
}
