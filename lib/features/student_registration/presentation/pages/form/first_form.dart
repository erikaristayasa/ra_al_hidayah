import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/shared/domain/entities/student_entity.dart';
import '../../../../../core/shared/presentation/blocs/student/student_list_bloc.dart';
import '../../../../../core/shared/presentation/pages/loading_page.dart';
import '../../../../../core/shared/presentation/widgets/custom_drop_down.dart';
import '../../../../../core/shared/presentation/widgets/custom_search_bar.dart';
import '../../../../../core/shared/presentation/widgets/custom_text_field.dart';
import '../../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../../core/statics/statics.dart';
import '../../../../../core/utilities/utilities.dart';
import '../../cubit/student_extends_cubit.dart';
import '../../cubit/student_registration_page_cubit.dart';

class FirstForm extends StatefulWidget {
  final bool isPlaygroup;
  final GradeType gradeType;
  final TextEditingController studentIdController;
  final TextEditingController studentNameController;
  final TextEditingController birthPlaceController;
  final TextEditingController birthDateController;
  final TextEditingController nikController;
  final TextEditingController religionController;
  final TextEditingController childNumberController;
  final TextEditingController fatherNameController;
  final TextEditingController motherNameController;
  final TextEditingController parentJobController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final Function(Gender gender) onGenderSelected;
  const FirstForm({
    Key? key,
    required this.gradeType,
    required this.isPlaygroup,
    required this.studentIdController,
    required this.studentNameController,
    required this.birthPlaceController,
    required this.birthDateController,
    required this.nikController,
    required this.religionController,
    required this.childNumberController,
    required this.fatherNameController,
    required this.motherNameController,
    required this.parentJobController,
    required this.addressController,
    required this.phoneController,
    required this.onGenderSelected,
  }) : super(key: key);

