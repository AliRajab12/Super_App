import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'documents_state.freezed.dart';

@freezed
class DocumentsState with _$DocumentsState {
  const factory DocumentsState({
    @Default(false) bool loading,
    @Default(-1) int documentsTypeIndex,
    @Default(false) bool documentsUploaded,
    @Default(null) File? passport,
    @Default(null) File? nID,
    @Default(null) File? photograph,
    @Default(null) File? previousVisa,
    @Default(null) File? drivingLicense,
    @Default(null) Object? error,
  }) = _DocumentsState;

  factory DocumentsState.initial() => const DocumentsState();

  factory DocumentsState.loading() => const DocumentsState(loading: true);
  factory DocumentsState.completed() => const DocumentsState(loading: false);

  factory DocumentsState.error(Object error) => DocumentsState(error: error);
}
