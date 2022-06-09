import 'dart:convert';

import 'package:kokiku/model/user.dart';
import 'package:kokiku/model/vacancy.dart';

class Submission {
  static const rejectStatus = 'Reject';
  static const approvedStatus = 'Approve';
  static const submittedStatus = 'Submitted';

  final String id;
  final User user;
  final Vacancy vacancy;
  final DateTime createdAt;
  final DateTime? approvedAt;
  final DateTime? rejectedAt;
  final String status;
  Submission({
    required this.id,
    required this.user,
    required this.vacancy,
    required this.createdAt,
    this.approvedAt,
    this.rejectedAt,
    required this.status,
  });

  Submission copyWith({
    String? id,
    User? user,
    Vacancy? vacancy,
    DateTime? createdAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
    String? status,
  }) {
    return Submission(
      id: id ?? this.id,
      user: user ?? this.user,
      vacancy: vacancy ?? this.vacancy,
      createdAt: createdAt ?? this.createdAt,
      approvedAt: approvedAt ?? this.approvedAt,
      rejectedAt: rejectedAt ?? this.rejectedAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'vacancy': vacancy.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'approvedAt': approvedAt?.millisecondsSinceEpoch,
      'rejectedAt': rejectedAt?.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory Submission.fromMap(Map<String, dynamic> map) {
    return Submission(
      id: map['id'] ?? '',
      user: User.fromMap(map['user']),
      vacancy: Vacancy.fromMap(map['vacancy']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      approvedAt: map['approvedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['approvedAt'])
          : null,
      rejectedAt: map['rejectedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['rejectedAt'])
          : null,
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Submission.fromJson(String source) =>
      Submission.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Submission(id: $id, user: $user, vacancy: $vacancy, createdAt: $createdAt, approvedAt: $approvedAt, rejectedAt: $rejectedAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Submission &&
        other.id == id &&
        other.user == user &&
        other.vacancy == vacancy &&
        other.createdAt == createdAt &&
        other.approvedAt == approvedAt &&
        other.rejectedAt == rejectedAt &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        vacancy.hashCode ^
        createdAt.hashCode ^
        approvedAt.hashCode ^
        rejectedAt.hashCode ^
        status.hashCode;
  }
}
