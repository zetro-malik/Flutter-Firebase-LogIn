class Attendance {
  final String ID;
  late final String status;
  final String studentName;
  final String studentId;
  final String date;

  Attendance({
    required this.ID,
    required this.status,
    required this.studentName,
    required this.studentId,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'status': status,
      'studentName': studentName,
      'studentId': studentId,
      'date': date,
    };
  }

  static Attendance fromMap(Map<String, dynamic> map) {
    return Attendance(
      ID: map['ID'],
      status: map['status'],
      studentName: map['studentName'],
      studentId: map['studentId'],
      date: map['date'],
    );
  }
}
