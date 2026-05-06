import 'package:flutter/material.dart';
import 'package:somi/core/models/car_brand.dart';

class BrandCard extends StatelessWidget {
  final CarBrandModel item;
  const BrandCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 125,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                offset: const Offset(2, 4),
                blurRadius: 2,
                spreadRadius: 2)
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 12,
              ),
              Image.asset(item.image!),
              const SizedBox(
                height: 6,
              ),
              Text(
                item.name!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
