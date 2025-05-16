import 'package:flutter/material.dart';

class AppSectionHeading extends StatelessWidget {
  const AppSectionHeading({
    super.key,
    this.textColor,
    this.onPressed,
    this.showActionButton = false,
    required this.title,
    this.buttonTitle = "View All",
    this.padding = EdgeInsets.zero,
  });
  final String title, buttonTitle;
  final Color? textColor;
  final void Function()? onPressed;
  final bool showActionButton;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: textColor,
            ),

            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (showActionButton)
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.apply(color: textColor),
              ),
            ),
        ],
      ),
    );
  }
}
