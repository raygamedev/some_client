class CardColor {
  int cardColor;
  int markColor;
  CardColor({required this.cardColor, required this.markColor});
  factory CardColor.fromJson(Map<String, dynamic> json) {
    return CardColor(
      cardColor: json['card_color'] as int,
      markColor: json['mark_color'] as int,
    );
  }
}

class CardMark {
  int index;
  bool isMarked;
  CardMark({required this.index, required this.isMarked});
  factory CardMark.fromJson(Map<String, dynamic> json) {
    return CardMark(
      index: json['index'] as int,
      isMarked: json['is_marked'] as bool,
    );
  }
}

class CardModel {
  List<CardMark> cardMarks;
  CardColor color;
  String cardId;
  String merchantId;
  CardModel(
      {required this.cardMarks,
      required this.color,
      required this.cardId,
      required this.merchantId});

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
        cardMarks: List<CardMark>.from(json['marks']),
        color: CardColor.fromJson(json['color']),
        cardId: json['card_id'],
        merchantId: json['merchant_id']);
  }
  factory CardModel.error() {
    return CardModel(
        cardMarks: [],
        color: CardColor(cardColor: 0, markColor: 0),
        cardId: '',
        merchantId: '');
  }
}
