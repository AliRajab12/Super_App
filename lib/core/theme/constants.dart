//TODO:remove this file from theme constants
import 'package:flutter/material.dart';

class DegreedConstants {
  static const followPathway = 'followPathway';
  static const unfollowPathway = 'unfollowPathway';
  static const defaultPathway = 'Default';
  static const defaultComplete = 'defaultComplete';
  static const itemCompleted = 'itemCompleted';
  static const itemNotCompleted = 'itemNotCompleted';
  static const defaultSave = 'defaultSave';
  static const itemSaved = 'itemSaved';
  static const itemNotSaved = 'itemNotSaved';
  static const assignmentTasksLaunch = 'assignmentTasksLaunch';
  static const assignmentSaveLaunch = 'assignmentSaveLaunch';
  static const assignmentShareLaunch = 'assignmentShareLaunch';

  static const followPlan = 'followPlan';
  static const unfollowPlan = 'unfollowPlan';
  static const defaultPlan = 'Default';

  static const pathway = 'pathway';
  static const pathwayLessonItem = 'pathwaylessonitem';
  static const plans = 'target';

  static const requiredLearning = 'RequiredLearning';
}

final textFieldInputDecoration = InputDecoration(
  fillColor: Colors.white,
  constraints: const BoxConstraints(minHeight: 40),
  hintText: '',
  errorMaxLines: null,
  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(25),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(25),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.red),
    borderRadius: BorderRadius.circular(25),
  ),
);
BoxShadow kBoxShadow =
    BoxShadow(color: Colors.grey.shade300, blurRadius: 3, spreadRadius: 0.2);
