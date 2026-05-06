import 'package:flutter/cupertino.dart';

class DropDownModel {
  DropDownModel({
    required this.title,
    // this.subTitle,
    this.id,
    // this.leadingIcon,
  });

  String title;
  String? subTitle;
  int? id;
  Widget? leadingIcon;
}
