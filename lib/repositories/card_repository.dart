import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/card_model.dart';

part 'card_repository.g.dart';

@riverpod
CardRepository cardRepository(CardRepositoryRef ref) => CardRepository();

class CardRepository {
  Future<List<CardModel>> getAllCards() async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () {
        return CardModel.sampleCards;
      },
    );
  }

  Future<CardModel> getCard(int modelId) async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () {
        return CardModel.sampleCards.where((card) => card.id == modelId).first;
      },
    );
  }
}
