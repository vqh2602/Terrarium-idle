import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Widget riveAnimation(BoxConstraints constraints,
    {required String plantId, required String potId, required num level}) {
  return StatefulBuilder(builder: (context, setState) {
    SMIInput<double>? input;
    return Column(
      children: [
        SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight * 0.75,
          child: RiveAnimation.asset(
            'assets/rive/plants/$plantId.riv',
            onInit: (artboard) {
              var state =
                  StateMachineController.fromArtboard(artboard, 'plant');
              input = state!.findInput<double>('level') as SMINumber;
              input!.change(level.toDouble());
              setState(() {});
              // print(_input!.value);
              artboard.addController(state);
            },
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight * 0.25,
          child: RiveAnimation.asset(
            'assets/rive/pots/$potId.riv',
          ),
        ),
      ],
    );
  });
}
