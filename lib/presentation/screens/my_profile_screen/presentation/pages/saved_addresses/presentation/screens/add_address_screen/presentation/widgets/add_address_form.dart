import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:somi/presentation/common/widgets/custom_drop_down.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_bloc.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_event.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_state.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';

class AddNewAddressForm extends StatefulWidget {
  const AddNewAddressForm({super.key});

  @override
  State<AddNewAddressForm> createState() => _AddNewAddressFormState();
}

class _AddNewAddressFormState extends State<AddNewAddressForm>
    with TickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  String addressType = "";
  final _formKey = GlobalKey<FormState>();
  bool saveForLater = false;
  @override
  void initState() {
    super.initState();
    nameController.text =
        locator<SavedAddressesBloc>().state.userAddress?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final bloc = locator<SavedAddressesBloc>();
    return BlocBuilder<SavedAddressesBloc, SavedAddressesState>(
      bloc: bloc,
      builder: (context, state) => Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                children: [
                  // ------------------------------------ Address Type ---------------------------------
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(25)),
                    child: CustomDropDown(
                        onChange: (value) {
                          setState(() {
                            addressType = value ?? '';
                          });
                        },
                        initialValue: 'Type',
                        items: const [
                          DropdownMenuItem(
                              value: 'Type',
                              child: Text(
                                'Type',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              )),
                        ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ------------------------------------ Address Name ---------------------------------
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: nameController,
                        onSaved: (newCardNumber) {
                          setState(() {
                            nameController.text = newCardNumber ?? '';
                          });
                        },
                        onChanged: (newCardNumber) {},
                        validator: (newCardNumber) {
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                            hintText: 'Name',
                            hintStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ------------------------------------ Apartment ---------------------------------
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: apartmentController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(25),
                        ],
                        onSaved: (newCardNumber) {
                          setState(() {
                            apartmentController.text = newCardNumber ?? '';
                          });
                        },
                        onChanged: (newCardNumber) {},
                        validator: (newCardNumber) {
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                            hintText: 'Apartment',
                            hintStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ------------------------------------ Floor Number ---------------------------------
                  // ------------------------------------ Apartment ---------------------------------
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: floorNumberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(25),
                        ],
                        onSaved: (newCardNumber) {
                          setState(() {
                            floorNumberController.text = newCardNumber ?? '';
                          });
                        },
                        onChanged: (newCardNumber) {},
                        validator: (newCardNumber) {
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                            hintText: 'Floor NO',
                            hintStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: buildingController,
                        onSaved: (newCardNumber) {
                          setState(() {
                            buildingController.text = newCardNumber ?? '';
                          });
                        },
                        onChanged: (newCardNumber) {},
                        validator: (newCardNumber) {
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                            hintText: 'Building',
                            hintStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ------------------------------------ Neighbrhood ---------------------------------
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: neighborhoodController,
                        onSaved: (newCardNumber) {
                          setState(() {
                            neighborhoodController.text = newCardNumber ?? '';
                          });
                        },
                        onChanged: (newCardNumber) {},
                        validator: (newCardNumber) {
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                            hintText: 'Neighbrhood',
                            hintStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ------------------------------------ Street Name ---------------------------------
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: streetNameController,
                        onSaved: (newCardNumber) {
                          setState(() {
                            streetNameController.text = newCardNumber ?? '';
                          });
                        },
                        onChanged: (newCardNumber) {},
                        validator: (newCardNumber) {
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                            hintText: 'Street name',
                            hintStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ------------------------------------ City Name ---------------------------------
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [kBoxShadow],
                        borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: cityNameController,
                        onSaved: (newCardNumber) {
                          setState(() {});
                        },
                        onChanged: (newCardNumber) {},
                        validator: (newCardNumber) {
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                            hintText: 'City',
                            hintStyle: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomButton(
                forgroundColor: Colors.white,
                height: 50,
                borderRadius: 25,
                child: const Text('Save address'),
                onPressed: () {
                  if (state.userAddress != null) {
                    bloc.add(SaveUserAddress(
                        address: state.userAddress!.copyWith(
                            type: addressType,
                            name: nameController.text,
                            apartment: apartmentController.text,
                            floorNo: floorNumberController.text,
                            building: buildingController.text,
                            neighbrhood: neighborhoodController.text,
                            streetName: streetNameController.text,
                            city: cityNameController.text)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
