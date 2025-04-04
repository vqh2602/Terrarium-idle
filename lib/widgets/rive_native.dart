import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive_native/rive_native.dart' as riveNative;
import 'package:http/http.dart' as http;

/// This is an example high-level implementation widget using the Rive Native Painters.
class RivePlayer extends StatefulWidget {
  const RivePlayer.assets({
    super.key,
    required this.asset,
    this.stateMachineName,
    this.artboardName,
    this.hitTestBehavior = riveNative.RiveHitTestBehavior.opaque,
    this.cursor = MouseCursor.defer,
    this.fit = riveNative.Fit.contain,
    this.alignment = Alignment.center,
    this.layoutScaleFactor = 1.0,
    this.withArtboard,
    this.withStateMachine,
    this.assetLoader,
    this.isNetwork = false,
  });
  const RivePlayer.network({
    this.isNetwork = true,
    super.key,
    required this.asset,
    this.stateMachineName,
    this.artboardName,
    this.hitTestBehavior = riveNative.RiveHitTestBehavior.opaque,
    this.cursor = MouseCursor.defer,
    this.fit = riveNative.Fit.contain,
    this.alignment = Alignment.center,
    this.layoutScaleFactor = 1.0,
    this.withArtboard,
    this.withStateMachine,
    this.assetLoader,
  });
  final String asset;
  final String? stateMachineName;
  final String? artboardName;
  final riveNative.RiveHitTestBehavior hitTestBehavior;
  final MouseCursor cursor;
  final riveNative.Fit fit;
  final Alignment alignment;
  final double layoutScaleFactor;
  final riveNative.AssetLoaderCallback? assetLoader;

  final void Function(riveNative.StateMachine stateMachine)? withStateMachine;
  final void Function(riveNative.Artboard artboard)? withArtboard;

  final bool isNetwork;
  @override
  State<RivePlayer> createState() => _RivePlayerState();
}

class _RivePlayerState extends State<RivePlayer> {
  riveNative.File? riveFile;

  riveNative.Artboard? artboard;
  late riveNative.StateMachinePainter stateMachinePainter;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    riveFile = widget.isNetwork ? await _loadFileNetwork() : await _loadFile();
    if (riveFile == null) return;

    if (widget.artboardName != null) {
      artboard = riveFile!.artboard(widget.artboardName!)!;
    } else {
      artboard = riveFile!.artboardAt(0)!;
    }
    widget.withArtboard?.call(artboard!);

    stateMachinePainter = riveNative.RivePainter.stateMachine(
      stateMachineName: widget.stateMachineName,
      withStateMachine: widget.withStateMachine,
    )
      ..hitTestBehavior = widget.hitTestBehavior
      ..cursor = widget.cursor
      ..fit = widget.fit
      ..alignment = widget.alignment
      ..layoutScaleFactor = widget.layoutScaleFactor;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() {});
    });
  }

  Future<riveNative.File?> _loadFile() async {
    final bytes = await rootBundle.load(widget.asset);
    return riveNative.File.decode(
      bytes.buffer.asUint8List(),
      riveFactory: RiveExampleApp.getCurrentFactory,
      assetLoader: widget.assetLoader,
    );
  }

  Future<riveNative.File?> _loadFileNetwork() async {
    // final bytes = await rootBundle.load(widget.asset);
    final res = await http.get(Uri.parse(widget.asset), headers: null);
    final bytes = ByteData.view(res.bodyBytes.buffer);
    return riveNative.File.decode(
      bytes.buffer.asUint8List(),
      riveFactory: RiveExampleApp.getCurrentFactory,
      assetLoader: widget.assetLoader,
    );
  }

  @override
  void didUpdateWidget(RivePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hitTestBehavior != oldWidget.hitTestBehavior) {
      stateMachinePainter.hitTestBehavior = widget.hitTestBehavior;
    }
    if (widget.cursor != oldWidget.cursor) {
      stateMachinePainter.cursor = widget.cursor;
    }
    if (widget.fit != oldWidget.fit) {
      stateMachinePainter.fit = widget.fit;
    }
    if (widget.alignment != oldWidget.alignment) {
      stateMachinePainter.alignment = widget.alignment;
    }
    if (widget.layoutScaleFactor != oldWidget.layoutScaleFactor) {
      stateMachinePainter.layoutScaleFactor = widget.layoutScaleFactor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return riveFile != null && artboard != null
        ? riveNative.RiveArtboardWidget(
            artboard: artboard!,
            // file: riveFile!,
            painter: stateMachinePainter,
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    if (artboard != null) {
      artboard?.dispose();
    }
    riveFile?.dispose();
    super.dispose();
  }
}

class RiveExampleApp {
  static bool isRiveRender = true;

  static riveNative.Factory get getCurrentFactory =>
      isRiveRender ? riveNative.Factory.rive : riveNative.Factory.flutter;
}

// // Recursive function to try different state machines
// rive.StateMachineController? _tryGetStateMachineController(
//     rive.Artboard artboard, int attempt) {
//   // List of state machine names to try
//   final stateNames = [
//     'State_Machine',
//     'State_Machine1',
//     'State Machine 1',
//     'State_Machine2',
//     'State_Machine_1'
//   ];

//   if (attempt >= stateNames.length) {
//     return null;
//   }

//   // Try to get controller for current state machine
//   var controller =
//       rive.StateMachineController.fromArtboard(artboard, stateNames[attempt]);

//   // If controller is not null, return it
//   if (controller != null) {
//     print('Found controller for ${stateNames[attempt]}');
//     return controller;
//   }

//   // Otherwise, try the next state machine recursively
//   return _tryGetStateMachineController(artboard, attempt + 1);
// }
