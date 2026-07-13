import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ReceiptOcrData {
  final double? amount;
  final DateTime? date;
  final String? currency;
  final String fullText;

  ReceiptOcrData({
    this.amount,
    this.date,
    this.currency,
    required this.fullText,
  });
}

class ReceiptOcrHelper {
  static final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  /// Extract text from receipt image using OCR
  static Future<ReceiptOcrData> extractReceiptData(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      final fullText = recognizedText.text;
      final double? amount = _extractAmount(fullText);
      final DateTime? date = _extractDate(fullText);
      final String? currency = _extractCurrency(fullText);

      return ReceiptOcrData(
        amount: amount,
        date: date,
        currency: currency,
        fullText: fullText,
      );
    } catch (e) {
      throw 'Failed to process receipt: $e';
    }
  }

  /// Extract amount from receipt text
  static double? _extractAmount(String text) {
    try {
      // Look for common currency patterns: $100.00, 100.00, 100,00, etc.
      final patterns = [
        RegExp(r'\$\s*(\d+[.,]\d{2})'), // $100.00
        RegExp(r'(?:total|amount|subtotal|due)[:\s]*\$?\s*(\d+[.,]\d{2})', caseSensitive: false),
        RegExp(r'(\d+[.,]\d{2})(?:\s*USD|\s*AUD|\s*EUR|\s*GBP)?$', multiLine: true),
      ];

      for (var pattern in patterns) {
        final match = pattern.firstMatch(text);
        if (match != null) {
          final amountStr = match.group(1)!.replaceAll(',', '.');
          return double.tryParse(amountStr);
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Extract date from receipt text
  static DateTime? _extractDate(String text) {
    try {
      // Look for common date formats
      final patterns = [
        RegExp(r'(\d{1,2})[/-](\d{1,2})[/-](\d{4})'), // DD/MM/YYYY or MM/DD/YYYY
        RegExp(r'(\d{4})-(\d{1,2})-(\d{1,2})'), // YYYY-MM-DD
        RegExp(r'(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s+(\d{1,2})[,\s]+(\d{4})', caseSensitive: false),
      ];

      for (var pattern in patterns) {
        final match = pattern.firstMatch(text);
        if (match != null) {
          try {
            if (match.groupCount >= 3) {
              final groups = [match.group(1), match.group(2), match.group(3)];

              // Handle month name format
              if (groups[0]!.contains(RegExp(r'[a-zA-Z]'))) {
                final monthStr = groups[0]!;
                final months = [
                  'jan', 'feb', 'mar', 'apr', 'may', 'jun',
                  'jul', 'aug', 'sep', 'oct', 'nov', 'dec'
                ];
                final monthIndex = months
                    .indexWhere((m) => monthStr.toLowerCase().startsWith(m));
                if (monthIndex != -1) {
                  final day = int.parse(groups[1]!);
                  final year = int.parse(groups[2]!);
                  return DateTime(year, monthIndex + 1, day);
                }
              } else {
                // Numeric date format
                int day, month, year;

                if (int.parse(groups[0]!) > 31) {
                  // YYYY-MM-DD format
                  year = int.parse(groups[0]!);
                  month = int.parse(groups[1]!);
                  day = int.parse(groups[2]!);
                } else {
                  // DD/MM/YYYY or MM/DD/YYYY format
                  day = int.parse(groups[0]!);
                  month = int.parse(groups[1]!);
                  year = int.parse(groups[2]!);
                }

                return DateTime(year, month, day);
              }
            }
          } catch (e) {
            continue;
          }
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Extract currency from receipt text
  static String? _extractCurrency(String text) {
    final currencyPatterns = {
      'USD': RegExp(r'\$|USD'),
      'EUR': RegExp(r'€|EUR'),
      'GBP': RegExp(r'£|GBP'),
      'CAD': RegExp(r'C\$|CAD'),
      'AUD': RegExp(r'A\$|AUD'),
      'JPY': RegExp(r'¥|JPY'),
    };

    for (var currency in currencyPatterns.entries) {
      if (currency.value.hasMatch(text)) {
        return currency.key;
      }
    }

    return 'USD'; // Default currency
  }

  /// Dispose of resources
  static void dispose() {
    _textRecognizer.close();
  }
}
