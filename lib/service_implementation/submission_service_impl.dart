import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:kokiku/model/submission.dart';
import 'package:kokiku/model/user.dart';
import 'package:kokiku/model/vacancy.dart';
import 'package:kokiku/service/authentication_service.dart';
import 'package:kokiku/service/submission_service.dart';
import 'package:kokiku/service/vacancy_service.dart';

import '../utils/storage_utils.dart';

class SubmissionServiceImpl extends SubmissionApi {
  final submissionCollection =
      FirebaseFirestore.instance.collection('submission');
  final vacancyCollection = FirebaseFirestore.instance.collection('vacancy');

  @override
  Future<Submission?> createSubmission(Submission submission) async {
    final docRef = submissionCollection.doc();
    final id = docRef.id;
    submission = submission.copyWith(id: id);
    await docRef.set(submission.toMap());
    return submission;
  }

  @override
  Future<bool> updateSubmission(Submission submission) async {
    final docRef = submissionCollection.doc(submission.id);
    await docRef.update(submission.toMap());
    return true;
  }

  @override
  Stream<List<Submission>> loadSubmission(String vacancyId) {
    final snap = submissionCollection
        .where('vacancy.id', isEqualTo: vacancyId)
        .snapshots();
    return snap.map((e) {
      if (e.docs.isEmpty) {
        return [];
      }
      return e.docs.map((x) => Submission.fromMap(x.data())).toList();
    });
  }

  @override
  Stream<List<Submission>> loadSubmissionByRestaurantId(String ownerId) {
    final snap = submissionCollection
        .where('vacancy.ownerId', isEqualTo: ownerId)
        .snapshots();
    return snap.map((e) {
      if (e.docs.isEmpty) {
        return [];
      }
      return e.docs.map((x) => Submission.fromMap(x.data())).toList();
    });
  }
}
