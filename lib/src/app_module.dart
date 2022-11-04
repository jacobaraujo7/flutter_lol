import 'package:flutter_lol/src/domain/usecases/create_rift.dart';
import 'package:flutter_lol/src/domain/usecases/ramdom_resolver.dart';
import 'package:flutter_lol/src/domain/usecases/verify_summoners.dart';
import 'package:flutter_lol/src/presenter/stores/rift_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/rift_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<RamdomResolver>((i) => RamdomResolverImpl()),
    Bind.factory<VerifySummoners>((i) => VerifySummonersImpl()),
    Bind.factory<CreateRift>((i) => CreateRiftImpl()),
    Bind.singleton((i) => RiftStore(i(), i(), i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const RiftPage()),
  ];
}
