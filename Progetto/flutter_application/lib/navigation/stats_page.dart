import 'dart:ui';

import 'package:flutter/material.dart';
import 'routes/create_member_route.dart';
import 'routes/create_project_screen.dart';
import 'package:input_quantity/input_quantity.dart';
import '../data/project_list.dart';
import 'routes/create_team_screen.dart';
import '../commonElements/responsive_padding.dart';
import 'package:flutter_application/classes/all.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

@override
class _StatsPageState extends State<StatsPage> {
  List<ProjectItem> list = ProjectList().getList();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: getResponsivePadding(context), //in responsive_padding.dart
      // child: 
    );
  }
}