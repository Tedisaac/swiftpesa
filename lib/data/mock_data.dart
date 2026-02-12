import '../models/contact.dart';
import '../models/transactions.dart';

class MockData {
  MockData._();

  static const List<Contact> contacts = [
    Contact(
      id: 'c1',
      name: 'John Kamau',
      phoneNumber: '+254712345678',
    ),
    Contact(
      id: 'c2',
      name: 'Mary Wanjiku',
      phoneNumber: '+254723456789',
    ),
    Contact(
      id: 'c3',
      name: 'Peter Ochieng',
      phoneNumber: '+254734567890',
    ),
    Contact(
      id: 'c4',
      name: 'Grace Akinyi',
      phoneNumber: '+254745678901',
    ),
    Contact(
      id: 'c5',
      name: 'David Mutua',
      phoneNumber: '+254756789012',
    ),
    Contact(
      id: 'c6',
      name: 'Sarah Njeri',
      phoneNumber: '+254767890123',
    ),
    Contact(
      id: 'c7',
      name: 'James Otieno',
      phoneNumber: '+254778901234',
    ),
    Contact(
      id: 'c8',
      name: 'Lucy Mwangi',
      phoneNumber: '+254789012345',
    ),
  ];

  static final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      name: 'John Kamau',
      amount: 2500.00,
      type: TransactionType.sent,
      date: DateTime.now().subtract(const Duration(hours: 2)),
      status: TransactionStatus.completed,
      note: 'Lunch money',
    ),
    Transaction(
      id: 't2',
      name: 'Mary Wanjiku',
      amount: 5000.00,
      type: TransactionType.received,
      date: DateTime.now().subtract(const Duration(hours: 5)),
      status: TransactionStatus.completed,
      note: 'Payment for services',
    ),
    Transaction(
      id: 't3',
      name: 'Kenya Power',
      amount: 3200.00,
      type: TransactionType.bill,
      date: DateTime.now().subtract(const Duration(days: 1)),
      status: TransactionStatus.completed,
      note: 'Electricity bill - Account 12345',
    ),
    Transaction(
      id: 't4',
      name: 'Safaricom Airtime',
      amount: 500.00,
      type: TransactionType.airtime,
      date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: 't5',
      name: 'Peter Ochieng',
      amount: 1500.00,
      type: TransactionType.sent,
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: TransactionStatus.completed,
      note: 'Transport refund',
    ),
    Transaction(
      id: 't6',
      name: 'Grace Akinyi',
      amount: 8000.00,
      type: TransactionType.received,
      date: DateTime.now().subtract(const Duration(days: 3)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: 't7',
      name: 'Nairobi Water',
      amount: 1800.00,
      type: TransactionType.bill,
      date: DateTime.now().subtract(const Duration(days: 4)),
      status: TransactionStatus.completed,
      note: 'Water bill',
    ),
    Transaction(
      id: 't8',
      name: 'David Mutua',
      amount: 3000.00,
      type: TransactionType.sent,
      date: DateTime.now().subtract(const Duration(days: 5)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: 't9',
      name: 'Safaricom Airtime',
      amount: 200.00,
      type: TransactionType.airtime,
      date: DateTime.now().subtract(const Duration(days: 5, hours: 6)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: 't10',
      name: 'Sarah Njeri',
      amount: 4500.00,
      type: TransactionType.received,
      date: DateTime.now().subtract(const Duration(days: 6)),
      status: TransactionStatus.completed,
      note: 'Loan repayment',
    ),
    Transaction(
      id: 't11',
      name: 'James Otieno',
      amount: 2000.00,
      type: TransactionType.sent,
      date: DateTime.now().subtract(const Duration(days: 7)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: 't12',
      name: 'KPLC Postpaid',
      amount: 2800.00,
      type: TransactionType.bill,
      date: DateTime.now().subtract(const Duration(days: 8)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: 't13',
      name: 'Lucy Mwangi',
      amount: 6000.00,
      type: TransactionType.received,
      date: DateTime.now().subtract(const Duration(days: 9)),
      status: TransactionStatus.completed,
      note: 'Product sale',
    ),
    Transaction(
      id: 't14',
      name: 'Safaricom Airtime',
      amount: 1000.00,
      type: TransactionType.airtime,
      date: DateTime.now().subtract(const Duration(days: 10)),
      status: TransactionStatus.completed,
    ),
    Transaction(
      id: 't15',
      name: 'John Kamau',
      amount: 3500.00,
      type: TransactionType.sent,
      date: DateTime.now().subtract(const Duration(days: 11)),
      status: TransactionStatus.completed,
    ),
  ];

  static const double initialBalance = 12450.00;
}