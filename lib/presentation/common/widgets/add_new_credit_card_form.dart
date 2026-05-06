import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:somi/core/models/credit_card.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/core/utils/input_formatter.dart';
import 'package:somi/presentation/common/bloc/payment_bloc.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';

class AddNewCreditCardForm extends StatefulWidget {
  final bool? fromAddCardScreen;
  const AddNewCreditCardForm({super.key, this.fromAddCardScreen});

  @override
  State<AddNewCreditCardForm> createState() => _AddNewCreditCardFormtate();
}

class _AddNewCreditCardFormtate extends State<AddNewCreditCardForm>
    with TickerProviderStateMixin {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardDateController = TextEditingController();
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cvcNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _cardNumberFormFieldKey = GlobalKey<FormFieldState>();
  final _cardHolderNameFormFieldKey = GlobalKey<FormFieldState>();
  final _cardDateFormFieldKey = GlobalKey<FormFieldState>();
  final _cvcNumberFormFieldKey = GlobalKey<FormFieldState>();
  bool saveForLater = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------------------------------------ Card number Text Field ---------------------------------
          Text(
            'Card Number',
            style: kSectionTitle.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              key: _cardNumberFormFieldKey,
              keyboardType: TextInputType.number,
              controller: cardNumberController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter(),
              ],
              onSaved: (newCardNumber) {
                setState(() {
                  cardNumberController.text = newCardNumber ?? '';
                });
              },
              onChanged: (newCardNumber) {
                _cardNumberFormFieldKey.currentState!.validate();
              },
              validator: (newCardNumber) {
                if (newCardNumber!.isEmpty) {
                  return 'Please enter your card number';
                } else if (newCardNumber.length < 19) {
                  return 'Please enter a valid card number';
                }
                return null;
              },
              decoration: textFieldInputDecoration.copyWith(
                  hintText: 'xxxx-xxxx-xxxx-xxxx')),
          const SizedBox(
            height: 20,
          ),
          // ------------------------------------ Card Date Text Field ---------------------------------

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CVV',
                      style: kSectionTitle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        key: _cvcNumberFormFieldKey,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                        ],
                        onSaved: (newCVCNumber) {
                          setState(() {
                            cvcNumberController.text = newCVCNumber!;
                          });
                        },
                        onChanged: (newCVCNumber) {
                          _cvcNumberFormFieldKey.currentState!.validate();
                        },
                        validator: (newCVCNumber) {
                          if (newCVCNumber!.isEmpty) {
                            return 'Please enter\nyour card\nverification code';
                          }
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                          hintText: '000',
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.2,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiration Date',
                      style: kSectionTitle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        readOnly: true,
                        onTap: () async {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext builder) {
                                return Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (value) {
                                        cardDateController.text =
                                            DateFormat('MM/yyyy').format(value);
                                        _cardDateFormFieldKey.currentState!
                                            .validate();
                                      },
                                      initialDateTime: DateTime.now(),
                                      minimumYear: 2023,
                                      maximumYear: 2050,
                                      dateOrder: DatePickerDateOrder.dmy,
                                    ),
                                  ),
                                );
                              });
                        },
                        key: _cardDateFormFieldKey,
                        keyboardType: TextInputType.number,
                        controller: cardDateController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        onSaved: (newCardDate) {},
                        onChanged: (newCardDate) {
                          _cardHolderNameFormFieldKey.currentState!.validate();
                        },
                        validator: (newCardDate) {
                          if (newCardDate!.isEmpty) {
                            return 'Please choose\nthe expiration\ndate';
                          }
                          return null;
                        },
                        decoration: textFieldInputDecoration.copyWith(
                          hintText: 'MM/YY',
                        )),
                  ],
                ),
              ),
            ],
          ),
          // ------------------------------------ Card Holder Name Text Field ---------------------------------
          const SizedBox(
            height: 20,
          ),
          Text(
            'Full Name',
            style: kSectionTitle.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              key: _cardHolderNameFormFieldKey,
              keyboardType: TextInputType.name,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
              ],
              onSaved: (newHolderName) {
                setState(() {
                  cardHolderNameController.text = newHolderName!;
                });
              },
              onChanged: (newHolderName) {
                _cardHolderNameFormFieldKey.currentState!.validate();
              },
              validator: (newHolderName) {
                if (newHolderName!.isEmpty) {
                  return 'Please enter card holder name';
                }
                return null;
              },
              decoration: textFieldInputDecoration.copyWith(hintText: 'Name')),
          const SizedBox(
            height: 30,
          ),
          widget.fromAddCardScreen != null && widget.fromAddCardScreen == true
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomButton(
                      forgroundColor: Colors.white,
                      height: 50,
                      borderRadius: 25,
                      child: const Text('Send OTP'),
                      onPressed: () {
                        _formKey.currentState!.validate();
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          locator<PaymentBloc>().add(SendCreditCardOTP(
                              saveCreditDetails: saveForLater,
                              cardDetails: CreditCard(
                                  number: cardNumberController.text,
                                  holderName: cardHolderNameController.text,
                                  cvv: cvcNumberController.text,
                                  expirationDate: cardDateController.text,
                                  type: 'visa')));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          saveForLater = !saveForLater;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox.adaptive(
                              activeColor: AppColors.primary.withOpacity(0.6),
                              value: saveForLater,
                              onChanged: (value) {
                                setState(() {
                                  saveForLater = !saveForLater;
                                });
                              }),
                          const Text(
                            'Save details for future',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
