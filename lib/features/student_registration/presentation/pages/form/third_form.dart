import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/button_loading.dart';
import 'package:ra_al_hidayah/core/shared/presentation/widgets/rounded_container.dart';
import 'package:ra_al_hidayah/features/student_registration/presentation/pages/form/second_form.dart';

import '../../../../../core/shared/presentation/widgets/custom_photo_field.dart';
import '../../../../../core/shared/presentation/widgets/notification_label.dart';
import '../../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../../core/statics/statics.dart';
import '../../../../../core/utilities/utilities.dart';
import '../../bloc/student_registration_bloc.dart';
import '../../cubit/student_registration_page_cubit.dart';

class ThirdForm extends StatefulWidget {
  final Function(XFile? file) onFileSelected;
  final VoidCallback onSubmit;
  const ThirdForm({Key? key, required this.onFileSelected, required this.onSubmit}) : super(key: key);

  @override
  State<ThirdForm> createState() => _ThirdFormState();
}

class _ThirdFormState extends State<ThirdForm> with AutomaticKeepAliveClientMixin {
  XFile? _profPayment;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHelpers.mediumVerticalSpacing(),
            const LabelInfo(title: 'Upload Bukti Bayar Pendaftaran'),
            CustomPhotoField(
                outlineStyle: true,
                bottomDescription: 'Format file: jpg/jpeg/pdf',
                onPicked: (file) {
                  _profPayment = file;
                  widget.onFileSelected(file);
                }),
            AppHelpers.mediumVerticalSpacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Informasi Pembayaran',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Lihat Rincian Pembayaran',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10.0),
                  ),
                ),
              ],
            ),
            const Text(
              'Silahkan lihat informasi pembayaran RA Al Hidayah Logam.',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10.0),
            ),
            AppHelpers.mediumVerticalSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
              child: RoundedContainer(
                padding: const EdgeInsets.all(AppDimensions.medium),
                color: const Color(0xFFE8FFFC),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'INVOICE UNTUK',
                            style: TextStyle(
                              fontSize: 8.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          FutureBuilder<String>(
                            future: AppHelpers.getUserNameFromSession(),
                            builder: (context, snap) => Text(
                              snap.data ?? '',
                              style: const TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          FutureBuilder<String>(
                            future: AppHelpers.getUserAddressFromSession(),
                            builder: (context, snap) => Text(
                              snap.data ?? '',
                              style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.w500, color: AppColors.textGrey),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'HARUS DIBAYAR',
                            style: TextStyle(
                              fontSize: 8.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          const Text(
                            'Rp100.000',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                DateTime.now().toText(format: 'dd MMMM yyyy'),
                                style: const TextStyle(fontSize: 8.0, fontWeight: FontWeight.w500, color: AppColors.textGrey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppHelpers.smallVerticalSpacing(),
            Container(
              margin: const EdgeInsets.only(left: AppDimensions.large),
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium, horizontal: AppDimensions.small),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColors.textFieldGrey, width: 2.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Image.asset(AppAssets.iconBank),
                  const Text(
                    'BANK MUAMALAT',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const Text(
                    'Norek.1110007133',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const Text(
                    'A.n. Isnayani',
                    style: TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.large),
              child: Text(
                '*Jangka waktu pembayaran hanya satu minggu  saja.',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.error,
                ),
              ),
            ),
            AppHelpers.largeVerticalSpacing(),
            BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
              builder: (context, state) {
                if (state is StudentRegistrationSuccess) {
                  return const NotificationLabel(isSuccess: true, message: 'Data Berhasil Ditambahkan');
                } else if (state is StudentRegistrationFailure) {
                  return NotificationLabel(isSuccess: false, message: AppHelpers.getErrorMessage(state.failure));
                }
                return const SizedBox.shrink();
              },
            ),
            BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(builder: (context, state) {
              return RoundedButton(
                title: state is StudentRegistrationLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : "Kirim",
                onTap: () {
                  if (_profPayment == null) {
                    Fluttertoast.showToast(msg: 'Bukti Bayar belum dipilih');
                    return;
                  }
                  widget.onSubmit();
                },
              );
            }),
            AppHelpers.smallVerticalSpacing(),
            RoundedButton(
              outline: true,
              title: 'Kembali',
              titleColor: AppColors.primary,
              onTap: () {
                context.read<StudentRegistrationPageCubit>().move(1);
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