  @override
  State<FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> with AutomaticKeepAliveClientMixin {
  bool? isExtend;
  late GradeType targetGrade;

  @override
  void initState() {
    switch (widget.gradeType) {
      case GradeType.tkA:
        targetGrade = GradeType.tkB;
        break;
      case GradeType.playgroup:
      case GradeType.tkB:
        targetGrade = GradeType.playgroup;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppHelpers.logMe('rebuild');
    if (widget.isPlaygroup) {
      return ListView(
        shrinkWrap: true,
        children: [
          FormField(
            studentNameController: widget.studentNameController,
            birthPlaceController: widget.birthPlaceController,
            birthDateController: widget.birthDateController,
            nikController: widget.nikController,
            religionController: widget.religionController,
            childNumberController: widget.childNumberController,
            fatherNameController: widget.fatherNameController,
            motherNameController: widget.motherNameController,
            parentJobController: widget.parentJobController,
            addressController: widget.addressController,
            phoneController: widget.phoneController,
            onGenderSelected: widget.onGenderSelected,
          ),
        ],
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          children: [
            CustomDropDown(
              outlineStyle: true,
              hint: 'Siswa Lanjutan?',
              items: ['Iya', 'Tidak'],
              onChanged: (value) {
                if (value == 'Iya') {
                  setState(() {
                    isExtend = true;
                  });
                } else {
                  setState(() {
                    isExtend = false;
                  });
                }
              },
            ),
            (isExtend ?? false)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BlocBuilder<StudentListBloc, StudentListState>(
                        builder: (context, state) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: AppDimensions.medium),
                            height: 40.0,
                            child: CustomSearchBar(
                              hint: 'Cari Siswa',
                              onSubmit: (keyword) {
                                // context.read<StudentListBloc>().add(FetchStudents(status: PaymentStatus.accept, name: keyword, type: targetGrade));
                                context.read<StudentListBloc>().add(FetchStudents(status: null, name: keyword, type: null));
                              },
                            ),
                          );
                        },
                      ),
                      BlocConsumer<StudentListBloc, StudentListState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is StudentListLoading) {
                            return const LoadingPage(isList: true);
                          } else if (state is StudentListLoaded) {
                            final _data = state.data;

                            return BlocConsumer<StudentExtendsCubit, Student?>(
                              listener: (context, state) {
                                if (state != null) {
                                  widget.studentIdController.text = state.id.toString();
                                  widget.studentNameController.text = state.name;
                                  widget.birthPlaceController.text = state.birthPlace;
                                  widget.birthDateController.text = state.birthDate.toText(format: 'yyyy-MM-dd');
                                  widget.nikController.text = state.nik;
                                  widget.religionController.text = state.religion;
                                  widget.childNumberController.text = state.childNumber;
                                  widget.fatherNameController.text = state.fatherName;
                                  widget.motherNameController.text = state.motherName;
                                  widget.parentJobController.text = state.parentJob;
                                  widget.addressController.text = state.address;
                                  widget.phoneController.text = state.phone;
                                  widget.onGenderSelected(state.gender);
                                } else {
                                  widget.studentIdController.text = '';
                                  widget.studentNameController.text = '';
                                  widget.birthPlaceController.text = '';
                                  widget.birthDateController.text = '';
                                  widget.nikController.text = '';
                                  widget.religionController.text = '';
                                  widget.childNumberController.text = '';
                                  widget.fatherNameController.text = '';
                                  widget.motherNameController.text = '';
                                  widget.parentJobController.text = '';
                                  widget.addressController.text = '';
                                  widget.phoneController.text = '';
                                  
                                }
                              },
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    ListView.separated(
                                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                      shrinkWrap: true,
                                      itemCount: _data.length,
                                      separatorBuilder: (_, __) => AppHelpers.mediumVerticalSpacing(),
                                      itemBuilder: (context, index) {
                                        final _student = _data[index];
                                        final _selected = _student == state;
                                        return InkWell(
                                          onTap: () {
                                            context.read<StudentExtendsCubit>().onSelected(_student);
                                          },
                                          child: RoundedContainer(
                                            shadow: true,
                                            shadowBlurRadius: 8,
                                            shadowSpreadRadius: 4,
                                            shadowOffset: const Offset(0, 4),
                                            shadowColor: Colors.grey.withOpacity(0.10),
                                            color: _selected ? AppColors.primary : Colors.white,
                                            child: Text(
                                              _student.name,
                                              style: TextStyle(
                                                color: _selected ? Colors.white : Colors.black,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    state != null
                                        ? RoundedButton(
                                            title: 'Selanjutnya',
                                            onTap: () {
                                              context.read<StudentRegistrationPageCubit>().move(1);
                                            })
                                        : const SizedBox.shrink(),
                                  ],
                                );
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            isExtend != null
                ? Visibility(
                    visible: !isExtend!,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium),
                      child: FormField(
                        studentNameController: widget.studentNameController,
                        birthPlaceController: widget.birthPlaceController,
                        birthDateController: widget.birthDateController,
                        nikController: widget.nikController,
                        religionController: widget.religionController,
                        childNumberController: widget.childNumberController,
                        fatherNameController: widget.fatherNameController,
                        motherNameController: widget.motherNameController,
                        parentJobController: widget.parentJobController,
                        addressController: widget.addressController,
                        phoneController: widget.phoneController,
                        onGenderSelected: widget.onGenderSelected,
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class FormField extends StatefulWidget {
  final TextEditingController studentNameController;
  final TextEditingController birthPlaceController;
  final TextEditingController birthDateController;
  final TextEditingController nikController;
  final TextEditingController religionController;
  final TextEditingController childNumberController;
  final TextEditingController fatherNameController;
  final TextEditingController motherNameController;
  final TextEditingController parentJobController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final Function(Gender gender) onGenderSelected;
  const FormField({
    Key? key,
    required this.studentNameController,
    required this.birthPlaceController,
    required this.birthDateController,
    required this.nikController,
    required this.religionController,
    required this.childNumberController,
    required this.fatherNameController,
    required this.motherNameController,
    required this.parentJobController,
    required this.addressController,
    required this.phoneController,
    required this.onGenderSelected,
  }) : super(key: key);

  @override
  State<FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormField> {
  final _formKey = GlobalKey<FormState>();
  Gender? _gender;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Nama Lengkap Siswa',
            controller: widget.studentNameController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomDropDown(
              outlineStyle: true,
              hint: 'Jenis Kelamin',
              items: Gender.values.map((e) => e.text).toList(),
              onChanged: (value) {
                _gender = (value as String).gender;
                widget.onGenderSelected(_gender!);
              }),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Tempat Lahir',
            controller: widget.birthPlaceController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            enabled: false,
            outlineStyle: true,
            placeholder: 'Tanggal Lahir',
            controller: widget.birthDateController,
            inputType: TextInputType.datetime,
            isDatePicker: true,
            bottomDescription: 'Contoh Penulisan: 2022-12-31',
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'NIK',
            controller: widget.nikController,
            inputType: TextInputType.number,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomDropDown(
            outlineStyle: true,
            hint: 'Agama',
            items: ["Islam", "Protestan", "Katolik", "Hindu", "Buddha", "Khonghucu"],
            onChanged: (value) {
              widget.religionController.text = value;
            },
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Anak ke-',
            controller: widget.childNumberController,
            inputType: TextInputType.number,
            bottomDescription: 'Contoh Penulisan: 1',
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Nama Ayah',
            controller: widget.fatherNameController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Nama Ibu',
            controller: widget.motherNameController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Pekerjaan Ayah/Ibu',
            controller: widget.parentJobController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Alamat',
            maxlines: 5,
            controller: widget.addressController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Nomor Telepon WA',
            controller: widget.phoneController,
            prefixText: '+62',
            inputType: TextInputType.phone,
            typeField: TypeField.phone,
          ),
          AppHelpers.smallVerticalSpacing(),
          RoundedButton(
              title: 'Selanjutnya',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  if (_gender == null) {
                    Fluttertoast.showToast(msg: 'Jenis kelamin belum dipilih');
                  } else {
                    context.read<StudentRegistrationPageCubit>().move(1);
                  }
                }
              })
        ],
      ),
    );
  }
}
