import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/domain/entities/registration_period_entity.dart';
import '../../../../core/shared/presentation/blocs/student/student_list_bloc.dart';
import '../../../../core/shared/presentation/widgets/bottom_sheet_confirmation.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/page_description.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/student_registration_bloc.dart';
import '../cubit/student_extends_cubit.dart';
import '../cubit/student_registration_page_cubit.dart';
import '../widgets/student_registration_page_indicator.dart';
import 'form/first_form.dart';
import 'form/second_form.dart';
import 'form/third_form.dart';

class StudentRegistrationFormPageRouteArguments {
  final GradeType gradeType;
  final RegistrationPeriod period;

  StudentRegistrationFormPageRouteArguments({required this.period, required this.gradeType});
}

class StudentRegistrationFormPage extends StatefulWidget {
  final GradeType gradeType;
  final RegistrationPeriod period;
  const StudentRegistrationFormPage({Key? key, required this.period, required this.gradeType}) : super(key: key);

  @override
  State<StudentRegistrationFormPage> createState() => _StudentRegistrationFormPageState();
}

class _StudentRegistrationFormPageState extends State<StudentRegistrationFormPage> {
  final _studentListBloc = locator<StudentListBloc>();
  final _createBloc = locator<StudentRegistrationBloc>();
  final _pageCubit = StudentRegistrationPageCubit();
  final _studentExtendsCubit = StudentExtendsCubit();
  final _pageController = PageController();

  final ReceivePort _port = ReceivePort();

  Gender? _gender;
  final _studentIdController = TextEditingController();
  final _studentNameController = TextEditingController();
  final _birthPlaceController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _nikController = TextEditingController();
  final _religionController = TextEditingController();
  final _childNumberController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _parentJobController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  XFile? _birthDoc, _registerFormDoc, _availabilityDoc, _profPayment;

  bool checkIfControllerIsNotEmpty() {
    return _studentNameController.text.isNotEmpty ||
        _birthPlaceController.text.isNotEmpty ||
        _birthDateController.text.isNotEmpty ||
        _nikController.text.isNotEmpty ||
        _religionController.text.isNotEmpty ||
        _childNumberController.text.isNotEmpty ||
        _fatherNameController.text.isNotEmpty ||
        _motherNameController.text.isNotEmpty ||
        _parentJobController.text.isNotEmpty ||
        _addressController.text.isEmpty ||
        _phoneController.text.isNotEmpty;
  }

