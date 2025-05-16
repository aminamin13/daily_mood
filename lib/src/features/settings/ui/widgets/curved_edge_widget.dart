import 'package:daily_mood/src/features/settings/ui/widgets/curved_edges.dart';
import 'package:flutter/material.dart';
 
class AppCurvedEdgeWidget extends StatelessWidget {
  const AppCurvedEdgeWidget({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: AppCustomCurvedEdges(), child: child);
  }
}
