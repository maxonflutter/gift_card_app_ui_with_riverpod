import 'package:flutter/material.dart';

import '../models/card_model.dart';
import '../utilities/app_text.dart';

class CustomGiftCard extends StatelessWidget {
  final CardModel model;
  final double width;
  final double? height;
  final int? value;
  final bool showLabel;
  final bool showValue;

  const CustomGiftCard({
    Key? key,
    required this.model,
    this.width = 150,
    this.height,
    this.value,
    this.showLabel = true,
    this.showValue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.asset(
                model.thumbnailPath,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            if (showLabel) ...[
              const SizedBox(height: 8),
              AppText.medium(model.name),
            ]
          ],
        ),
        if (showValue)
          Positioned(
            right: 10.0,
            bottom: 10.0,
            child: AppText.large('\$$value'),
          ),
      ],
    );
  }
}
