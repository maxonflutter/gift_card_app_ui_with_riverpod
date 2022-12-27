import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../gen/assets.gen.dart';
import '../gen/colors.gen.dart';
import '../models/card_model.dart';
import '../utilities/app_text.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_gift_card.dart';
import 'card_detail_purchased_screen.dart';

class CardDetailInputScreen extends StatelessWidget {
  final CardModel model;
  final int giftValue;

  const CardDetailInputScreen({
    Key? key,
    required this.model,
    required this.giftValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: model.bgColor,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: size.height * 0.25,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      spreadRadius: 2,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: CustomGiftCard(model: model, showLabel: false),
              ),
            ),
            AppText.title(
              '\$$giftValue',
              color: Colors.white,
              fontSize: 30,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  _buildTextFormField('Recipient', 'name'),
                  const SizedBox(height: 10),
                  _buildTextFormField('Email', 'email'),
                  const SizedBox(height: 10),
                  _buildTextFormField('Message', 'message', maxLines: 4),
                  const SizedBox(height: 10),
                  const _PaymentMethods(),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    text: 'Continue',
                    backgroundColor: Colors.black87,
                    fixedSize: Size(size.width, 50),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const CardPurchasedScreen()),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildTextFormField(String label, String hintText, {int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          label,
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorName.primaryColor,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorName.lightGrey,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.all(20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
          maxLines: maxLines ?? 1,
        ),
      ],
    );
  }
}

class _PaymentMethods extends ConsumerWidget {
  const _PaymentMethods({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          'Payment Method',
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
        const SizedBox(height: 10),
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Radio(
                value: 'Mastercard',
                groupValue: 'Mastercard',
                onChanged: (value) {},
              ),
              title: Row(
                children: [
                  SvgPicture.asset(Assets.icon.mc.path),
                  const SizedBox(width: 12),
                  AppText.medium('4180', fontWeight: FontWeight.normal),
                ],
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Radio(
                value: 'Paypal',
                groupValue: 'Mastercard',
                onChanged: (value) {},
              ),
              title: Row(
                children: [
                  SvgPicture.asset(Assets.icon.paypal.path),
                  const SizedBox(width: 12),
                  AppText.medium('Paypal', fontWeight: FontWeight.normal),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
