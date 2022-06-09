import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kokiku/bloc/authentication/authentication_cubit.dart';
import 'package:kokiku/bloc/vacancy/vacancy_cubit.dart';
import 'package:kokiku/model/user.dart';
import 'package:kokiku/model/vacancy.dart';
import 'package:kokiku/screen/auth/auth.dart';
import 'package:kokiku/screen/vacancy/vacancy.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/constants.dart';

part 'home_screen.dart';
part 'widgets/home_widget.dart';
part 'widgets/profile_widget.dart';
// part 'widgets/profile_widget.dart';
part 'widgets/search_widget.dart';
part 'widgets/contact_widget.dart';
