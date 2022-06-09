import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kokiku/model/submission.dart';
import 'package:kokiku/model/vacancy.dart';
import 'package:kokiku/model/vacancySubmission.dart';
import 'package:kokiku/service/submission_service.dart';
import 'package:kokiku/service/vacancy_service.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

part 'vacancy_state.dart';

class VacancyCubit extends Cubit<VacancyState> {
  VacancyCubit(this._vacancyApi, this._submissionApi)
      : super(VacancyInitial(
            vacancyList: [],
            ownedVacancyList: [],
            restaurantVacancySubmissionList: []));
  StreamSubscription? _vacancySubscription;
  StreamSubscription? _ownedVacancySubscription;
  StreamSubscription? _submissionSubsription;
  final VacancyApi _vacancyApi;
  final SubmissionApi _submissionApi;

  void createVacancy(Vacancy vacancy, {Uint8List? img}) async {
    try {
      emit(VacancyLoading(
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
      await _vacancyApi.createVacancy(vacancy, img);
      emit(VacancyCreateSuccess(
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
    } catch (e) {
      emit(VacancyCreateFailure(
          message: 'Create Failure : $e',
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
    }
  }

  void loadOwnVacancy(String ownerId) {
    try {
      emit(VacancyLoading(
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
      _ownedVacancySubscription?.cancel();
      _ownedVacancySubscription =
          _vacancyApi.loadVacancyByOwnerId(ownerId).listen((data) {
        emit(VacancyFetchSuccess(
            ownedVacancyList: data,
            vacancyList: state.vacancyList,
            restaurantVacancySubmissionList:
                state.restaurantVacancySubmissionList));
      });
    } catch (e) {
      emit(VacancyFetchFailure(
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
    }
  }

  void loadAllVacancy() {
    try {
      emit(VacancyLoading(
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
      _vacancySubscription?.cancel();
      _vacancySubscription = _vacancyApi.loadAllVacancy().listen((data) {
        emit(VacancyFetchSuccess(
            vacancyList: data,
            ownedVacancyList: state.ownedVacancyList,
            restaurantVacancySubmissionList:
                state.restaurantVacancySubmissionList));
      });
    } catch (e) {
      emit(VacancyFetchFailure(
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
    }
  }

  void loadVacancySubmission(String ownerId) {
    try {
      emit(VacancyLoading(
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
      _vacancySubscription ??=
          _vacancyApi.loadVacancyByOwnerId(ownerId).listen((data) {
        emit(VacancyFetchSuccess(
            vacancyList: data,
            ownedVacancyList: state.ownedVacancyList,
            restaurantVacancySubmissionList:
                state.restaurantVacancySubmissionList));
      });

      _submissionSubsription =
          _submissionApi.loadSubmissionByRestaurantId(ownerId).listen((data) {
        List<VacancySubmission> out = state.ownedVacancyList
            .map((e) => VacancySubmission(vacancy: e, submissionList: []))
            .toList();
        for (Submission e in data) {
          final vac = out.firstWhereOrNull(
              (element) => element.vacancy.id == e.vacancy.id);
          if (vac != null) vac.submissionList.add(e);
        }
        emit(VacancyFetchSuccess(
            vacancyList: state.vacancyList,
            ownedVacancyList: state.ownedVacancyList,
            restaurantVacancySubmissionList: out));
      });
    } catch (e) {
      emit(VacancyFetchFailure(
          vacancyList: state.vacancyList,
          ownedVacancyList: state.ownedVacancyList,
          restaurantVacancySubmissionList:
              state.restaurantVacancySubmissionList));
    }
  }
}
