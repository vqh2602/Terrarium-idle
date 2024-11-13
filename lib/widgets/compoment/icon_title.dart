import 'package:flutter/widgets.dart';
import 'package:terrarium_idle/widgets/base/text/text.dart';

Widget iconTitle({
  String? title,
  Widget? wTitle,
  required IconData icon,
  Color? color,
  double? size,
  Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Icon(
          icon,
          color: color,
          size: size,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: title != null ? SText.bodyMedium(title, maxLines: 1) : wTitle!,
        )
      ],
    ),
  );
}
