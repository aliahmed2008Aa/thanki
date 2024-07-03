import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thanki/providers/user_provider.dart';
import 'package:thanki/utils/global_varibles.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout(
      {super.key,
      required this.mobileScreenLayout,
      required this.webScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override


  




  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth > webScreenSiz) {
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
