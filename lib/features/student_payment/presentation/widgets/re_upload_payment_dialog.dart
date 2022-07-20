import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/shared/presentation/widgets/button_loading.dart';
import '../../../../core/shared/presentation/widgets/custom_photo_field.dart';
import '../../../../core/shared/presentation/widgets/rounded_button.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/update/update_payment_bloc.dart';

class ReUploadPaymentDialog extends StatefulWidget {
  final int paymentId;
  const ReUploadPaymentDialog({Key? key, required this.paymentId}) : super(key: key);

  @override
  State<ReUploadPaymentDialog> createState() => _ReUploadPaymentDialogState();
}

class _ReUploadPaymentDialogState extends State<ReUploadPaymentDialog> {
  final _updateBloc = locator<UpdatePaymentBloc>();
  XFile? _file;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pilih Bukti Pembayaran'),
      content: CustomPhotoField(
        bottomDescription: '',
        onPicked: (file) {
          _file = file;
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.medium),
          child: BlocConsumer<UpdatePaymentBloc, UpdatePaymentState>(
            bloc: _updateBloc,
            listener: (context, state) async {
              if (state is UpdatePaymentLoading) {
              } else {
                if (state is UpdatePaymentFailure) {
                  Fluttertoast.showToast(msg: AppHelpers.getErrorMessage(state.failure));
                } else if (state is UpdatePaymentUpdated) {
                  Fluttertoast.showToast(msg: 'Bukti transfer berhasil di-upload.');
                  await Future.delayed(const Duration(milliseconds: 800));
                  Navigator.pop(context);
                }
              }
            },
            builder: (context, state) {
              if (state is UpdatePaymentLoading) {
                return const ButtonLoading();
              }
              return RoundedButton(
                title: 'Kirim',
                onTap: () {
                  if (_file == null) {
                    Fluttertoast.showToast(msg: 'Bukti transfer belum dipilih.');
                    return;
                  }
                  _updateBloc.add(Submit(file: _file!, id: widget.paymentId));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
