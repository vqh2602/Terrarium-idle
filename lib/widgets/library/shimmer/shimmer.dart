import 'dart:async';

import 'package:flutter/material.dart';

enum ShimmerProLight { lighter, darker }

///
///Use only [ShimmerPro.sized], [ShimmerPro.text] or [ShimmerPro.generated] not use [ShimmerPro].
// ignore: must_be_immutable
class ShimmerPro extends StatefulWidget {
  final Duration duration;
  final int depth;
  int? maxLine;
  double? textSize;
  double? borderRadius;
  double? width;
  double? height;
  bool isText = false;
  bool isSized = false;
  bool isGenerated = false;
  Widget? child;
  Alignment? alignment;
  ShimmerProLight? light;
  Color scaffoldBackgroundColor;

  ///[ShimmerPro.sized] must use sized widgets.
  ///With using [width] and [height] ;[ShimmerPro.sized] generate sized shimmer.
  ///[duration] animation duration.
  ///[borderRadius] sized widget border radius.
  ///[alignment] sized vidget alignment. Defoult [Alignment.center].
  ///[light] shimmer is lighter color or darker color.
  ///[scaffoldBackgroundColor] must be geven. [ShimmerPro.sized] generate from this color.
  ShimmerPro.sized({super.key, 
    this.depth = 20,
    this.duration = const Duration(seconds: 1),
    this.borderRadius = 10,
    this.alignment = Alignment.center,
    this.light = ShimmerProLight.darker,
    required this.scaffoldBackgroundColor,
    required this.height,
    required this.width,
  }) {
    isSized = true;
  }

  ///[ShimmerPro.text] must use text widgets.
  ///You can delegate [width] ;[ShimmerPro.text] generate text shimmer.
  ///[duration] animation duration.
  ///[borderRadius] sized widget border radius.
  ///[alignment] sized vidget alignment. Defoult [Alignment.center].
  ///[light] shimmer is lighter color or darker color.
  ///[scaffoldBackgroundColor] must be geven. [ShimmerPro.text] generate from this color.
  ///[maxLine] is defoult 3. [ShimmerPro.text] will be generated this count.
  ///[textSize] is [ShimmerPro.text]'s text size.Defoult 14.
  ShimmerPro.text(
      {super.key, 
      this.depth = 20,
      this.duration = const Duration(seconds: 1),
      this.maxLine = 3,
      this.textSize = 14,
      this.borderRadius = 10,
      this.alignment = Alignment.center,
      this.light = ShimmerProLight.darker,
      required this.scaffoldBackgroundColor,
      this.width}) {
    isText = true;
  }

  ///[ShimmerPro.generated] must use children widgets.
  ///You can delegate [width] ;[ShimmerPro.text] generate text shimmer.
  ///[duration] animation duration.
  ///[borderRadius] sized widget border radius.
  ///[alignment] sized vidget alignment. Defoult [Alignment.center].
  ///[light] shimmer is lighter color or darker color.
  ///[scaffoldBackgroundColor] must be geven. [ShimmerPro.text] generate from this color.
  ///[child] must be [Column] or [Row] for best seen.
  ShimmerPro.generated(
      {super.key,
      this.depth = 20,
      this.duration = const Duration(seconds: 1),
      this.borderRadius = 10,
      this.alignment = Alignment.center,
      this.light = ShimmerProLight.darker,
      required this.scaffoldBackgroundColor,
      this.width,
      this.height,
      required this.child}) {
    isGenerated = true;
  }

  @override
  State<ShimmerPro> createState() => _ShimmerProState();
}

class _ShimmerProState extends State<ShimmerPro> {
  late Timer _timer;

  int _colorInt = 5;
  late final Brightness _brightness;
  bool _isStart = true;

  @override
  void initState() {
    _brightness = widget.light == ShimmerProLight.lighter
        ? Brightness.dark
        : Brightness.light;

    _colorInt = _brightness == Brightness.dark
        ? 5
        : (_brightness == Brightness.light
            ? -50
            : (_brightness == Brightness.dark ? 5 : -50));
    // _brightness == Brightness.light ? widget.depth = widget.depth + 10 : null;

    onReady();
    // log(name: "BatuShimmer", '\x1B[32mInitialized\x1B[0m');

    super.initState();
  }

