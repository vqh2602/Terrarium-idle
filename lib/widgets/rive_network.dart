// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:rive_native/rive_native.dart' as rive;

// bool isRiveRender = true;

// class RiveNetworkPlayer extends StatefulWidget {
//   const RiveNetworkPlayer({
//     super.key,
//     required this.url,
//     required this.stateMachineName,
//     this.artboardName,
//     this.hitTestBehavior = rive.RiveHitTestBehavior.opaque,
//     this.cursor = MouseCursor.defer,
//     this.fit = rive.Fit.contain,
//     this.alignment = Alignment.center,
//     this.layoutScaleFactor = 1.0,
//     this.withStateMachine,
//     this.onInit,
//   });
//   final Function(rive.Artboard? artboard)? onInit;
//   final String url;
//   final String? stateMachineName;
//   final String? artboardName;
//   final rive.RiveHitTestBehavior hitTestBehavior;
//   final MouseCursor cursor;
//   final rive.Fit fit;
//   final Alignment alignment;
//   final double layoutScaleFactor;
//   final void Function(rive.StateMachine)? withStateMachine;

//   @override
//   State<RiveNetworkPlayer> createState() => _RiveNetworkPlayerState();
// }

// class _RiveNetworkPlayerState extends State<RiveNetworkPlayer> {
//   rive.File? riveFile;
//   rive.Artboard? artboard;
//   rive.StateMachinePainter? stateMachinePainter;
//   bool isLoading = true;
//   String? errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadFileFromNetwork();
//   }

//   Future<void> _loadFileFromNetwork() async {
//     try {
//       final response = await http.get(Uri.parse(widget.url));

//       if (response.statusCode == 200) {
//         final file = await rive.File.decode(
//           response.bodyBytes,
//           riveFactory: isRiveRender ? rive.Factory.rive : rive.Factory.flutter,
//         );

//         setState(() {
//           riveFile = file;
//           artboard = widget.artboardName != null
//               ? file?.artboard(widget.artboardName!)
//               : file?.artboardAt(0);

//           if (artboard != null) {
//             stateMachinePainter = rive.RivePainter.stateMachine(
//               widget.stateMachineName,
//               withStateMachine: widget.withStateMachine,
//             )
//               ..hitTestBehavior = widget.hitTestBehavior
//               ..cursor = widget.cursor
//               ..fit = widget.fit
//               ..alignment = widget.alignment
//               ..layoutScaleFactor = widget.layoutScaleFactor;
//           } else {
//             errorMessage = "Không tìm thấy artboard!";
//           }
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           errorMessage = "Tải file thất bại: ${response.statusCode}";
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = "Lỗi khi tải file: $e";
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (errorMessage != null) {
//       return Center(
//           child: Text("⚠️ $errorMessage", textAlign: TextAlign.center));
//     }

//     return riveFile != null && artboard != null && stateMachinePainter != null
//         ? rive.RiveArtboardWidget(
//             artboard: artboard!,
//             painter: stateMachinePainter!,
//           )
//         : const SizedBox();
//   }
// }
