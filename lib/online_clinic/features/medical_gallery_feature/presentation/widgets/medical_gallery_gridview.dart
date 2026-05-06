import 'package:flutter/material.dart';
import 'package:somi/online_clinic/features/medical_gallery_feature/presentation/widgets/medical_gallery_grid_item.dart';

class MedicalGalleryGridView extends StatefulWidget {
  const MedicalGalleryGridView(
      {super.key,
      required this.isSelectMode,
      required this.selectedList,
      required this.onItemTapped});

  final Function(int, bool) onItemTapped;
  final bool isSelectMode;

  final List<bool> selectedList;

  @override
  State<MedicalGalleryGridView> createState() => MedicalGalleryGridViewState();
}

class MedicalGalleryGridViewState extends State<MedicalGalleryGridView> {

  bool isSelectedAll = false;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: widget.selectedList.length,
        itemBuilder: (context, index) {
          return GridItem(
            index: index,
            isSelectAll: isSelectedAll,
            onItemTapped: widget.onItemTapped,
            isSelectMode: widget.isSelectMode,
          );
        },
      ),
    );
  }
}
