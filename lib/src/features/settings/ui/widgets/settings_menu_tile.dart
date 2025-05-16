import 'package:daily_mood/src/common/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class AppSettingMenuTile extends StatelessWidget {
  const AppSettingMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: AppColors.warmCoral, weight: 200),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
