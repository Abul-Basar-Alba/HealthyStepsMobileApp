class Challenge {
  String? id;
  String? title; // চ্যালেঞ্জের নাম
  int? goalSteps; // লক্ষ্য স্টেপ
  DateTime? startDate;
  DateTime? endDate;
  List<String>? participants; // অংশগ্রহণকারীদের আইডি
  String? createdBy; // চ্যালেঞ্জ তৈরি করেছেন

  Challenge({
    this.id,
    this.title,
    this.goalSteps,
    this.startDate,
    this.endDate,
    this.participants,
    this.createdBy,
  });

  factory Challenge.fromMap(Map<String, dynamic> data, String documentId) {
    return Challenge(
      id: documentId,
      title: data['title'],
      goalSteps: data['goal_steps'],
      startDate: data['start_date']?.toDate(),
      endDate: data['end_date']?.toDate(),
      participants: List<String>.from(data['participants'] ?? []),
      createdBy: data['created_by'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'goal_steps': goalSteps,
      'start_date': startDate,
      'end_date': endDate,
      'participants': participants ?? [],
      'created_by': createdBy,
    };
  }
}