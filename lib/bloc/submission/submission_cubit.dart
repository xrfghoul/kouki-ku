import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kokiku/model/submission.dart';
import 'package:kokiku/service/submission_service.dart';

part 'submission_state.dart';

class SubmissionCubit extends Cubit<SubmissionState> {
  SubmissionCubit(this._submissionApi) : super(SubmissionInitial());
  final SubmissionApi _submissionApi;

  void addSubmission(Submission submission) async {
    await _submissionApi.createSubmission(submission);
  }

  void updateSubmission(Submission submission) async {
    await _submissionApi.updateSubmission(submission);
  }
}
