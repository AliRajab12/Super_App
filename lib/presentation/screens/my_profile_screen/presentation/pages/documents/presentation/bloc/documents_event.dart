import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DocumentsEvent extends Equatable {
  const DocumentsEvent();
}

class SetDocumentsType extends DocumentsEvent {
  final int index;
  const SetDocumentsType({required this.index});
  @override
  List<Object?> get props => [index];
}

class UploadFile extends DocumentsEvent {
  final BuildContext context;
  final int index;
  const UploadFile({
    required this.context,
    required this.index,
  });

  @override
  List<Object?> get props => [
        context,
        index,
      ];
}

class RemoveFile extends DocumentsEvent {
  final int index;
  const RemoveFile({
    required this.index,
  });

  @override
  List<Object?> get props => [
        index,
      ];
}

class ResetState extends DocumentsEvent {
  const ResetState();
  @override
  List<Object?> get props => [];
}
