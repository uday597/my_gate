class SocietyModal {
  final int id;
  final String societyName;
  final String societyPassword;
  final String ownerName;
  final String ownerPhone;
  final String ownerEmail;
  final String societyAddress;
  final String pincode;
  final String city;
  final String state;
  final String total_towers;
  final String total_flats;

  SocietyModal({
    required this.id,
    required this.societyName,
    required this.societyPassword,
    required this.ownerName,
    required this.ownerPhone,
    required this.ownerEmail,
    required this.societyAddress,
    required this.pincode,
    required this.city,
    required this.state,
    required this.total_flats,
    required this.total_towers,
  });

  // From Supabase map
  factory SocietyModal.fromMap(Map<String, dynamic> data) {
    return SocietyModal(
      id: data['id'],
      pincode: data['pincode'],
      city: data['city'],
      state: data['state'],
      total_flats: data['total_flat'],
      total_towers: data['total_towers'],
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
      'pincode': pincode,
      'city': city,
      'state': state,
      'total_flat': total_flats,
      'total_towers': total_towers,
      'society_name': societyName,
      'society_password': societyPassword,
      'owner_name': ownerName,
      'owner_phone': ownerPhone,
      'owner_email': ownerEmail,
      'society_address': societyAddress,
    };
  }
}
