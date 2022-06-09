import 'dart:typed_data';

import 'package:kokiku/model/submission.dart';

abstract class SubmissionApi {
  Future<Submission?> createSubmission(Submission submission);
  Stream<List<Submission>> loadSubmission(String vacancyId);
  Stream<List<Submission>> loadSubmissionByRestaurantId(
      String restaurantOwnerId);
  Future<bool> updateSubmission(Submission submission);
}
