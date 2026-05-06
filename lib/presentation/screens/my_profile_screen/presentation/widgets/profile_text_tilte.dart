import 'package:flutter/material.dart';

class ProfileTextTitle extends StatelessWidget {
  final String title;
  const ProfileTextTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}
