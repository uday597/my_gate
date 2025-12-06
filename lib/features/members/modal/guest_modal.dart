class GuestRequest {
  final int id;
  final int societyId;
  final int memberId;
  final String guestName;
  final String guestPhone;
  final String? guestAddress;
  final String? guestImage;
  final String? qrCode;

  final DateTime createdAt;
  final DateTime? guardViewedAt;
  final DateTime? guardActionAt;
  final String status;

  GuestRequest({
    required this.id,
    required this.societyId,
    required this.memberId,
    required this.guestName,
    required this.guestPhone,
    this.guestAddress,
    this.guestImage,
    this.qrCode,
    required this.createdAt,
    this.guardViewedAt,
    this.guardActionAt,
    required this.status,
  });

  factory GuestRequest.fromMap(Map<String, dynamic> map) {
    return GuestRequest(
      id: map['id'],
      societyId: map['society_id'],
      memberId: map['member_id'],
      guestName: map['guest_name'],
      guestPhone: map['guest_phone'],
      guestAddress: map['guest_address'],
      guestImage: map['guest_image'],
      qrCode: map['qr_code'],
      createdAt: DateTime.parse(map['created_at']),
      guardViewedAt: map['guard_viewed_at'] != null
          ? DateTime.parse(map['guard_viewed_at'])
          : null,
      guardActionAt: map['guard_action_at'] != null
          ? DateTime.parse(map['guard_action_at'])
          : null,
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'society_id': societyId,
      'member_id': memberId,
      'guest_name': guestName,
      'guest_phone': guestPhone,
      'guest_address': guestAddress,
      'guest_image': guestImage,
      'status': status,
      'qr_code': qrCode,
      'created_at': createdAt.toIso8601String(),
      'guard_viewed_at': guardViewedAt?.toIso8601String(),
      'guard_action_at': guardActionAt?.toIso8601String(),
    };
  }
}
