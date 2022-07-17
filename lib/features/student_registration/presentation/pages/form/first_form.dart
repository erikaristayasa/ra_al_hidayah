import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/custom_text_field.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_button.dart';
import 'package:ra_al_hidayah/core/utilities/utilities.dart';

import '../../../../../core/shared/presentation/widgets/custom_drop_down.dart';
import '../../../../../core/shared/presentation/widgets/custom_search_bar.dart';
import '../../../../../core/statics/statics.dart';
import '../../cubit/student_registration_page_cubit.dart';

class FirstForm extends StatefulWidget {
  final bool isPlaygroup;
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
    required this.isPlaygroup,
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
  @override
  Widget build(BuildContext context) {
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
            Visibility(
              visible: isExtend ?? false,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: AppDimensions.medium),
                height: 40.0,
                child: CustomSearchBar(hint: 'Cari Siswa', onSubmit: (keyword) {}),
              ),
            ),
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
            outlineStyle: true,
            placeholder: 'Tanggal Lahir',
            controller: widget.birthDateController,
            inputType: TextInputType.datetime,
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
