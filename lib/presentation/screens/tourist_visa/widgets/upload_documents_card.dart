import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_bloc.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_event.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_state.dart';
import 'package:path/path.dart' as path;

class UploadDocumentsCard extends StatelessWidget {
  final bool isNewVisaApp;

  const UploadDocumentsCard({super.key, this.isNewVisaApp = true});

  @override
  Widget build(BuildContext context) {
    final visaAppCubit = locator<VisaAppBloc>();
    return BlocBuilder<VisaAppBloc, VisaAppState>(
      bloc: visaAppCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload files',
              style: kSectionTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [kBoxShadow],
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      visaAppCubit.add(UploadFile(
                          context: context, index: 0, isNewApp: isNewVisaApp));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Passport',
                              style: kSectionTitle.copyWith(fontSize: 16),
                            ),
                            const Text(' *',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                        if (state.passport == null)
                          const Icon(Icons.attach_file_rounded)
                      ],
                    ),
                  ),
                  (state.passport != null)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                padding: const EdgeInsets.all(10),
                                alignment: AlignmentDirectional.centerStart,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xffEEF9F8)),
                                child: Text(path.basename(state.passport!.path),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)),
                            InkWell(
                              onTap: () {
                                visaAppCubit.add(const RemoveFile(index: 0));
                              },
                              child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      shape: BoxShape.circle),
                                  padding: const EdgeInsets.all(3),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 15,
                                  )),
                            )
                          ],
                        )
                      : const SizedBox(height: 35),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  if (isNewVisaApp) ...[
                    InkWell(
                      onTap: () {
                        visaAppCubit.add(UploadFile(
                            context: context,
                            index: 1,
                            isNewApp: isNewVisaApp));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'National ID',
                                style: kSectionTitle.copyWith(fontSize: 16),
                              ),
                              const Text(' *',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                          if (state.nID == null)
                            const Icon(Icons.attach_file_rounded)
                        ],
                      ),
                    ),
                    (state.nID != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  padding: const EdgeInsets.all(10),
                                  alignment: AlignmentDirectional.centerStart,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xffEEF9F8)),
                                  child: Text(path.basename(state.nID!.path),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis)),
                              InkWell(
                                onTap: () {
                                  // visaAppCubit.removeFile(index: 1);
                                  visaAppCubit.add(const RemoveFile(index: 1));
                                },
                                child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(3),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              )
                            ],
                          )
                        : const SizedBox(height: 35),
                  ] else ...[
                    InkWell(
                      onTap: () {
                        visaAppCubit.add(UploadFile(
                            context: context,
                            index: 3,
                            isNewApp: isNewVisaApp));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Previous Visa',
                                style: kSectionTitle.copyWith(fontSize: 16),
                              ),
                              const Text(' *',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                          if (state.previousVisa == null)
                            const Icon(Icons.attach_file_rounded)
                        ],
                      ),
                    ),
                    (state.previousVisa != null)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  padding: const EdgeInsets.all(10),
                                  alignment: AlignmentDirectional.centerStart,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xffEEF9F8)),
                                  child: Text(
                                      path.basename(state.previousVisa!.path),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis)),
                              InkWell(
                                onTap: () {
                                  visaAppCubit.add(const RemoveFile(index: 3));
                                },
                                child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(3),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 15,
                                    )),
                              )
                            ],
                          )
                        : const SizedBox(height: 35),
                  ],
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  InkWell(
                    onTap: () {
                      visaAppCubit.add(UploadFile(
                          context: context, index: 2, isNewApp: isNewVisaApp));
                      // visaAppCubit.uploadFile(
                      // index: 2, context: context, isNewApp: isNewVisaApp);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Photograph',
                              style: kSectionTitle.copyWith(fontSize: 16),
                            ),
                            const Text(' *',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                        if (state.photograph == null)
                          const Icon(Icons.attach_file_rounded)
                      ],
                    ),
                  ),
                  (state.photograph != null)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                padding: const EdgeInsets.all(10),
                                alignment: AlignmentDirectional.centerStart,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xffEEF9F8)),
                                child: Text(
                                    path.basename(state.photograph!.path),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis)),
                            InkWell(
                              onTap: () {
                                // visaAppCubit.removeFile(index: 2);
                                visaAppCubit.add(const RemoveFile(index: 2));
                              },
                              child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      shape: BoxShape.circle),
                                  padding: const EdgeInsets.all(3),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 15,
                                  )),
                            )
                          ],
                        )
                      : const SizedBox(height: 35),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Max file size 4 MB (each)\nSupported formats (PDF, PNG, JPG)',
              style: kSectionTitle.copyWith(
                  fontSize: 13, fontWeight: FontWeight.normal),
            ),
          ],
        );
      },
    );
  }
}
