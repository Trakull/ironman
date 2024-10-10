class Transactions {
  int? keyID;
  final String title;
  final double amount;
  final String color;
  final String category;

  Transactions({
    this.keyID,
    required this.title,
    required this.amount,
    required this.color,
    required this.category,
  });
}
