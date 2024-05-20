import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Widget riveAnimation(BoxConstraints constraints,
    {required String plantId,
    required String potId,
    required num level,
    required Function changeUI}) {
  SMIInput<double>? input;
  dynamic state;
  Artboard? artboard;

  // print('/n plantId: $plantId levelchange: $level');
  return StatefulBuilder(builder: (context, setState) {
    return Column(
      children: [
        SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight * 0.73,
          child: RiveAnimation.asset(
            'assets/rive/plants/$plantId.riv',
            key: Key('$plantId $level'),
            onInit: (artboardRive) {
              artboard = artboardRive;
              // print('/n animation plant: $plantId $level');
              state = StateMachineController.fromArtboard(artboard!, 'plant');
              input = state!.findInput<double>('level') as SMINumber;
              input!.change(level.toDouble());
              // print(_input!.value);
              artboard!.addController(state);
              setState(() {
                changeUI.call();
              });
            },
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight * 0.27,
          child: RiveAnimation.asset(
            'assets/rive/pots/$potId.riv',
          ),
        ),
      ],
    );
  });
}
