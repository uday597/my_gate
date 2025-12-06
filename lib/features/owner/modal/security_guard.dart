class SecurityGuardModal {
  final int? id;
  final int societyId;
  final String name;
  final String phone;
  final String address;
  final String? profileImage;
  final String? createdAt;

  SecurityGuardModal({
    this.id,
    required this.societyId,
    required this.name,
    required this.phone,
    required this.address,
    this.profileImage,
    this.createdAt,
  });

  factory SecurityGuardModal.fromMap(Map<String, dynamic> map) {
    return SecurityGuardModal(
      id: map['id'],
      societyId: map['society_id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      profileImage: map['profile_image'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'society_id': societyId,
      'name': name,
      'phone': phone,
      'address': address,
      'profile_image': profileImage,
      'created_at': createdAt,
    };
  }
}
