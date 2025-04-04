import 'package:flutter/cupertino.dart';
import 'package:rive_native/rive_native.dart';
import 'package:terrarium_idle/config/config.dart';
import 'package:terrarium_idle/widgets/rive_native.dart';
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
  // SMIInput<double>? input;
  dynamic state;
  Artboard? artboard;

  bool isLoadingPlant = true;
  bool isLoadingPot = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSticker =
        (widget.plantId.contains('sticker') && widget.plantId == widget.potId);
    return RepaintBoundary(
      child: Stack(
        children: [
          Column(
            children: [
              if (isSticker)
                SizedBox(
                  width: widget.constraints.maxWidth,
                  height: widget.constraints.maxHeight,
                  child: RivePlayer.network(
                    asset:
                        '${Env.config.dataServer}/rive/sticker/${widget.potId}.riv',
                    fit: Fit.cover,
                    stateMachineName: 'State Machine 1',
                    withStateMachine: (sm) {
                      // // Find the number rating and set it to 3
                      // var ratingInput = sm.number("rating")!;
                      // ratingInput.value = 3;\
                      // Future.delayed(const Duration(milliseconds: 500), () {
                      //   if (mounted) {
                      //     setState(() {
                      //       isLoadingPot = false;
                      //       isLoadingPlant = false;
                      //     });
                      //   }
                      // });
                    },
                  ),
                ),
              if (!isSticker) ...[
                cHeight(widget.constraints.maxHeight * 0.03),
                SizedBox(
                  width: widget.constraints.maxWidth,
                  height: widget.constraints.maxHeight * 0.7,
                  child: RivePlayer.network(
                    asset:
                        '${Env.config.dataServer}/rive/plants/${widget.plantId}.riv',
                    key: Key('${widget.plantId} ${widget.level}'),
                    stateMachineName: 'plant',
                    withStateMachine: (sm) {
                      // // Find the number rating and set it to 3
                      var ratingInput = sm.number("level")!;
                      ratingInput.value = widget.level.toDouble();
                      // if (mounted) {
                      //   widget.changeUI.call();
                      // }
                      // setState(() {
                      //   widget.changeUI.call();
                      //   // isLoadingPlant = false;
                      // });
                    },
                    fit: Fit.fill,
                  ),
                ),
                SizedBox(
                  width: widget.constraints.maxWidth,
                  height: widget.constraints.maxHeight * 0.27,
                  child: RivePlayer.network(
                      asset:
                          '${Env.config.dataServer}/rive/pots/${widget.potId}.riv',
                      fit: Fit.contain,
                      stateMachineName: 'State Machine 1',
                      withStateMachine: (sm) {
                        // setState(() {
                        //   isLoadingPot = false;
                        // });
                      }
                      // onInit: (artboardRive) {
                      //   state = StateMachineController.fromArtboard(
                      //       artboardRive, 'State Machine 1');
                      //   artboardRive.addController(state);
                      //   setState(() {
                      //     isLoadingPot = false;
                      //   });
                      // },
                      ),
                ),
              ],
            ],
          ),
          // if (isLoadingPot || isLoadingPlant)
          //   Align(
          //     alignment: Alignment.center,
          //     child: CupertinoActivityIndicator(
          //         radius: 20.0, color: Get.theme.primaryColor),
          //   ),
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
  // SMIInput<double>? input;
  dynamic state;
  Artboard? artboard;

  bool isLoadingPlant = true;
  bool isLoadingPot = true;

  @override
  Widget build(BuildContext context) {
    bool isSticker =
        (widget.plantId.contains('sticker') && widget.plantId == widget.potId);
    return RepaintBoundary(
      child: Stack(
        children: [
          if (isSticker)
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: widget.constraints.maxWidth * 0.75,
                height: widget.constraints.maxHeight,
                child: RivePlayer.network(
                  asset:
                      '${Env.config.dataServer}/rive/sticker/${widget.potId}.riv',
                  fit: Fit.cover,
                  stateMachineName: 'State Machine 1',
                  withStateMachine: (sm) {
                    // // Find the number rating and set it to 3
                    // var ratingInput = sm.number("rating")!;
                    // ratingInput.value = 3;\
                    // setState(() {
                    //   isLoadingPot = false;
                    //   isLoadingPlant = false;
                    // });
                  },
                ),
              ),
            ),
          if (!isSticker) ...[
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: widget.constraints.maxWidth * 0.75,
                height: widget.constraints.maxHeight * 0.65,
                child: RivePlayer.network(
                  asset:
                      '${Env.config.dataServer}/rive/pots/${widget.potId}.riv',
                  fit: Fit.fill,
                  stateMachineName: 'State Machine 1',
                  withStateMachine: (sm) {
                    // print('/n animation plant: $plantId $level');
                    // state = StateMachineController.fromArtboard(
                    //     artboardRive, 'State Machine 1');
                    // artboardRive.addController(state);
                    // setState(() {
                    //   isLoadingPot = false;
                    // });
                  },
                ),
              ),
            ),
            SizedBox(
              width: widget.constraints.maxWidth,
              height: widget.constraints.maxHeight * 0.91,
              child: RivePlayer.network(
                asset:
                    '${Env.config.dataServer}/rive/plants/${widget.plantId}.riv',
                key: Key('${widget.plantId} ${widget.level}'),
                stateMachineName: 'plant',
                withStateMachine: (sm) {
                  // // Find the number rating and set it to 3
                  var ratingInput = sm.number("level")!;
                  ratingInput.value = widget.level.toDouble();
                  // setState(() {
                  //   widget.changeUI.call();
                  //   isLoadingPlant = false;
                  // });
                },
                fit: Fit.fill,
              ),
            ),
          ],
          // if (isLoadingPot || isLoadingPlant)
          //   Align(
          //     alignment: Alignment.center,
          //     child: CupertinoActivityIndicator(
          //         radius: 20.0, color: Get.theme.primaryColor),
          //   ),
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
