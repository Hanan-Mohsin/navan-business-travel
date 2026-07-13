import '../models/card.dart';
import '../config/constants.dart';
import 'api_service.dart';

class CardService {
  final ApiService _apiService = ApiService();
  static final CardService _instance = CardService._internal();

  factory CardService() {
    return _instance;
  }

  CardService._internal();

  // Get all corporate cards for current user
  Future<List<CorporateCard>> getCards() async {
    try {
      final response = await _apiService.get(AppConstants.getCardsEndpoint);
      final List<dynamic> cards = response['cards'] ?? [];
      return cards.map((card) => CorporateCard.fromJson(card as Map<String, dynamic>)).toList();
    } catch (e) {
      throw 'Failed to fetch cards: $e';
    }
  }

  // Get card details
  Future<CorporateCard> getCardById(String cardId) async {
    try {
      final response = await _apiService.get('${AppConstants.getCardsEndpoint}/$cardId');
      return CorporateCard.fromJson(response['card']);
    } catch (e) {
      throw 'Failed to fetch card: $e';
    }
  }

  // Update card status
  Future<CorporateCard> updateCardStatus(String cardId, String status) async {
    try {
      final response = await _apiService.put(
        '${AppConstants.getCardsEndpoint}/$cardId',
        {'status': status},
      );
      return CorporateCard.fromJson(response['card']);
    } catch (e) {
      throw 'Failed to update card: $e';
    }
  }

  // Lock card
  Future<CorporateCard> lockCard(String cardId) async {
    try {
      final response = await _apiService.put(
        '${AppConstants.getCardsEndpoint}/$cardId/lock',
        {'status': 'Locked'},
      );
      return CorporateCard.fromJson(response['card']);
    } catch (e) {
      throw 'Failed to lock card: $e';
    }
  }

  // Unlock card
  Future<CorporateCard> unlockCard(String cardId) async {
    try {
      final response = await _apiService.put(
        '${AppConstants.getCardsEndpoint}/$cardId/unlock',
        {'status': 'Active'},
      );
      return CorporateCard.fromJson(response['card']);
    } catch (e) {
      throw 'Failed to unlock card: $e';
    }
  }
}
