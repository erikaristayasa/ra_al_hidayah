import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/shared/presentation/widgets/bottom_sheet_confirmation.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/page_description.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../../domain/entities/registration_period_entity.dart';
import '../bloc/student_registration_bloc.dart';
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
  final _createBloc = locator<StudentRegistrationBloc>();
  final _pageCubit = StudentRegistrationPageCubit();
  final _pageController = PageController();

  Gender? _gender;
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

  backConfirmation() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => BottomSheetConfirmation(
        title: 'Yakin Ingin Kembali?',
        message: 'Anda yakin akan kembali dan hapus semua form yang terisi?',
        onConfirm: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _pageCubit,
        ),
        BlocProvider(
          create: (context) => _createBloc,
        ),
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
                          isPlaygroup: widget.gradeType == GradeType.playgroup,
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
                        ),
                        ThirdForm(
                          onFileSelected: (XFile? file) {
                            _profPayment = file;
                          },
                          onSubmit: () async {
                            _createBloc.add(Submit(
                              registrationPeriodId: widget.period.id,
                              studentId: null,
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
