class EventsModal {
  final int id;
  final String title;
  final String description;
  final String? image;
  final int societyId;
  final int memberId; // who posted
  final String visibility; // 'public' or 'selective'
  final String?
  visibleTo; // comma-separated member IDs for selective visibility
  final DateTime createdAt;
  final DateTime updatedAt;

  EventsModal({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.societyId,
    required this.memberId,
    required this.visibility,
    this.visibleTo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventsModal.fromMap(Map<String, dynamic> map) {
    return EventsModal(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'],
      societyId: map['society_id'] ?? 0,
      memberId: map['member_id'] ?? 0,
      visibility: map['visibility'] ?? 'public',
      visibleTo: map['visible_to'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'society_id': societyId,
      'member_id': memberId,
      'visibility': visibility,
      'visible_to': visibleTo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
