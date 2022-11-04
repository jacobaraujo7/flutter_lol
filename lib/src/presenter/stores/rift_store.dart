import 'package:flutter/cupertino.dart';
import 'package:flutter_lol/src/domain/entities/summoner.dart';
import 'package:flutter_lol/src/domain/usecases/create_rift.dart';
import 'package:flutter_lol/src/domain/usecases/ramdom_resolver.dart';
import 'package:flutter_lol/src/domain/usecases/verify_summoners.dart';
import 'package:fpdart/fpdart.dart';

import '../states/rift_state.dart';

class RiftStore extends ValueNotifier<RiftState> {
  final CreateRift createRift;
  final VerifySummoners verifySummoners;
  final RamdomResolver ramdomResolver;

  RiftStore(this.createRift, this.verifySummoners, this.ramdomResolver) : super(RiftState.init());

  void changeSummoner(int index, Summoner summoner) {
    final summoners = value.summoners.toList();
    summoners[index] = summoner;
    var newValue = value.copyWith(summoners: summoners, errorMessage: '');

    ramdomResolver //
        .call(summoners.toList())
        .bind(verifySummoners.call)
        .fold((l) {
      newValue = newValue.copyWith(errorMessage: l.message);
    }, id);

    value = newValue;
  }

  void createRiftAction() {
    final newValue = ramdomResolver //
        .call(value.summoners.toList())
        .bind(verifySummoners.call)
        .bind(createRift.call)
        .fold(
          (l) => value.copyWith(errorMessage: l.message),
          (r) => value.copyWith(rift: r, errorMessage: ''),
        );

    value = newValue;
  }
}
