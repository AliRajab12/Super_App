import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay_row.dart';

class AddOverlay extends StatefulWidget {
  const AddOverlay({super.key , required this.items , required this.onTapItem});
  final List<DropDownModel> items;
  final Function(DropDownModel) onTapItem;

  @override
  State<AddOverlay> createState() => _AddOverlayState();
}

class _AddOverlayState extends State<AddOverlay> {
  TextEditingController searchController = TextEditingController();
  List<DropDownModel> filterList =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterList = widget.items;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: 200.h
      ),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: 200.h
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 30.h,
                  child: Material(
                    child: TextField(
                        controller: searchController,
                      style: Theme.of(context).textTheme.bodySmall,
                      decoration: InputDecoration(
                        hintText: 'search',
                        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: OnlineClinicColorStyle.lightGray
                        ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 5.w)
                      ),
                      onChanged: (value){
                        filterList = widget.items.where((element) => element.title.toLowerCase().contains(value)).toList();
                        setState(() {

                        });
                      },

                    ),
                  )),
              Gap(10.h),

              ...filterList.map((e){
                return
                  CreateOverLayRow(
                    text: e.title,
                    isShowDivider: true,
                    width: 300.w,
                    onTap: (){
                      CreateOverLay.removeOverlay();
                      widget.onTapItem(e);
                    },
                  );
              } )
            ],
          ),
        ),
      ),
    );
  }
}
