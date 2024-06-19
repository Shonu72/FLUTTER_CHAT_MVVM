import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';
import '../../getx/controllers/chaterer_controller.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/text_fields/text_field_widget.dart';

class Charterers extends StatefulWidget {
  const Charterers({Key? key}) : super(key: key);

  @override
  State<Charterers> createState() => _CharterersState();
}

class _CharterersState extends State<Charterers> {
  TextEditingController search = TextEditingController();
  ChartererController chartererController = Get.find<ChartererController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Charterer',
          style: textTheme.headline3,
        ),
        SizedBox(
          height: 20,
        ),
        TextFieldWidget(
          textEditingController: search,
          hint: "Search",
          onChanged: (value) {
            chartererController.getCharterers(search: value);
          },
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: primaryColor),
          ),
          child: Obx(() {
            if (chartererController.isCharterersFetching.value) {
              return const CustomLoader();
            } else if (chartererController.charterers.isEmpty) {
              return const NoDataFoundWidget();
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: chartererController.charterers.length,
                itemBuilder: (context, index) {
                  final charterer = chartererController.charterers[index];
                  return ListTile(
                    title: Text(
                      charterer.chartererName,
                      style: textTheme.headline3,
                    ),
                  );
                },
              );
            }
          }),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Can't find your character ?",
              style: textTheme.headline4?.copyWith(color: bodyTextColor),
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '  Add Now',
                  style: textTheme.headline4?.copyWith(color: primaryColor),
                )),
          ],
        ),
      ],
    );
  }
}
