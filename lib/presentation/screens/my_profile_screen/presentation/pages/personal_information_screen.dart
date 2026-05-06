import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/bloc/profile_event.dart';

import '../../../../../core/service_locator.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/custom_rounded_button.dart';
import '../../../car_rental/presentation/widgets/CustomTextFormField.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_row.dart';

@RoutePage()
class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  ProfileBloc bloc = locator<ProfileBloc>();
  late bool isEdit;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    isEdit = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          action: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 10, vertical: 12),
            child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  isEdit = !isEdit;
                  bloc.add(EditProfileEvent(edit: isEdit));
                },
                child: SvgPicture.asset(SvgImages.editProfileIcon)),
          ),
          title: 'Personal Information',
          onBackButtonPressed: () {
            Navigator.of(context).pop();
          },
          onHomeButtonPressed: () {},
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: bloc,
          builder: (context, state) {
            nameController.text = state.name ?? '';
            phoneController.text = state.phone ?? '';
            emailController.text = state.email ?? '';
            return state.edit == false
                ? Column(
                    children: [
                      ProfileRow(
                          title: state.name ?? '',
                          hideIcon: true,
                          image: SvgImages.personIcon),
                      ProfileRow(
                          title: state.phone ?? '',
                          hideIcon: true,
                          image: SvgImages.phoneIcon),
                      ProfileRow(
                          title: state.email ?? '',
                          hideIcon: true,
                          image: SvgImages.emailIcon),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                            textPaddingTop: 0,
                            textPaddingbottom: 5,
                            iconPaddingbottom: 5,
                            iconPaddingTop: 5,
                            dropDownIconPaddingTop: 5,
                            dropDownIconPaddingbottom: 5,
                            required: false,
                            isborder: false,
                            prefixIcon: true,
                            controller: nameController,
                            icon: SvgPicture.asset(SvgImages.userIcon)),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                            textPaddingTop: 0,
                            textPaddingbottom: 5,
                            iconPaddingbottom: 5,
                            iconPaddingTop: 5,
                            dropDownIconPaddingTop: 5,
                            keyboardType: TextInputType.phone,
                            dropDownIconPaddingbottom: 5,
                            required: false,
                            isborder: false,
                            prefixIcon: true,
                            controller: phoneController,
                            icon: SvgPicture.asset(SvgImages.phoneIcon)),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomTextFormField(
                            textPaddingTop: 0,
                            textPaddingbottom: 5,
                            iconPaddingbottom: 5,
                            iconPaddingTop: 5,
                            keyboardType: TextInputType.emailAddress,
                            dropDownIconPaddingTop: 5,
                            dropDownIconPaddingbottom: 5,
                            required: false,
                            isborder: false,
                            prefixIcon: true,
                            controller: emailController,
                            icon: SvgPicture.asset(SvgImages.emailIcon)),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomRoundedButton(
                              height: 45,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 24,
                              text: 'Cancel',
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              pressed: () {
                                isEdit = false;
                                bloc.add(EditProfileEvent(edit: isEdit));
                              },
                            ),
                            CustomRoundedButton(
                              height: 45,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 24,
                              text: 'Update',
                              textColor: Colors.white,
                              backgroundColor: SomiColors.blue,
                              pressed: () {
                                bloc.add(UpdateProfileEvent(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                ));
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
          },
        ));
  }
}
