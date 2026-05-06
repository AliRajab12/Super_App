import 'package:flutter/material.dart';

import '../../../../../core/theme/colors.dart';

class PromoCodeWidget extends StatelessWidget {
  const PromoCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.06),
              offset: const Offset(2, 4),
              spreadRadius: 3,
              blurRadius: 3,
            )
          ]),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          isDense: true,
          fillColor: Colors.white,
          isCollapsed: true,
          suffixIcon: Container(
            height: 50,
            width: 100,
            decoration: const BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(25),
                    topEnd: Radius.circular(25)),
                color: SomiColors.blue),
            child: const Center(
              child: Text(
                'Send',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          hintText: 'Promo code',
          alignLabelWithHint: true,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          counterStyle: Theme.of(context).textTheme.bodyMedium,
          contentPadding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 12,
            bottom: 12,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Colors.transparent, width: 0.0),
              borderRadius: BorderRadius.circular(25)),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