  backConfirmation() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BottomSheetConfirmation(
        title: 'Yakin Ingin Kembali?',
        message: 'Anda yakin akan kembali dan hapus semua form yang terisi?',
        onConfirm: () {
          if (checkIfControllerIsNotEmpty()) {
            _createBloc.add(Submit(
              registrationPeriodId: widget.period.id,
              studentId: _studentIdController.text.isNotEmpty ? int.parse(_studentIdController.text) : null,
              type: widget.gradeType.postValue,
              name: _studentNameController.text,
              gender: _gender?.text,
              birthPlace: _birthPlaceController.text,
              birthDate: _birthDateController.text,
              nik: _nikController.text,
              religion: _religionController.text,
              childNumber: _childNumberController.text,
              fatherName: _fatherNameController.text,
              motherName: _motherNameController.text,
              parentJob: _parentJobController.text,
              address: _addressController.text,
              phone: _phoneController.text,
              birthDocumentFile: _birthDoc,
              registrationFormFile: _registerFormDoc,
              availabilityFile: _availabilityDoc,
              profOfPaymentFile: _profPayment,
              isDraft: true,
            ));

            Fluttertoast.showToast(msg: 'Simpan sebagai Draft.');

            _createBloc.stream.listen((state) {
              AppHelpers.logMe(state);
              if (state is StudentRegistrationSuccess) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Berhasil'),
                    content: const Text('Draft Berhasil Disimpan'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, AppPaths.main);
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is StudentRegistrationFailure) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Gagal Menyimpan Draft'),
                    content: Text(AppHelpers.getErrorMessage(state.failure)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            });
          } else {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];

      AppHelpers.logMe('TaskId:$id Status:$status Progress:$progress');
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  void initState() {
    _bindBackgroundIsolate();
    super.initState();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _pageCubit,
        ),
        BlocProvider(
          create: (context) => _studentListBloc,
        ),
        BlocProvider(
          create: (context) => _createBloc,
        ),
        BlocProvider(
          create: (context) => _studentExtendsCubit,
          child: Container(),
        )
      ],
      child: WillPopScope(
        onWillPop: () async {
          backConfirmation();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'Form Pendaftaran Siswa',
            canBack: true,
            customBackAction: backConfirmation,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
              child: Column(
                children: [
                  BlocConsumer<StudentRegistrationPageCubit, int>(
                    listener: (context, state) {
                      _pageController.animateToPage(state, duration: const Duration(microseconds: 800), curve: Curves.easeIn);
                    },
                    builder: (context, state) {
                      final _desc = state == 0 ? 'Silahkan isi data diri yang sesuai.' : ' Silahkan upload file sesuai dengan ketentuan.';
                      return Column(
                        children: [
                          PageDescription(title: 'Data Diri Siswa ${widget.gradeType.text}', description: _desc),
                          StudentRegistrationPageIndicator(currentPage: state),
                        ],
                      );
                    },
                  ),
                  AppHelpers.smallVerticalSpacing(),
                  Expanded(
                    child: PageView(
                      onPageChanged: (page) {
                        _pageCubit.move(page);
                      },
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        FirstForm(
                          gradeType: widget.gradeType,
                          isPlaygroup: widget.gradeType == GradeType.playgroup,
                          studentIdController: _studentIdController,
                          studentNameController: _studentNameController,
                          birthPlaceController: _birthPlaceController,
                          birthDateController: _birthDateController,
                          nikController: _nikController,
                          religionController: _religionController,
                          childNumberController: _childNumberController,
                          fatherNameController: _fatherNameController,
                          motherNameController: _motherNameController,
                          parentJobController: _parentJobController,
                          addressController: _addressController,
                          phoneController: _phoneController,
                          onGenderSelected: (gender) => _gender = gender,
                        ),
                        SecondForm(
                          onAvailabilitySelected: (XFile? file) {
                            _availabilityDoc = file;
                          },
                          onBirthDocSelected: (XFile? file) {
                            _birthDoc = file;
                          },
                          onRegisterFormSelected: (XFile? file) {
                            _registerFormDoc = file;
                          },
                          registerFormDownloadUrl: widget.period.fileRegistrationForm,
                          availabilityDocDownloadUrl: widget.period.fileAvailability,
                        ),
                        ThirdForm(
                          nameController: _studentNameController,
                          addressController: _addressController,
                          onFileSelected: (XFile? file) {
                            _profPayment = file;
                          },
                          onSubmit: () async {
                            _createBloc.add(Submit(
                              registrationPeriodId: widget.period.id,
                              studentId: _studentIdController.text.isNotEmpty ? int.parse(_studentIdController.text) : null,
                              type: widget.gradeType.postValue,
                              name: _studentNameController.text,
                              gender: _gender?.text,
                              birthPlace: _birthPlaceController.text,
                              birthDate: _birthDateController.text,
                              nik: _nikController.text,
                              religion: _religionController.text,
                              childNumber: _childNumberController.text,
                              fatherName: _fatherNameController.text,
                              motherName: _motherNameController.text,
                              parentJob: _parentJobController.text,
                              address: _addressController.text,
                              phone: _phoneController.text,
                              birthDocumentFile: _birthDoc,
                              registrationFormFile: _registerFormDoc,
                              availabilityFile: _availabilityDoc,
                              profOfPaymentFile: _profPayment,
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                  AppHelpers.smallVerticalSpacing(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