  onReady() async {
    await Future.delayed(const Duration(microseconds: 1));
    setState(() {
      if (_isStart) {
        _colorInt = _colorInt + widget.depth;
      } else {
        _colorInt = _colorInt - widget.depth;
      }
    });
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        if (_isStart) {
          _colorInt = _colorInt - widget.depth;
        } else {
          _colorInt = _colorInt + widget.depth;
        }
        _isStart = !_isStart;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (_timer.isActive) {
      _timer.cancel();
    }
    //  log(name: "BatuShimmer", '\x1B[32mDeleted\x1B[0m');
  }

  @override
  Widget build(BuildContext context) {
    int textWDepth = _brightness == Brightness.dark ? 10 : -10;
    final Color textAndGeneratedWColor = Color.fromARGB(
        widget.scaffoldBackgroundColor.alpha,
        widget.scaffoldBackgroundColor.red + textWDepth,
        widget.scaffoldBackgroundColor.green + textWDepth,
        widget.scaffoldBackgroundColor.blue + textWDepth);
    final Color textWColorTextAndSize = Color.fromARGB(
        widget.scaffoldBackgroundColor.alpha,
        widget.scaffoldBackgroundColor.red + _colorInt + 10,
        widget.scaffoldBackgroundColor.green + _colorInt + 10,
        widget.scaffoldBackgroundColor.blue + _colorInt + 10);

    if (widget.isGenerated) {
      return Align(
        alignment: widget.alignment!,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            color: textAndGeneratedWColor,
          ),
          duration: widget.duration,
          margin: const EdgeInsets.all(10),
          width: widget.width,
          height: widget.height,
          child: widget.child,
        ),
      );
    } else if (widget.isSized) {
      return Align(
        alignment: widget.alignment!,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            color: textWColorTextAndSize,
          ),
          duration: widget.duration,
          margin: const EdgeInsets.all(10),
          height: widget.height,
          width: widget.width,
        ),
      );
    } else {
      return Align(
        alignment: widget.alignment!,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
            color: textAndGeneratedWColor,
          ),
          duration: widget.duration,
          height: (widget.maxLine! * (widget.textSize! + 10) + 10),
          width: widget.width ?? double.maxFinite,
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                widget.maxLine!,
                (index) => AnimatedContainer(
                      duration: widget.duration,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius!),
                        color: textWColorTextAndSize,
                      ),
                      margin: const EdgeInsets.only(
                          right: 10, left: 10, bottom: 5, top: 5),
                      height: widget.textSize,
                      width: (widget.maxLine! - 1) == index
                          ? (widget.maxLine != 1
                              ? (widget.width ?? double.maxFinite) / 3
                              : null)
                          : null,
                    ))
              ..insert(
                  0,
                  const SizedBox(
                    height: 5,
                  ))
              ..add(const SizedBox(
                height: 5,
              )),
          ),
        ),
      );
    }
  }
}
// ************************************defaultColorsList*************************
const List<Color> defaultColors = [Color.fromRGBO(0, 0, 0, 0.1), Color(0x44CCCCCC), Color.fromRGBO(0, 0, 0, 0.1)];

// ************************************defaultColorsListForText*************************
const List<Color> textdefaultColors = [
  Color.fromRGBO(0, 0, 0, 0.1),
  Color(0x44CCCCCC),
  Color.fromRGBO(0, 0, 0, 0.1),
];

//
// **************************************buildButtomBox**********************************
//
Widget buildButtomBox(Animation animation,
    {required double width,
    required double height,
    required bool isDarkMode,
    required bool isRectBox,
    required bool isPurplishMode,
    required AlignmentGeometry beginAlign,
    required AlignmentGeometry endAlign,
    required bool hasCustomColors,
    required List<Color> colors,
    bool isVideoShimmer = false}) {
  return Container(
    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
    height: isVideoShimmer ? width * 0.2 : width * 0.2,
    width: isVideoShimmer ? width * 0.25 : width * 0.2,
    decoration: customBoxDecoration(
        animation: animation,
        isDarkMode: isDarkMode,
        isPurplishMode: isPurplishMode,
        isRectBox: isRectBox,
        beginAlign: beginAlign,
        endAlign: endAlign,
        hasCustomColors: hasCustomColors,
        colors: colors.length == 3 ? colors : defaultColors),
  );
}
//
// **************************************buildButtomBox**********************************
//

