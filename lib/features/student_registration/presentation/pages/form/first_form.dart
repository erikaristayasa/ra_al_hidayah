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
  const FirstForm({Key? key, required this.isPlaygroup}) : super(key: key);

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
        children: const [
          FormField(),
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
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppDimensions.medium),
                      child: FormField(),
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
  const FormField({Key? key}) : super(key: key);

  @override
  State<FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormField> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  Gender? _gender;
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Nama Lengkap Siswa',
            controller: _studentNameController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomDropDown(
              outlineStyle: true,
              hint: 'Jenis Kelamin',
              items: Gender.values.map((e) => e.text).toList(),
              onChanged: (value) {
                _gender = (value as String).gender;
              }),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Tempat Lahir',
            controller: _birthPlaceController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Tanggal Lahir',
            controller: _birthDateController,
            inputType: TextInputType.datetime,
            bottomDescription: 'Contoh Penulisan: 2022-12-31',
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'NIK',
            controller: _nikController,
            inputType: TextInputType.number,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomDropDown(
            outlineStyle: true,
            hint: 'Agama',
            items: ["Islam", "Protestan", "Katolik", "Hindu", "Buddha", "Khonghucu"],
            onChanged: (value) {
              _religionController.text = value;
            },
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Anak ke-',
            controller: _childNumberController,
            inputType: TextInputType.number,
            bottomDescription: 'Contoh Penulisan: 1',
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Nama Ayah',
            controller: _fatherNameController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Nama Ibu',
            controller: _motherNameController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Pekerjaan Ayah/Ibu',
            controller: _parentJobController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Alamat',
            maxlines: 5,
            controller: _addressController,
          ),
          AppHelpers.smallVerticalSpacing(),
          CustomTextField(
            outlineStyle: true,
            placeholder: 'Nomor Telepon WA',
            controller: _phoneController,
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
