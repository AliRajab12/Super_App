import 'package:bloc/bloc.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/core/utils/file_uploader.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/documents/presentation/bloc/documents_event.dart';

import 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final UserService userService;
  DocumentsBloc({required this.userService}) : super(const DocumentsState()) {
    on<SetDocumentsType>((event, emit) async {
      emit(state.copyWith(documentsTypeIndex: event.index));
    });
    on<UploadFile>((event, emit) async {
      final file = await FileUploader.pickAndUploadFile(event.context);

      switch (event.index) {
        case 0:
          emit(state.copyWith(drivingLicense: file));
          break;
        case 1:
          emit(state.copyWith(nID: file));
          break;
        case 2:
          emit(state.copyWith(passport: file));
          break;
        case 3:
          emit(state.copyWith(previousVisa: file));
          break;
        case 4:
          emit(state.copyWith(photograph: file));
          break;
      }
      if (state.documentsTypeIndex == 0 &&
          state.drivingLicense != null &&
          state.nID != null) {
        emit(state.copyWith(documentsUploaded: true));
      }
      if (state.documentsTypeIndex == 1 &&
          state.passport != null &&
          state.photograph != null &&
          state.previousVisa != null) {
        emit(state.copyWith(documentsUploaded: true));
      }
    });

    on<RemoveFile>((event, emit) async {
      switch (event.index) {
        case 0:
          emit(state.copyWith(drivingLicense: null, documentsUploaded: false));
          break;
        case 1:
          emit(state.copyWith(nID: null, documentsUploaded: false));
          break;
        case 2:
          emit(state.copyWith(passport: null, documentsUploaded: false));
          break;
        case 3:
          emit(state.copyWith(previousVisa: null, documentsUploaded: false));
          break;
        case 4:
          emit(state.copyWith(photograph: null, documentsUploaded: false));
          break;
      }
    });
    on<ResetState>((event, emit) async {
      emit(DocumentsState.initial());
    });
  }
}
