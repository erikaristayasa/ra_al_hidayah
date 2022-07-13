import 'package:flutter/material.dart';

import '../../../../core/shared/presentation/widgets/custom_text_field.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';

class CustomPasswordContainer extends StatefulWidget {
  final bool showDescriptionText;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  const CustomPasswordContainer({
    Key? key,
    required this.passwordController,
    required this.passwordConfirmationController,
    this.showDescriptionText = true,
  }) : super(key: key);

  @override
  State<CustomPasswordContainer> createState() => _CustomPasswordContainerState();
}

class _CustomPasswordContainerState extends State<CustomPasswordContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          placeholder: 'Kata Sandi',
          inputType: TextInputType.visiblePassword,
          typeField: TypeField.password,
          isSecure: true,
          onChange: (_) {
            setState(() {});
          },
          controller: widget.passwordController,
        ),
        Visibility(
          visible: widget.showDescriptionText,
          child: const Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.large,
              top: AppDimensions.small,
              bottom: AppDimensions.small,
            ),
            child: Text(
              'Kata sandi minimal harus 8 karakter.',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                color: AppColors.textGrey,
              ),
            ),
          ),
        ),
        AppHelpers.smallVerticalSpacing(),
        CustomTextField(
          placeholder: 'Konfirmasi Kata Sandi',
          inputType: TextInputType.visiblePassword,
          typeField: TypeField.confirmationPassword,
          isSecure: true,
          onChange: (_) {
            setState(() {});
          },
          controller: widget.passwordConfirmationController,
          controllerMatcher: widget.passwordController,
        ),
      ],
    );
  }
}
