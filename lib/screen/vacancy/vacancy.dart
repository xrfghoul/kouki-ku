import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kokiku/bloc/authentication/authentication_cubit.dart';
import 'package:kokiku/bloc/submission/submission_cubit.dart';
import 'package:kokiku/bloc/vacancy/vacancy_cubit.dart';
import 'package:kokiku/model/submission.dart';
import 'package:kokiku/model/user.dart';
import 'package:kokiku/model/vacancy.dart';
import 'package:kokiku/model/vacancySubmission.dart';
import 'package:kokiku/screen/auth/auth.dart';
import 'package:kokiku/utils/format_utils.dart';
import 'package:kokiku/widgets/custom_expansion_tile.dart';
import 'package:kokiku/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

part 'create_vacancy_screen.dart';
part 'vacancy_detail_screen.dart';
part 'vacancy_submission_screen.dart';
