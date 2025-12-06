class SocietyModal {
  final int id;
  final String societyName;
  final String societyPassword;
  final String ownerName;
  final String ownerPhone;
  final String ownerEmail;
  final String societyAddress;

  SocietyModal({
    required this.id,
    required this.societyName,
    required this.societyPassword,
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerEmail,
    required this.societyAddress,
  });

  // From Supabase map
  factory SocietyModal.fromMap(Map<String, dynamic> data) {
    return SocietyModal(
      id: data['id'],
      societyName: data['society_name'],
      societyPassword: data['society_password'],
      ownerName: data['owner_name'],
      ownerPhone: data['owner_phone'],
      ownerEmail: data['owner_email'],
      societyAddress: data['society_address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'society_name': societyName,
      'society_password': societyPassword,
      'owner_name': ownerName,
      'owner_phone': ownerPhone,
      'owner_email': ownerEmail,
      'society_address': societyAddress,
    };
  }
}
