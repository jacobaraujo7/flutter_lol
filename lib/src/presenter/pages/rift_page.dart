import 'package:flutter/material.dart';
import 'package:flutter_lol/src/domain/entities/summoner.dart';
import 'package:flutter_lol/src/presenter/stores/rift_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RiftPage extends StatelessWidget {
  const RiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<RiftStore>();
    final state = store.value;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                for (var i = 0; i < state.summoners.length; i++)
                  ItemList(
                    index: i,
                    summoner: state.summoners[i],
                  ),
                if (state.errorMessage.isNotEmpty)
                  Container(
                    color: Colors.red,
                    child: Text(state.errorMessage),
                  )
              ],
            ),
          ),
          if (state.errorMessage.isNotEmpty)
            Expanded(
              child: SelectableText(state.rift.toString()),
            ),
        ],
      ),
      floatingActionButton: store.value.errorMessage.isNotEmpty
          ? null
          : FloatingActionButton(
              onPressed: store.createRiftAction,
              child: const Icon(Icons.accessible_outlined),
            ),
    );
  }
}

class ItemList extends StatelessWidget {
  final Summoner summoner;
  final int index;

  const ItemList({super.key, required this.summoner, required this.index});

  @override
  Widget build(BuildContext context) {
    final store = context.read<RiftStore>();
    final positions = Position.values.map((e) {
      return DropdownMenuItem<Position>(
        value: e,
        child: Text(e.name),
      );
    }).toList();

    return Row(
      children: [
        Text('${index + 1}'),
        SizedBox(
          width: 150,
          child: TextFormField(
            initialValue: summoner.nick,
            onChanged: (value) {
              store.changeSummoner(
                index,
                summoner.copyWith(
                  nick: value,
                ),
              );
            },
          ),
        ),
        DropdownButton<Position>(
          value: summoner.position,
          items: positions,
          onChanged: (Position? value) {
            store.changeSummoner(
              index,
              summoner.copyWith(
                position: value,
              ),
            );
          },
        ),
      ],
    );
  }
}
