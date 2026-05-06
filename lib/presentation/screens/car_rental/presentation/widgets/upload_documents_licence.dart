import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_bloc.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_event.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/global.dart';
import 'package:path/path.dart' as path;

import '../bloc/car_state.dart';

class UploadDocumentsLicence extends StatelessWidget {
  const UploadDocumentsLicence({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      bloc: GlobalBloc.carBloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identify Verification',
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
                      GlobalBloc.carBloc
                          .add(UploadFileEvent(index: 0, context: context));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Uae driving licence',
                              style: kSectionTitle.copyWith(fontSize: 16),
                            ),
                            const Text(' *',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                        if (state.drivingLicence == null)
                          const Icon(Icons.attach_file_rounded)
                      ],
                    ),
                  ),
                  (state.drivingLicence != null)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                alignment: AlignmentDirectional.centerStart,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xffEEF9F8)),
                                child: Text(
                                  path.basename(state.drivingLicence!.path),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            InkWell(
                              onTap: () {
                                GlobalBloc.carBloc
                                    .add(RemoveFileEvent(index: 0));
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
                  InkWell(
                    onTap: () {
                      GlobalBloc.carBloc
                          .add(UploadFileEvent(index: 1, context: context));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Emirates ID',
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
                                width: 150,
                                padding: const EdgeInsets.all(10),
                                alignment: AlignmentDirectional.centerStart,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xffEEF9F8)),
                                child: Text(
                                  path.basename(state.nID!.path),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            InkWell(
                              onTap: () {
                                GlobalBloc.carBloc.add(RemoveFileEvent(
                                  index: 1,
                                ));
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
            const SizedBox(
              height: 70,
            ),
          ],
        );
      },
    );
  }
}
