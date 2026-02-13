import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/contact.dart';
import '../../../models/transactions.dart';
import '../../../data/mock_data.dart';

/// Send money flow state
class SendMoneyState {
  const SendMoneyState({
    this.selectedContact,
    this.amount = 0.0,
    this.pin = '',
    this.currentStep = SendMoneyStep.selectContact,
    this.isProcessing = false,
    this.error,
    this.completedTransaction,
  });

  final Contact? selectedContact;
  final double amount;
  final String pin;
  final SendMoneyStep currentStep;
  final bool isProcessing;
  final String? error;
  final Transaction? completedTransaction;

  SendMoneyState copyWith({
    Contact? selectedContact,
    double? amount,
    String? pin,
    SendMoneyStep? currentStep,
    bool? isProcessing,
    String? error,
    Transaction? completedTransaction,
  }) {
    return SendMoneyState(
      selectedContact: selectedContact ?? this.selectedContact,
      amount: amount ?? this.amount,
      pin: pin ?? this.pin,
      currentStep: currentStep ?? this.currentStep,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error,
      completedTransaction: completedTransaction ?? this.completedTransaction,
    );
  }

  SendMoneyState clearError() {
    return SendMoneyState(
      selectedContact: selectedContact,
      amount: amount,
      pin: pin,
      currentStep: currentStep,
      isProcessing: isProcessing,
      error: null,
      completedTransaction: completedTransaction,
    );
  }
}

/// Send money flow steps
enum SendMoneyStep {
  selectContact,
  enterAmount,
  confirmPin,
  success,
}

/// Send money notifier
class SendMoneyNotifier extends Notifier<SendMoneyState> {
  @override
  SendMoneyState build() {
    return const SendMoneyState();
  }

  /// Select a contact for sending money
  void selectContact(Contact contact) {
    state = state.copyWith(
      selectedContact: contact,
      error: null,
    );
  }

  /// Set the amount to send
  void setAmount(double amount) {
    state = state.copyWith(
      amount: amount,
      error: null,
    );
  }

  /// Add a digit to the PIN
  void addPinDigit(String digit) {
    if (state.pin.length < 4) {
      state = state.copyWith(
        pin: state.pin + digit,
        error: null,
      );

      // Auto-submit when PIN is complete
      if (state.pin.length == 4) {
        _submitPin();
      }
    }
  }

  /// Remove last digit from PIN
  void removePinDigit() {
    if (state.pin.isNotEmpty) {
      state = state.copyWith(
        pin: state.pin.substring(0, state.pin.length - 1),
        error: null,
      );
    }
  }

  /// Clear PIN
  void clearPin() {
    state = state.copyWith(pin: '', error: null);
  }

  /// Move to next step
  void nextStep() {
    // Validate current step before moving forward
    if (!_validateCurrentStep()) {
      return;
    }

    final nextStep = switch (state.currentStep) {
      SendMoneyStep.selectContact => SendMoneyStep.enterAmount,
      SendMoneyStep.enterAmount => SendMoneyStep.confirmPin,
      SendMoneyStep.confirmPin => SendMoneyStep.success,
      SendMoneyStep.success => SendMoneyStep.success,
    };

    state = state.copyWith(
      currentStep: nextStep,
      error: null,
    );
  }

  /// Go back to previous step
  void previousStep() {
    final prevStep = switch (state.currentStep) {
      SendMoneyStep.selectContact => SendMoneyStep.selectContact,
      SendMoneyStep.enterAmount => SendMoneyStep.selectContact,
      SendMoneyStep.confirmPin => SendMoneyStep.enterAmount,
      SendMoneyStep.success => SendMoneyStep.success,
    };

    state = state.copyWith(
      currentStep: prevStep,
      error: null,
      pin: '', // Clear PIN when going back
    );
  }

  /// Validate current step
  bool _validateCurrentStep() {
    switch (state.currentStep) {
      case SendMoneyStep.selectContact:
        if (state.selectedContact == null) {
          state = state.copyWith(error: 'Please select a contact');
          return false;
        }
        return true;

      case SendMoneyStep.enterAmount:
        if (state.amount <= 0) {
          state = state.copyWith(error: 'Please enter an amount');
          return false;
        }
        if (state.amount > MockData.initialBalance) {
          state = state.copyWith(error: 'Insufficient balance');
          return false;
        }
        if (state.amount > 70000) {
          state = state.copyWith(
            error: 'Exceeds daily limit of KES 70,000',
          );
          return false;
        }
        if (state.amount < 10) {
          state = state.copyWith(error: 'Minimum amount is KES 10');
          return false;
        }
        return true;

      case SendMoneyStep.confirmPin:
      case SendMoneyStep.success:
        return true;
    }
  }

  /// Submit PIN and process transaction
  Future<void> _submitPin() async {
    if (state.pin.length != 4) {
      return;
    }

    state = state.copyWith(isProcessing: true, error: null);

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Validate PIN (in real app, this would check against stored PIN)
    // For demo purposes, any 4-digit PIN works
    if (state.pin.length == 4) {
      // Create transaction record
      final transactionId = 'TXN-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch % 10000}';
      final transaction = Transaction(
        id: transactionId,
        name: state.selectedContact!.name,
        amount: state.amount,
        type: TransactionType.sent,
        date: DateTime.now(),
        status: TransactionStatus.completed,
        note: 'Money transfer',
      );

      state = state.copyWith(
        isProcessing: false,
        completedTransaction: transaction,
        currentStep: SendMoneyStep.success,
      );
    } else {
      state = state.copyWith(
        isProcessing: false,
        error: 'Invalid PIN',
        pin: '',
      );
    }
  }

  /// Reset to initial state
  void reset() {
    state = const SendMoneyState();
  }

  /// Clear error message
  void clearError() {
    state = state.clearError();
  }
}

/// Provider for send money state
final sendMoneyProvider = NotifierProvider<SendMoneyNotifier, SendMoneyState>(
  SendMoneyNotifier.new,
);

/// Provider for contact search
final contactSearchProvider = StateProvider<String>((ref) => '');

/// Provider for filtered contacts based on search
final filteredContactsProvider = Provider<List<Contact>>((ref) {
  final searchQuery = ref.watch(contactSearchProvider).toLowerCase();

  if (searchQuery.isEmpty) {
    return MockData.contacts;
  }

  return MockData.contacts.where((contact) {
    return contact.name.toLowerCase().contains(searchQuery) ||
        contact.phoneNumber.contains(searchQuery);
  }).toList();
});
