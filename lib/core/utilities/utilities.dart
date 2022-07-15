import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/change_password/presentation/bloc/change_password_bloc.dart';
import '../../features/forgot_password/presentation/bloc/forgot_password_bloc.dart';
import '../../features/login/data/datasources/login_data_source.dart';
import '../../features/login/data/repositories/login_repository_implementation.dart';
import '../../features/login/domain/entities/login_entity.dart';
import '../../features/login/domain/repositories/login_repository.dart';
import '../../features/login/domain/usecases/do_login.dart';
import '../../features/login/presentation/bloc/login_bloc.dart';
import '../../features/otp/presentation/bloc/otp_bloc.dart';
import '../../features/registration/presentation/bloc/registration_bloc.dart';
import '../errors/failure.dart';
import '../networks/networks.dart';
import '../shared/domain/entities/user_entity.dart';
import '../statics/statics.dart';

part 'helpers.dart';
part 'locator.dart';
part 'shared_preferences_helper.dart';
part 'validation_helper.dart';
