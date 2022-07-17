import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/shared/presentation/widgets/custom_photo_field.dart';
import '../../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../../core/statics/statics.dart';
import '../../../../../core/utilities/utilities.dart';
import '../../cubit/student_registration_page_cubit.dart';

class SecondForm extends StatefulWidget {
  const SecondForm({Key? key}) : super(key: key);

  @override
  State<SecondForm> createState() => _SecondFormState();
}

class _SecondFormState extends State<SecondForm> with AutomaticKeepAliveClientMixin {
  XFile? _birthDoc, _registerFormDoc, _availabilityDoc;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppHelpers.mediumVerticalSpacing(),
            const LabelInfo(title: 'Upload Akte Kelahiran'),
            CustomPhotoField(
                outlineStyle: true,
                bottomDescription: 'Format file: jpg/jpeg/pdf',
                onPicked: (file) {
                  _birthDoc = file;
                }),
            AppHelpers.mediumVerticalSpacing(),
            LabelInfo(
              title: 'Upload Berkas Form Pendaftaran',
              downloadUrl: "",
              onDownload: () {},
            ),
            CustomPhotoField(
                outlineStyle: true,
                bottomDescription: 'Format file: jpg/jpeg/pdf',
                onPicked: (file) {
                  _registerFormDoc = file;
                }),
            AppHelpers.mediumVerticalSpacing(),
            LabelInfo(
              title: 'Upload Berkas Lembar Kesediaan',
              downloadUrl: "",
              onDownload: () {},
            ),
            CustomPhotoField(
                outlineStyle: true,
                bottomDescription: 'Format file: jpg/jpeg/pdf',
                onPicked: (file) {
                  _availabilityDoc = file;
                }),
            AppHelpers.mediumVerticalSpacing(),
            RoundedButton(
              title: 'Selanjutnya',
              onTap: () {
                if (_birthDoc == null) {
                  Fluttertoast.showToast(msg: 'Akte Kelahiran belum dipilih');
                  return;
                }
                if (_registerFormDoc == null) {
                  Fluttertoast.showToast(msg: 'Berkas Form Pendaftaran belum dipilih');
                  return;
                }
                if (_availabilityDoc == null) {
                  Fluttertoast.showToast(msg: 'Berkas Lembar Kesediaan belum dipilih');
                  return;
                }
                context.read<StudentRegistrationPageCubit>().move(2);
              },
            ),
            AppHelpers.smallVerticalSpacing(),
            RoundedButton(
              outline: true,
              title: 'Kembali',
              titleColor: AppColors.primary,
              onTap: () {
                context.read<StudentRegistrationPageCubit>().move(0);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LabelInfo extends StatelessWidget {
  final String title;
  final String? downloadUrl;
  final VoidCallback? onDownload;
  const LabelInfo({Key? key, required this.title, this.downloadUrl, this.onDownload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0),
        ),
        downloadUrl != null
            ? TextButton(
                onPressed: onDownload,
                child: const Text(
                  'Download',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
