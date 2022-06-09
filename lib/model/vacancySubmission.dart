import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:kokiku/model/submission.dart';
import 'package:kokiku/model/vacancy.dart';

class VacancySubmission {
  final Vacancy vacancy;
  final List<Submission> submissionList;
  VacancySubmission({
    required this.vacancy,
    required this.submissionList,
  });

  VacancySubmission copyWith({
    Vacancy? vacancy,
    List<Submission>? submissionList,
  }) {
    return VacancySubmission(
      vacancy: vacancy ?? this.vacancy,
      submissionList: submissionList ?? this.submissionList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vacancy': vacancy.toMap(),
      'submissionList': submissionList.map((x) => x.toMap()).toList(),
    };
  }

  factory VacancySubmission.fromMap(Map<String, dynamic> map) {
    return VacancySubmission(
      vacancy: Vacancy.fromMap(map['vacancy']),
      submissionList: List<Submission>.from(
          map['submissionList']?.map((x) => Submission.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory VacancySubmission.fromJson(String source) =>
      VacancySubmission.fromMap(json.decode(source));

  @override
  String toString() =>
      'VacancySubmission(vacancy: $vacancy, submissionList: $submissionList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VacancySubmission &&
        other.vacancy == vacancy &&
        listEquals(other.submissionList, submissionList);
  }

  @override
  int get hashCode => vacancy.hashCode ^ submissionList.hashCode;
}
