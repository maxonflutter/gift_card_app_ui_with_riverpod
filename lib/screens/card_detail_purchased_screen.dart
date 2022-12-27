import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../gen/assets.gen.dart';
import '../providers/selected_card_provider.dart';
import '../providers/selected_gift_amount_provider.dart';
import '../utilities/app_text.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_arc_painter.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_gift_card.dart';

class CardPurchasedScreen extends ConsumerWidget {
  const CardPurchasedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final selectedCard = ref.watch(selectedCardProvider);
    final selectedGiftAmount = ref.watch(selectedGiftAmountProvider);

    return Scaffold(
      backgroundColor: selectedCard.value?.bgColor,
      appBar: const CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              height: size.height * 0.5,
              padding: const EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                top: 20.0,
              ),
              child: selectedCard.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                data: (card) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  child: CustomGiftCard(
                    model: card,
                    width: size.width - 50,
                    value: selectedGiftAmount,
                    showValue: true,
                    showLabel: false,
                  ),
                ),
                error: (e, s) => Center(
                  child: AppText.medium("Card not found: $e"),
                ),
              ),
            ),
          ),
          _BottomSheet(
            giftAmount: selectedGiftAmount ?? 0,
            height: size.height * 0.35,
          ),
        ],
      ),
    );
  }
}

class _BottomSheet extends ConsumerWidget {
  final double? height;
  final int giftAmount;

  const _BottomSheet({
    Key? key,
    required this.giftAmount,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const arcCount = 24;
    final size = MediaQuery.of(context).size;
    final uuid = const Uuid().v1().replaceAll('-', '').substring(0, 16);

    return Stack(
      children: [
        const Positioned(top: 0, child: CustomArcLines()),
        Container(
          color: Colors.white,
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.only(top: 5.0),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppText.large("Card Sent!", fontWeight: FontWeight.bold),
              const SizedBox(height: 10),
              AppText.medium("massimo@maxonflutter.com"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.icon.gift1.svg(),
                  const SizedBox(width: 10),
                  AppText.title(
                    '\$$giftAmount',
                    color: Colors.black87,
                    fontSize: 30,
                  ),
                ],
              ),
              const Divider(height: 30, thickness: 1),
              AppText.medium("Card Number $uuid"),
              const Spacer(),
              CustomElevatedButton(
                text: 'Share This',
                backgroundColor: Colors.black87,
                fixedSize: Size(size.width, 50),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