//
// **************************************CustomBoxDecoration****************************
// [animation]
// [isRectBox]
// [isDarkMode]
// [beginAlign]
// [endAlign]
//
Decoration customBoxDecoration({
  required Animation animation,
  bool isRectBox = false,
  bool isDarkMode = false,
  bool isPurplishMode = false,
  bool hasCustomColors = false,
  List<Color> colors = defaultColors,
  AlignmentGeometry beginAlign = Alignment.topLeft,
  AlignmentGeometry endAlign = Alignment.bottomRight,
}) {
  return BoxDecoration(
      shape: isRectBox ? BoxShape.rectangle : BoxShape.circle,
      gradient: LinearGradient(
          begin: beginAlign,
          end: endAlign,
          colors: hasCustomColors
              ? colors.map((color) {
                  return color;
                }).toList()
              : [
                  isPurplishMode
                      ? const Color(0xFF8D71A9)
                      : isDarkMode
                          ? const Color(0xFF1D1D1D)
                          : const Color.fromRGBO(0, 0, 0, 0.1),
                  isPurplishMode
                      ? const Color(0xFF36265A)
                      : isDarkMode
                          ? const Color(0XFF3C4042)
                          : const Color(0x44CCCCCC),
                  isPurplishMode
                      ? const Color(0xFF8D71A9)
                      : isDarkMode
                          ? const Color(0xFF1D1D1D)
                          : const Color.fromRGBO(0, 0, 0, 0.1),
                ],
          stops: [animation.value - 2, animation.value, animation.value + 1]));
}
//
// **************************************CustomBoxDecoration****************************
//
//

//
// **************************************CustomBoxDecoration****************************
// [animation]
// [isDarkMode]
// [beginAlign]
// [endAlign]
//
Decoration radiusBoxDecoration(
    {required Animation animation,
    bool isDarkMode = false,
    bool isPurplishMode = false,
    bool hasCustomColors = false,
    AlignmentGeometry beginAlign = Alignment.topLeft,
    AlignmentGeometry endAlign = Alignment.bottomRight,
    List<Color> colors = defaultColors,
    double radius = 10.0}) {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      shape: BoxShape.rectangle,
      gradient: LinearGradient(
          begin: beginAlign,
          end: endAlign,
          colors: hasCustomColors
              ? colors.map((color) {
                  return color;
                }).toList()
              : [
                  isPurplishMode
                      ? const Color(0xFF8D71A9)
                      : isDarkMode
                          ? const Color(0xFF1D1D1D)
                          : const Color.fromRGBO(0, 0, 0, 0.1),
                  isPurplishMode
                      ? const Color(0xFF36265A)
                      : isDarkMode
                          ? const Color(0XFF3C4042)
                          : const Color(0x44CCCCCC),
                  isPurplishMode
                      ? const Color(0xFF8D71A9)
                      : isDarkMode
                          ? const Color(0xFF1D1D1D)
                          : const Color.fromRGBO(0, 0, 0, 0.1),
                ],
          stops: [animation.value - 2, animation.value, animation.value + 1]));
}
//
// **************************************CustomBoxDecoration****************************
//
//

// *************************************TextShimmer***************************
class TextShimmer extends StatefulWidget {
  final bool isDarkMode;
  final bool isPurplishMode;
  final bool hasCustomColors;
  final List<Color> colors;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final String? text;
  final double? fontSize;
  const TextShimmer({
    super.key,
    this.isDarkMode = false,
    this.isPurplishMode = false,
    this.hasCustomColors = true,
    this.colors = textdefaultColors,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.centerRight,
    this.text,
    this.fontSize,
  });
  @override
  State<TextShimmer> createState() => _TextShimmerState();
}

