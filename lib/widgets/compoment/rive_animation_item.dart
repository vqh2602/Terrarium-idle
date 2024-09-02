import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';
import 'package:terrarium_idle/widgets/widgets.dart';

class RiveAnimationItem extends StatefulWidget {
  final BoxConstraints constraints;
  final String plantId;
  final String potId;
  final num level;
  final Function changeUI;
  const RiveAnimationItem({
    super.key,
    required this.constraints,
    required this.plantId,
    required this.potId,
    required this.level,
    required this.changeUI,
  });

  @override
  State<RiveAnimationItem> createState() => _RiveAnimationItemState();
}

class _RiveAnimationItemState extends State<RiveAnimationItem> {
  SMIInput<double>? input;
  dynamic state;
  Artboard? artboard;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        children: [
          cHeight(widget.constraints.maxHeight * 0.03),
          SizedBox(
            width: widget.constraints.maxWidth,
            height: widget.constraints.maxHeight * 0.7,
            child: RiveAnimation.asset(
              'assets/rive/plants/${widget.plantId}.riv',
              key: Key('${widget.plantId} ${widget.level}'),
              onInit: (artboardRive) {
                artboard = artboardRive;
                // print('/n animation plant: $plantId $level');
                state = StateMachineController.fromArtboard(artboard!, 'plant');
                input = state!.findInput<double>('level') as SMINumber;
                input!.change(widget.level.toDouble());
                // print(_input!.value);
                artboard!.addController(state);
                setState(() {
                  widget.changeUI.call();
                });
              },
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: widget.constraints.maxWidth,
            height: widget.constraints.maxHeight * 0.27,
            child: RiveAnimation.asset(
              'assets/rive/pots/${widget.potId}.riv',
            ),
          ),
        ],
      ),
    );
  }
}

// dành cho trậu treo
class RiveAnimationItemHanging extends StatefulWidget {
  final BoxConstraints constraints;
  final String plantId;
  final String potId;
  final num level;
  final Function changeUI;
  const RiveAnimationItemHanging({
    super.key,
    required this.constraints,
    required this.plantId,
    required this.potId,
    required this.level,
    required this.changeUI,
  });

  @override
  State<RiveAnimationItemHanging> createState() =>
      _RiveAnimationItemHangingState();
}

class _RiveAnimationItemHangingState extends State<RiveAnimationItemHanging> {
  SMIInput<double>? input;
  dynamic state;
  Artboard? artboard;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: widget.constraints.maxWidth * 0.75,
              height: widget.constraints.maxHeight * 0.65,
              child: RiveAnimation.asset(
                'assets/rive/pots/${widget.potId}.riv',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: widget.constraints.maxWidth,
            height: widget.constraints.maxHeight * 0.91,
            child: RiveAnimation.asset(
              'assets/rive/plants/${widget.plantId}.riv',
              key: Key('${widget.plantId} ${widget.level}'),
              onInit: (artboardRive) {
                artboard = artboardRive;
                // print('/n animation plant: $plantId $level');
                state = StateMachineController.fromArtboard(artboard!, 'plant');
                input = state!.findInput<double>('level') as SMINumber;
                input!.change(widget.level.toDouble());
                // print(_input!.value);
                artboard!.addController(state);
                setState(() {
                  widget.changeUI.call();
                });
              },
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget riveAnimation(BoxConstraints constraints,
//     {required String plantId,
//     required String potId,
//     required num level,
//     required Function changeUI}) {
//   SMIInput<double>? input;
//   dynamic state;
//   Artboard? artboard;

//   // print('/n plantId: $plantId levelchange: $level');
//   return StatefulBuilder(builder: (context, setState) {
//     return RepaintBoundary(
//       child: Column(
//         children: [
//           SizedBox(
//             width: constraints.maxWidth,
//             height: constraints.maxHeight * 0.73,
//             child: RiveAnimation.asset(
//               'assets/rive/plants/$plantId.riv',
//               key: Key('$plantId $level'),
//               onInit: (artboardRive) {
//                 artboard = artboardRive;
//                 // print('/n animation plant: $plantId $level');
//                 state = StateMachineController.fromArtboard(artboard!, 'plant');
//                 input = state!.findInput<double>('level') as SMINumber;
//                 input!.change(level.toDouble());
//                 // print(_input!.value);
//                 artboard!.addController(state);
//                 setState(() {
//                   changeUI.call();
//                 });
//               },
//               fit: BoxFit.fill,
//             ),
//           ),
//           SizedBox(
//             width: constraints.maxWidth,
//             height: constraints.maxHeight * 0.27,
//             child: RiveAnimation.asset(
//               'assets/rive/pots/$potId.riv',
//             ),
//           ),
//         ],
//       ),
//     );
//   });
// }
