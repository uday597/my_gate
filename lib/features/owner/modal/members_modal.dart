class MembersModal {
  final int id;
  final int societyId;
  final String memberName;
  final String memberEmail;
  final String memberPhone;
  final String memberAddress;
  final String? memberImage;
  final String memberFlatNo;

  MembersModal({
    required this.id,
    required this.societyId,
    required this.memberEmail,
    required this.memberAddress,
    required this.memberFlatNo,
    this.memberImage,
    required this.memberName,
    required this.memberPhone,
  });
  factory MembersModal.fromMap(Map<String, dynamic> data) {
    return MembersModal(
      id: data['id'],
      societyId: data['society_id'],
      memberEmail: data['member_email'],
      memberAddress: data['member_address'],
      memberFlatNo: data['flat_no'],
      memberImage: data['profile_image'],
      memberName: data['member_name'],
      memberPhone: data['member_phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'society_id': societyId,
      'member_name': memberName,
      'member_email': memberEmail,
      'member_phone': memberPhone,
      'member_address': memberAddress,
      'flat_no': memberFlatNo,
      'profile_image': memberImage,
    };
  }
}
