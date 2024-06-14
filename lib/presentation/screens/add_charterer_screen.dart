import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/chaterer_controller.dart';
import 'package:charterer/presentation/screens/widgets/charterers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../core/theme/colors.dart';
import '../widgets/body_padding_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/custom_button.dart';
import '../widgets/text_fields/custom_drop_down.dart';
import '../widgets/text_fields/text_field_widget.dart';

class AddCharterer extends StatefulWidget {
  const AddCharterer({Key? key}) : super(key: key);

  @override
  State<AddCharterer> createState() => _AddChartererState();
}

class _AddChartererState extends State<AddCharterer> {
  ChartererController chartererController = Get.find<ChartererController>();

  final _formKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 34, 51),
      appBar: appBar(context: context, title: 'Add Charterer'),
      body: BodyPaddingWidget(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.h,
                ),
                TextFieldWidget(
                  textEditingController: fullName,
                  hint: "Full Name",
                  isRequired: true,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFieldWidget(
                  textEditingController: email,
                  type: "email",
                  hint: "Email",
                  isRequired: true,
                ),
                SizedBox(
                  height: 1.h,
                ),
                BuildDropdown(
                  selectedValue: country,
                  dropdownHint: "Country of residence",
                  isRequired: true,
                  itemsList: ['India']
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    country.text = value;
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFieldWidget(
                  textEditingController: mobileNumber,
                  type: "mobile",
                  hint: "Mobile Number",
                  isNumber: true,
                  isRequired: true,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFieldWidget(
                  textEditingController: address,
                  hint: "Address",
                  isRequired: true,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFieldWidget(
                  textEditingController: state,
                  hint: "State",
                  isRequired: true,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFieldWidget(
                  textEditingController: city,
                  hint: "City",
                  isRequired: true,
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFieldWidget(
                  textEditingController: website,
                  hint: "Website",
                  isRequired: true,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      'Want to search again?',
                      style:
                          textTheme.headlineMedium?.copyWith(color: bodyTextColor),
                    ),
                    InkWell(
                        onTap: () {
                          _charterersListBottomSheet(context);
                        },
                        child: Text(
                          ' Click here',
                          style: textTheme.headlineMedium
                              ?.copyWith(color: primaryColor),
                        )),
                  ],
                ),
                CustomButton(
                  name: "Continue",
                  color: primaryColor,
                  textColor: whiteColor,
                  left: 6.w,
                  right: 6.w,
                  bottom: 2.h,
                  top: 4.h,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      Helpers.loader();
                      final isSuccess = await chartererController.addCharterer(
                          fullName: fullName.text,
                          email: email.text,
                          country: country.text,
                          address: address.text,
                          state: state.text,
                          city: city.text,
                          website: website.text,
                          mobileNumber: mobileNumber.text);
                      Helpers.hideLoader();
                      if (isSuccess) {
                        fullName.clear();
                        email.clear();
                        country.clear();
                        address.clear();
                        state.clear();
                        city.clear();
                        website.clear();
                        mobileNumber.clear();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _charterersListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return const CustomBottomSheet(
            initialChildSize: 0.90,
            maxChildSize: 0.90,
            minChildSize: 0.5,
            isDismissible: false,
            child: Charterers());
      },
    );
  }
}
