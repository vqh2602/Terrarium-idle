import 'package:flutter/material.dart';

class PandaBarButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isSelected;

  final VoidCallback? onTap;

  final Color? selectedColor;
  final Color? unselectedColor;

  const PandaBarButton(
      {super.key,
      this.isSelected = false,
      this.icon = Icons.dashboard,
      this.selectedColor,
      this.unselectedColor,
      this.title = '',
      this.onTap});
      
        @override
        State<StatefulWidget> createState() {
          return _PandaBarButtonState();
        }

  
}

class _PandaBarButtonState extends State<PandaBarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    animation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 10), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: 0), weight: 50),
    ]).chain(CurveTween(curve: Curves.bounceOut)).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkResponse(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: widget.onTap as void Function(),
        onHighlightChanged: (touched) {
          if (!touched) {
            animationController.forward().whenCompleteOrCancel(() {
              animationController.reset();
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon,
                  color: widget.isSelected
                      ? (widget.selectedColor ?? const Color(0xFF078DF0))
                      : (widget.unselectedColor ?? const Color(0xFF9FACBE))),
              Container(
                height: animation.value + 4,
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: FxText.bodySmall(widget.title,
              //    color: widget.isSelected
              //               ? (widget.selectedColor ?? const Color(0xFF078DF0))
              //               : (widget.unselectedColor ?? const Color(0xFF9FACBE)),
              //               fontWeight: 700,
              //               fontSize: 11,
              //   )
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
