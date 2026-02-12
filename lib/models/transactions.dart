/// Transaction type enum
enum TransactionType {
  sent,
  received,
  bill,
  airtime,
}

/// Transaction status enum
enum TransactionStatus {
  completed,
  pending,
  failed,
}

/// Transaction data model
/// Represents a money transfer transaction in SwiftPesa
class Transaction {
  const Transaction({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
    required this.date,
    required this.status,
    this.note,
  });

  /// Unique transaction identifier
  final String id;

  /// Contact name or merchant name
  final String name;

  /// Transaction amount (always positive)
  final double amount;

  /// Type of transaction (sent, received, bill, airtime)
  final TransactionType type;

  /// Date and time of transaction
  final DateTime date;

  /// Current status of transaction
  final TransactionStatus status;

  /// Optional note or description
  final String? note;

  /// Get initials from contact/merchant name
  String get initials {
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.length >= 2 ? name.substring(0, 2).toUpperCase() : name[0].toUpperCase();
  }

  /// Create a copy with modified fields
  Transaction copyWith({
    String? id,
    String? name,
    double? amount,
    TransactionType? type,
    DateTime? date,
    TransactionStatus? status,
    String? note,
  }) {
    return Transaction(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }
}