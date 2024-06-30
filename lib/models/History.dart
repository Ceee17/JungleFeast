class HistoryItem {
  final String imageUrl;
  final String transactionId;
  final String title;
  final String date;
  final String category;
  final String finalPrice;

  const HistoryItem({
    required this.imageUrl,
    required this.transactionId,
    required this.title,
    required this.date,
    required this.category,
    required this.finalPrice,
  });
}
