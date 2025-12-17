class VisitorModal {
  final int id;
  final String name;
  final String phone;
  final String purpose;
  final String flatNo;
  final String idProof;
  final String vehicleNo;
  final String status;
  final String relative;
  final int societyId;
  final int memberId;
  final int guardId;
  final String? image; // Optional
  final DateTime createdAt; // NEW

  VisitorModal({
    required this.id,
    required this.name,
    required this.phone,
    required this.purpose,
    required this.flatNo,
    required this.idProof,
    required this.vehicleNo,
    required this.status,
    required this.relative,
    required this.societyId,
    required this.memberId,
    required this.guardId,
    this.image,
    required this.createdAt,
  });

  VisitorModal copyWith({
    int? id,
    String? name,
    String? phone,
    String? purpose,
    String? flatNo,
    String? idProof,
    String? vehicleNo,
    String? status,
    String? relative,
    int? societyId,
    int? memberId,
    int? guardId,
    String? image,
    DateTime? createdAt, // NEW
  }) {
    return VisitorModal(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      purpose: purpose ?? this.purpose,
      flatNo: flatNo ?? this.flatNo,
      idProof: idProof ?? this.idProof,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      status: status ?? this.status,
      relative: relative ?? this.relative,
      societyId: societyId ?? this.societyId,
      memberId: memberId ?? this.memberId,
      guardId: guardId ?? this.guardId,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt, // NEW
    );
  }

  factory VisitorModal.fromMap(Map<String, dynamic> map) {
    return VisitorModal(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      purpose: map['purpose'] ?? '',
      flatNo: map['flat_no'] ?? '',
      idProof: map['id_proof'] ?? '',
      vehicleNo: map['vehicle_no'] ?? '',
      status: map['status'] ?? 'pending',
      relative: map['relative'] ?? '',
      societyId: map['society_id'] ?? 0,
      memberId: map['member_id'] ?? 0,
      guardId: map['guard_id'] ?? 0,
      image: map['image'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(), // Default if null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "purpose": purpose,
      "flat_no": flatNo,
      "id_proof": idProof,
      "vehicle_no": vehicleNo,
      "status": status,
      "relative": relative,
      "society_id": societyId,
      "member_id": memberId,
      "guard_id": guardId,
      "image": image,
      "created_at": createdAt.toIso8601String(), // NEW
    };
  }
}
