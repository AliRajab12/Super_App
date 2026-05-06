import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';

showTimeDialog({context, isStart, value, required Function(String) callBack}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isStart ? 'Delivery Time' : 'EndTime',
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.clear))
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.height * 0.6) - 60,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      TimeOfDay startTime =
                          const TimeOfDay(hour: 14, minute: 0);
                      TimeOfDay currentTime = TimeOfDay(
                        hour: startTime.hour + (index * 30) ~/ 60,
                        minute: startTime.minute + (index * 30) % 60,
                      );
                      TimeOfDay endTimeSlot = TimeOfDay(
                        hour: startTime.hour + ((index + 1) * 30) ~/ 60,
                        minute: startTime.minute + ((index + 1) * 30) % 60,
                      );
                      String formattedTime =
                          '${currentTime.format(context)} - ${endTimeSlot.format(context)}';
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            callBack(formattedTime);
                            Navigator.of(context).pop();
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formattedTime,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    Container(
                                      height: 14,
                                      width: 14,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: SomiColors.grey
                                                  .withOpacity(0.4))),
                                      child: value == formattedTime
                                          ? Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Container(
                                                  height: 12,
                                                  width: 12,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: SomiColors.grey
                                                          .withOpacity(0.4)),
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Container(
                                height: 0.1,
                                width: MediaQuery.of(context).size.width,
                                color: SomiColors.grey,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

warningDialog(BuildContext context, String body) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            content: Text(body, style: kCarTitle),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok', style: TextStyle(color: Colors.blue)))
            ],
          ));
}