class _TextShimmerState extends State<TextShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
    _animation =
        Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          return ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
                begin: widget.beginAlign,
                end: widget.endAlign,
                colors: widget.hasCustomColors
                    ? widget.colors.map((color) {
                        return color;
                      }).toList()
                    : widget.hasCustomColors
                        ? widget.colors
                        : [
                            widget.isPurplishMode
                                ? const Color(0xFF8D71A9)
                                : widget.isDarkMode
                                    ? const Color(0xFF1D1D1D)
                                    : const Color.fromRGBO(0, 0, 0, 0.1),
                            widget.isPurplishMode
                                ? const Color(0xFF36265A)
                                : widget.isDarkMode
                                    ? const Color(0XFF3C4042)
                                    : const Color(0x44CCCCCC),
                            widget.isPurplishMode
                                ? const Color(0xFF8D71A9)
                                : widget.isDarkMode
                                    ? const Color(0xFF1D1D1D)
                                    : const Color.fromRGBO(0, 0, 0, 0.1),
                          ],
                stops: [
                  _animation.value + 2,
                  _animation.value,
                  _animation.value - 2,
                ]).createShader(bounds),
            child: const Text(
              "Testing Shimmer..................",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          );
        });
  }
}
// *************************************TextShimmer***************************

//
//  ***************************ProfileShimmer******************************
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[isDisabledAvatar]: when it is true then it will hide circle avatar by default it's false
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomLines] when it is true then it will show bottom lines otherwise its hide the lines by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
class ProfileShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final bool isDisabledAvatar;
  final bool hasCustomColors;
  final List<Color> colors;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomLines;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color bgColor;

  const ProfileShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomLines = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = defaultColors,
    this.isDisabledAvatar = false,
    this.bgColor = Colors.transparent,
  });
  @override
  State<ProfileShimmer> createState() => _ProfileShimmerState();
}

class _ProfileShimmerState extends State<ProfileShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
    _animation =
        Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  widget.isDisabledAvatar
                      ? Container()
                      : Container(
                          height: width * 0.14,
                          width: width * 0.14,
                          decoration: customBoxDecoration(
                              animation: _animation,
                              isRectBox: widget.isRectBox,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: width * 0.13,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: height * 0.008,
                          width: widget.isDisabledAvatar ? width * 0.4 : width * 0.3,
                          decoration: radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                        ),
                        Container(
                          height: height * 0.006,
                          width: widget.isDisabledAvatar ? width * 0.3 : width * 0.2,
                          decoration: radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                        ),
                        Container(
                          height: height * 0.007,
                          width: widget.isDisabledAvatar ? width * 0.5 : width * 0.4,
                          decoration: radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              widget.hasBottomLines
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          height: height * 0.006,
                          width: width * 0.7,
                          decoration: radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                        ),
                        Container(
                          height: height * 0.006,
                          width: width * 0.8,
                          decoration: radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: height * 0.006,
                          width: width * 0.5,
                          decoration: radiusBoxDecoration(
                              animation: _animation,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
//
//  ***************************ProfileShimmer******************************
//

//
//  ***************************ProfilePageShimmer******************************
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[isDisabledAvatar]: when it is true then it will hide circle avatar by default it's false
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomBox] when it is true then it will show bottom Rect style Boxes otherwise its hide the Boxes by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
//
class ProfilePageShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final bool isDisabledAvatar;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final List<Color> colors;
  final Color bgColor;
  // ignore: use_super_parameters
  const ProfilePageShimmer({
    Key? key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = defaultColors,
    this.isDisabledAvatar = false,
    this.bgColor = Colors.transparent,
  }) : super(key: key);
  @override
  State<ProfilePageShimmer> createState() => _ProfilePageShimmerState();
}

class _ProfilePageShimmerState extends State<ProfilePageShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
    _animation =
        Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.isDisabledAvatar
                  ? Container()
                  : buildButtomBox(_animation,
                      height: width,
                      width: width,
                      isPurplishMode: widget.isPurplishMode,
                      isDarkMode: widget.isDarkMode,
                      isRectBox: widget.isRectBox,
                      beginAlign: widget.beginAlign,
                      endAlign: widget.endAlign,
                      hasCustomColors: widget.hasCustomColors,
                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
              Container(
                height: height * 0.006,
                width: width * 0.8,
                decoration: radiusBoxDecoration(
                    animation: _animation,
                    isPurplishMode: widget.isPurplishMode,
                    isDarkMode: widget.isDarkMode,
                    hasCustomColors: widget.hasCustomColors,
                    colors: widget.colors.length == 3 ? widget.colors : defaultColors),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: height * 0.006,
                width: width * 0.5,
                decoration: radiusBoxDecoration(
                    animation: _animation,
                    isPurplishMode: widget.isPurplishMode,
                    isDarkMode: widget.isDarkMode,
                    hasCustomColors: widget.hasCustomColors,
                    colors: widget.colors.length == 3 ? widget.colors : defaultColors),
              ),
              widget.hasBottomBox
                  ? Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildButtomBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                            buildButtomBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                            buildButtomBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildButtomBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                            buildButtomBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                            buildButtomBox(_animation,
                                height: width,
                                width: width,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                isRectBox: true,
                                beginAlign: widget.beginAlign,
                                endAlign: widget.endAlign,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          ],
                        )
                      ],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
