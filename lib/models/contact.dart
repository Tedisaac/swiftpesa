/// Contact data model
/// Represents a contact in the user's SwiftPesa contact list
class Contact {
  const Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.avatarInitials,
  });

  /// Unique contact identifier
  final String id;

  /// Contact's full name
  final String name;

  /// Contact's phone number in international format (+254XXXXXXXXX)
  final String phoneNumber;

  /// Optional custom avatar initials (computed if not provided)
  final String? avatarInitials;

  /// Get initials from contact name
  String get initials {
    if (avatarInitials != null) {
      return avatarInitials!;
    }

    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return name.length >= 2
        ? name.substring(0, 2).toUpperCase()
        : name[0].toUpperCase();
  }

  /// Create a copy with modified fields
  Contact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? avatarInitials,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarInitials: avatarInitials ?? this.avatarInitials,
    );
  }
}