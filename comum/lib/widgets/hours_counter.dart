import 'package:flutter/material.dart';

import '../utilities/utilities.dart';
import 'custom_floating_button.dart';
import 'default_app_bar.dart';

class HoursCounter extends StatefulWidget {
  const HoursCounter({super.key});

  @override
  State<HoursCounter> createState() => _HoursCounterState();
}

class _HoursCounterState extends State<HoursCounter> {
  String totalHours = "00:00";

  List<Map<String, DateTime>> hours = [
    {
      "start_hour": DateTime.now(),
      "end_hour": DateTime.now(),
    },
  ];

  String getTotalHours() {
    Duration totalDuration = const Duration();

    for (int i = 0; i < hours.length; i++) {
      DateTime start = hours[i]["start_hour"]!;
      DateTime end = hours[i]["end_hour"]!;
      Duration duration = end.difference(start);
      print("duration: $duration");
      totalDuration = totalDuration + duration;
    }

    String hour = totalDuration.inHours.toString().padLeft(2, "0");
    String minutes = (totalDuration.inMinutes - (int.parse(hour) * 60))
        .toString()
        .padLeft(2, "0");
    return "$hour : $minutes";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: maxHeight(context) + viewPaddingTop(context),
            width: maxWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const DefaultAppBar(title: "Contador de horas"),
                ...List.generate(
                  hours.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(vertical: wXD(20, context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Das:",
                          style: getStyles(context).titleMedium!.copyWith(
                                color: getColors(context).primary,
                              ),
                        ),
                        hSpace(wXD(10, context)),
                        SizedBox(
                          width: wXD(100, context),
                          child: TextFormField(
                            inputFormatters: [Masks.hourMask],
                            initialValue:
                                "${hours[index]["start_hour"]!.hour.toString().padLeft(2, "0")}:"
                                "${hours[index]["start_hour"]!.minute.toString().padLeft(2, "0")}",
                            style: getStyles(context).titleMedium!.copyWith(
                                  color: getColors(context).primary,
                                  fontSize: 25,
                                ),
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              // print("value: $value");
                              if (value.length == 5) {
                                DateTime now = DateTime.now();
                                hours[index]["start_hour"] = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    int.parse(value.substring(0, 2)),
                                    int.parse(value.substring(3, 5)));
                                // print(
                                //     "hours[index]['start_hour']: ${hours[index]["start_hour"]} ");
                                totalHours = getTotalHours();
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        hSpace(wXD(10, context)),
                        Text(
                          "Ás:",
                          style: getStyles(context).titleMedium!.copyWith(
                                color: getColors(context).primary,
                              ),
                        ),
                        hSpace(wXD(10, context)),
                        SizedBox(
                          width: wXD(100, context),
                          child: TextFormField(
                            inputFormatters: [Masks.hourMask],
                            initialValue:
                                "${hours[index]["end_hour"]!.hour.toString().padLeft(2, "0")}:"
                                "${hours[index]["end_hour"]!.minute.toString().padLeft(2, "0")}",
                            style: getStyles(context).titleMedium!.copyWith(
                                  color: getColors(context).primary,
                                  fontSize: 25,
                                ),
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              // print("value: $value");
                              if (value.length == 5) {
                                DateTime now = DateTime.now();
                                hours[index]["end_hour"] = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    int.parse(value.substring(0, 2)),
                                    int.parse(value.substring(3, 5)));
                                // print(
                                //     "hours[index]['start_hour']: ${hours[index]["start_hour"]} ");
                                totalHours = getTotalHours();
                                setState(() {});
                              }
                            },
                          ),
                        ),
                        hSpace(wXD(10, context)),
                        IconButton(
                            onPressed: () {
                              hours.removeAt(index);
                              totalHours = getTotalHours();
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.remove,
                              color: getColors(context).primary,
                              size: wXD(30, context),
                            ))
                      ],
                    ),
                  ),
                ),
                vSpace(wXD(30, context)),
                Text(
                  "Total: $totalHours",
                  style: getStyles(context).titleLarge,
                ),
                vSpace(wXD(30, context)),
                // PrimaryButton(
                //   label: "Calcular",
                //   onTap: () => setState(() => getTotalHours()),
                // ),
                // vSpace(wXD(30, context)),
              ],
            ),
          ),
          Positioned(
            right: /*showFloatingButton ?*/ wXD(
                20, context) /*: -wXD(
                60, context)*/
            ,
            bottom: wXD(70, context),
            // duration: const Duration(milliseconds: 300),
            child: CustomFloatButton(
              icon: Icons.add_rounded,
              onTap: () => setState(() => hours.add({
                    "start_hour": DateTime.now(),
                    "end_hour": DateTime.now(),
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
