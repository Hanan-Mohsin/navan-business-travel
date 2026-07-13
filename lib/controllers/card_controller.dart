import 'package:get/get.dart';
import '../models/card.dart';
import '../services/card_service.dart';

class CardController extends GetxController {
  final CardService _cardService = CardService();
  final RxList<CorporateCard> cards = <CorporateCard>[].obs;
  final Rx<CorporateCard?> selectedCard = Rx<CorporateCard?>(null);
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  // Get all cards
  Future<void> fetchCards() async {
    isLoading.value = true;
    error.value = '';

    try {
      cards.value = await _cardService.getCards();
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Get card by ID
  Future<void> fetchCardById(String cardId) async {
    isLoading.value = true;
    error.value = '';

    try {
      selectedCard.value = await _cardService.getCardById(cardId);
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  // Lock card
  Future<bool> lockCard(String cardId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final lockedCard = await _cardService.lockCard(cardId);
      final index = cards.indexWhere((card) => card.id == cardId);
      if (index != -1) {
        cards[index] = lockedCard;
      }
      if (selectedCard.value?.id == cardId) {
        selectedCard.value = lockedCard;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Unlock card
  Future<bool> unlockCard(String cardId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final unlockedCard = await _cardService.unlockCard(cardId);
      final index = cards.indexWhere((card) => card.id == cardId);
      if (index != -1) {
        cards[index] = unlockedCard;
      }
      if (selectedCard.value?.id == cardId) {
        selectedCard.value = unlockedCard;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      return false;
    }
  }

  // Get active cards
  List<CorporateCard> get activeCards {
    return cards.where((card) => card.status == 'Active').toList();
  }

  // Get total available balance
  double get totalAvailableBalance {
    return cards.fold(
      0.0,
      (sum, card) => sum + (card.spendLimit - card.spent),
    );
  }

  // Get total spent
  double get totalSpent {
    return cards.fold(0.0, (sum, card) => sum + card.spent);
  }

  // Clear error
  void clearError() {
    error.value = '';
  }
}
