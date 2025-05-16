import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/circular_container.dart';
import 'package:daily_mood/src/features/settings/ui/widgets/curved_edge_widget.dart';
import 'package:flutter/material.dart';
 

class AppPrimaryHeaderContainer extends StatelessWidget {
  const AppPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppCurvedEdgeWidget(
      child: Container(
        color: AppColors.warmCoral,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: AppCircularContainer(
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: AppCircularContainer(
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
