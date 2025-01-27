import 'package:flutter/material.dart';
import 'package:matrimony_app/utils/components.dart';

import '../utils/app_colors.dart';

class UserDetailScreen extends StatelessWidget {
  int? id;
  UserDetailScreen({super.key, required int this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Components.getAppBar(
        icon: Icons.person,
        title: 'User Details',
      ),
    );
  }
}
