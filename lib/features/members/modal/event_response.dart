class EventResponseModal {
  final int id;
  final int eventId;
  final int memberId; // who responded
  final String type; // 'like' or 'comment'
  final String? comment;
  final DateTime createdAt;

  EventResponseModal({
    required this.id,
    required this.eventId,
    required this.memberId,
    required this.type,
    this.comment,
    required this.createdAt,
  });

  factory EventResponseModal.fromMap(Map<String, dynamic> map) {
    return EventResponseModal(
      id: map['id'] ?? 0,
      eventId: map['event_id'] ?? 0,
      memberId: map['member_id'] ?? 0,
      type: map['type'] ?? 'like',
      comment: map['comment'],
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'event_id': eventId,
      'member_id': memberId,
      'type': type,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