//
//  ***************************ProfilePageShimmer******************************
//

//
//  ***************************VideoShimmer******************************
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomBox] when it is true then it will show bottom Rect style Boxes otherwise its hide the Boxes by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
//
class VideoShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final List<Color> colors;
  final Color bgColor;
  const VideoShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = defaultColors,
    this.bgColor = Colors.transparent,
  });
  @override
  State<VideoShimmer> createState() => _VideoShimmerState();
}

class _VideoShimmerState extends State<VideoShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
    _animation =
        Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      buildButtomBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      Container(
                        height: height * 0.006,
                        width: width * 0.2,
                        decoration: radiusBoxDecoration(
                            animation: _animation,
                            isPurplishMode: widget.isPurplishMode,
                            isDarkMode: widget.isDarkMode,
                            hasCustomColors: widget.hasCustomColors,
                            colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      buildButtomBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      Container(
                        height: height * 0.006,
                        width: width * 0.2,
                        decoration: radiusBoxDecoration(
                            animation: _animation,
                            isPurplishMode: widget.isPurplishMode,
                            isDarkMode: widget.isDarkMode,
                            hasCustomColors: widget.hasCustomColors,
                            colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      buildButtomBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      Container(
                        height: height * 0.006,
                        width: width * 0.2,
                        decoration: radiusBoxDecoration(
                            animation: _animation,
                            isPurplishMode: widget.isPurplishMode,
                            isDarkMode: widget.isDarkMode,
                            hasCustomColors: widget.hasCustomColors,
                            colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
//
//  ***************************VideoShimmer******************************
//

//  ***************************VideoShimmer******************************
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomBox] when it is true then it will show bottom Rect style Boxes otherwise its hide the Boxes by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
//
class YoutubeShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final List<Color> colors;
  final Color bgColor;
  const YoutubeShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = defaultColors,
    this.bgColor = Colors.transparent,
  });
  @override
  State<YoutubeShimmer> createState() => _YoutubeShimmerState();
}

class _YoutubeShimmerState extends State<YoutubeShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
    _animation =
        Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose************************
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildButtomBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.05,
                            width: width * 0.05,
                            decoration: customBoxDecoration(
                                animation: _animation,
                                isRectBox: widget.isRectBox,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildButtomBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.05,
                            width: width * 0.05,
                            decoration: customBoxDecoration(
                                animation: _animation,
                                isRectBox: widget.isRectBox,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildButtomBox(_animation,
                          height: width,
                          width: width,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          isRectBox: true,
                          beginAlign: widget.beginAlign,
                          endAlign: widget.endAlign,
                          isVideoShimmer: true,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: width * 0.05,
                            width: width * 0.05,
                            decoration: customBoxDecoration(
                                animation: _animation,
                                isRectBox: widget.isRectBox,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Container(
                                height: width * 0.01,
                                width: width * 0.12,
                                decoration: radiusBoxDecoration(
                                    animation: _animation,
                                    isPurplishMode: widget.isPurplishMode,
                                    isDarkMode: widget.isDarkMode,
                                    hasCustomColors: widget.hasCustomColors,
                                    colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//
//  ***************************ListTileShimmer******************************
//
// *[isRectBox] when it is true then it will show Rectancle shape else(false) show circle shape by defult its value false
// *[isDarkMode]when it is true then it will use black bg color otherwise it use transparent color by defult its value false
// *[isDisabledAvatar]: when it is true then it will hide circle avatar by default it's false
// *[isDisabledButton]: when it's true then it will hide right side button shape shimmer
// *[beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// *[endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// *[hasBottomBox] when it is true then it will show bottom Rect style Boxes otherwise its hide the Boxes by defult its value false
// *[padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// *[margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
//
//
//
class ListTileShimmer extends StatefulWidget {
  final bool isRectBox;
  final bool isDarkMode;
  final bool isPurplishMode;
  final bool isDisabledAvatar;
  final bool isDisabledButton;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final bool hasBottomBox;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final bool onlyShowProfilePicture;
  final List<Color> colors;
  final double height;
  final Color bgColor;
  const ListTileShimmer({
    super.key,
    this.isRectBox = false,
    this.isDarkMode = false,
    this.beginAlign = Alignment.topLeft,
    this.endAlign = Alignment.bottomRight,
    this.hasBottomBox = false,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(16.0),
    this.isPurplishMode = false,
    this.hasCustomColors = false,
    this.colors = defaultColors,
    this.isDisabledAvatar = false,
    this.isDisabledButton = false,
    this.onlyShowProfilePicture = false,
    this.height = 0,
    this.bgColor = Colors.transparent,
  });
  @override
  State<ListTileShimmer> createState() => _ListTileShimmerState();
}

class _ListTileShimmerState extends State<ListTileShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // ****************************init*************************
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
    _animation =
        Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController));
  }
  // ****************************init*************************

  // *****************************dispose************************
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // *****************************dispose*********************  ***
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        var newHeight = widget.height * 2;
        var circleHeight = widget.height * 3;
        return Container(
          margin: widget.margin,
          padding: widget.padding,
          color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  widget.onlyShowProfilePicture
                      ? Container(
                          height: widget.height == 0 ? width * 0.1 : circleHeight,
                          width: widget.height == 0 ? width * 0.1 : circleHeight,
                          decoration: customBoxDecoration(
                              animation: _animation,
                              isRectBox: widget.isRectBox,
                              isPurplishMode: widget.isPurplishMode,
                              isDarkMode: widget.isDarkMode,
                              hasCustomColors: widget.hasCustomColors,
                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                        )
                      : Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                widget.isDisabledAvatar
                                    ? Container()
                                    : Container(
                                        height: widget.height == 0 ? width * 0.1 : circleHeight,
                                        width: widget.height == 0 ? width * 0.1 : circleHeight,
                                        decoration: customBoxDecoration(
                                            animation: _animation,
                                            isRectBox: widget.isRectBox,
                                            isPurplishMode: widget.isPurplishMode,
                                            isDarkMode: widget.isDarkMode,
                                            hasCustomColors: widget.hasCustomColors,
                                            colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                      ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: widget.height == 0 ? width * 0.01 : widget.height,
                                      width: widget.isDisabledAvatar && widget.isDisabledButton
                                          ? width * 0.75
                                          : widget.isDisabledAvatar
                                              ? width * 0.6
                                              : widget.isDisabledButton
                                                  ? width * 0.6
                                                  : width * 0.5,
                                      decoration: radiusBoxDecoration(
                                          animation: _animation,
                                          isPurplishMode: widget.isPurplishMode,
                                          isDarkMode: widget.isDarkMode,
                                          hasCustomColors: widget.hasCustomColors,
                                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                    ),
                                    const SizedBox(
                                      height: 6.0,
                                    ),
                                    Container(
                                      height: widget.height == 0 ? width * 0.01 : widget.height,
                                      width: width * 0.45,
                                      decoration: radiusBoxDecoration(
                                          animation: _animation,
                                          isPurplishMode: widget.isPurplishMode,
                                          isDarkMode: widget.isDarkMode,
                                          hasCustomColors: widget.hasCustomColors,
                                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                    ),
                                  ],
                                ),
                                widget.isDisabledButton
                                    ? Container()
                                    : Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          margin: const EdgeInsets.only(left: 10.0),
                                          height: widget.height == 0 ? width * 0.05 : newHeight,
                                          width: width * 0.12,
                                          decoration: radiusBoxDecoration(
                                              animation: _animation,
                                              isPurplishMode: widget.isPurplishMode,
                                              isDarkMode: widget.isDarkMode,
                                              hasCustomColors: widget.hasCustomColors,
                                              colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                        ),
                                      )
                              ],
                            )
                          ],
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

//
// **************************************PlayStoreShimmer****************************
//
// [beginAlign] it will set the begin value for gradientColor by defult its value Alignment.topLeft
// [endAlign]   it will set the end value for gradientColor by defult its value Alignment.bottomRight
// [padding] it wiil set the padding of parent container by default its value 16.0 from all side(left,right,top,bottom)
// [margin] it wiil set the margin of parent container by default its value 16.0 from all side(left,right,top,bottom)
class PlayStoreShimmer extends StatefulWidget {
  final bool isDarkMode;
  final bool isPurplishMode;
  final AlignmentGeometry beginAlign;
  final AlignmentGeometry endAlign;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool hasCustomColors;
  final bool hasBottomFirstLine;
  final bool hasBottomSecondLine;
  final List<Color> colors;
  final ScrollPhysics physics;
  final Color bgColor;

  const PlayStoreShimmer(
      {super.key,
      this.isDarkMode = false,
      this.isPurplishMode = false,
      this.beginAlign = Alignment.topLeft,
      this.endAlign = Alignment.bottomRight,
      this.padding = const EdgeInsets.all(16.0),
      this.margin = const EdgeInsets.all(16.0),
      this.hasCustomColors = false,
      this.colors = defaultColors,
      this.hasBottomFirstLine = true,
      this.hasBottomSecondLine = true,
      this.physics = const BouncingScrollPhysics(),
      this.bgColor = Colors.transparent});
  @override
  State<PlayStoreShimmer> createState() => _PlayStoreShimmerState();
}

class _PlayStoreShimmerState extends State<PlayStoreShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // * init
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
    _animation =
        Tween<double>(begin: -2, end: 2).animate(CurvedAnimation(curve: Curves.easeInOutSine, parent: _animationController));
  }

  // ***dispose
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: widget.physics,
          child: Container(
            margin: widget.margin,
            padding: widget.padding,
            color: widget.isDarkMode ? const Color(0xFF0B0B0B) : widget.bgColor,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
                const SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 110,
                      decoration: radiusBoxDecoration(
                          radius: 25.0,
                          animation: _animation,
                          isPurplishMode: widget.isPurplishMode,
                          isDarkMode: widget.isDarkMode,
                          hasCustomColors: widget.hasCustomColors,
                          colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomFirstLine
                        ? Container(
                            height: width * 0.024,
                            width: 110,
                            decoration: radiusBoxDecoration(
                                radius: 0.0,
                                animation: _animation,
                                isPurplishMode: widget.isPurplishMode,
                                isDarkMode: widget.isDarkMode,
                                hasCustomColors: widget.hasCustomColors,
                                colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                          )
                        : Container(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    widget.hasBottomSecondLine
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: width * 0.024,
                                  width: 40,
                                  decoration: radiusBoxDecoration(
                                      radius: 0.0,
                                      animation: _animation,
                                      isPurplishMode: widget.isPurplishMode,
                                      isDarkMode: widget.isDarkMode,
                                      hasCustomColors: widget.hasCustomColors,
                                      colors: widget.colors.length == 3 ? widget.colors : defaultColors),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// **************************************PlayStoreShimmer****************************