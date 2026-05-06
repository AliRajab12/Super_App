import 'package:flutter/material.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/utils.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class ActionTitleDatePicker extends StatefulWidget {
  const ActionTitleDatePicker({super.key , required this.onSelectDate});
  final Function(DateTime) onSelectDate;

  @override
  State<ActionTitleDatePicker> createState() => _ActionTitleDatePickerState();
}

class _ActionTitleDatePickerState extends State<ActionTitleDatePicker> {
  List<String> date = Utils.formattedDate(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () async{
      DateTime? selectedDate = await Utils.pickDate(context);

      if(selectedDate != null){
        date = Utils.formattedDate(selectedDate);
        widget.onSelectDate(selectedDate);
        setState(() {

        });
      }



      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: '${date[0]} , ${date[1]} ',
            textStyle: Theme.of(context).textTheme.bodySmall,
            textColor: OnlineClinicColorStyle.lightGray,
            textFontWight: TextFontWight.bold,
          ),
          CustomText(
            text: date[2],
            textStyle: Theme.of(context).textTheme.labelMedium,
            textColor: OnlineClinicColorStyle.lightGray,
            textFontWight: TextFontWight.bold,
          ),
          const CustomImage(
            imageSvgPath:'images/svg/arrow-down.svg' ,
          )
        ],
      ),
    );
  }
}
