import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../statics/statics.dart';
import '../../../utilities/utilities.dart';
import '../blocs/text_controller/text_controller_bloc.dart';
import 'rounded_container.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String placeholder;
  final String bottomDescription;
  final bool isSecure;
  final TextEditingController controller;
  final TextEditingController? controllerMatcher;
  final TextInputType inputType;
  final bool refresh;
  final Function? onTap;
  final String? suffixText;
  final String? prefixText;
  final bool enabled;
  final bool showDeleteButton;
  final TypeField typeField;
  final String valueMatcher;
  final Function(String value)? onChange;
  final List<TextInputFormatter>? formatters;
  final bool validating;
  final int? maxlines;
  final bool isDatePicker;
  final bool outlineStyle;
  const CustomTextField({
    Key? key,
    this.placeholder = '',
    this.bottomDescription = '',
    this.title,
    this.isSecure = false,
    required this.controller,
    this.inputType = TextInputType.text,
    this.refresh = false,
    this.onTap,
    this.suffixText,
    this.enabled = true,
    this.showDeleteButton = false,
    this.typeField = TypeField.none,
    this.valueMatcher = '',
    this.controllerMatcher,
    this.prefixText,
    this.onChange,
    this.formatters,
    this.validating = true,
    this.maxlines,
    this.isDatePicker = false,
    this.outlineStyle = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _passwordVisible;

  late OutlineInputBorder normalBorder;

  late OutlineInputBorder errorBorder;

  @override
  void initState() {
    _passwordVisible = widget.isSecure;
    normalBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: AppColors.bgGrey, width: widget.outlineStyle ? 2 : 0
      ),
    );
    errorBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: AppColors.error, width: widget.outlineStyle ? 2 : 0
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TextControllerBloc(),
      child: BlocBuilder<TextControllerBloc, TextControllerState>(
        builder: (context, state) {
          final bloc = context.read<TextControllerBloc>();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.title != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: AppDimensions.medium,
                        top: AppDimensions.small,
                        bottom: AppDimensions.xSmall,
                      ),
                      child: Text(
                        widget.title ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                // width: double.maxFinite,
                // height: 38,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: widget.enabled,
                        inputFormatters: widget.formatters,
                        onTap: () {
                          if (widget.refresh) {
                            widget.onTap!();
                          }
                        },
                        onChanged: widget.onChange, //bloc.add(TextControllerOnChanged(newValue: newValue)),
                        obscureText: _passwordVisible,
                        controller: widget.controller,
                        keyboardType: widget.inputType,
                        maxLines: widget.maxlines ?? 1,
                        style: TextStyle(
                          color: state.error && !widget.outlineStyle ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                        obscuringCharacter: '●',
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          hintText: widget.placeholder,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textGrey,
                            fontSize: 12.0,
                          ),
                          border: InputBorder.none,
                          enabledBorder: normalBorder,
                          disabledBorder: normalBorder,
                          focusedBorder: normalBorder,
                          errorBorder: errorBorder,
                          focusedErrorBorder: errorBorder,
                          filled: !widget.outlineStyle,
                          fillColor: state.error
                              ? Colors.red
                              : widget.enabled
                                  ? AppColors.textFieldGrey
                                  : Colors.grey[400],
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          prefixIcon: widget.prefixText != null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.prefixText ?? '',
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : null,
                          suffixIcon: widget.isSecure
                              ? Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    padding: const EdgeInsets.only(right: AppDimensions.medium),
                                    splashRadius: 20.0,
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(
                                      _passwordVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                                      size: 13.0,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                )
                              : widget.suffixText != null
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(widget.suffixText!, textAlign: TextAlign.center, style: context.textTheme().labelSmall),
                                      ],
                                    )
                                  : widget.showDeleteButton
                                      ? IconButton(
                                          splashRadius: 20.0,
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () => widget.controller.clear(),
                                          icon: SvgPicture.asset(
                                            AppAssets.iconDelete,
                                            width: 14.0,
                                            height: 14.0,
                                          ),
                                        )
                                      : null,
                        ),
                        validator: widget.validating
                            ? ValidationHelper(
                                valueMatcher: widget.controllerMatcher?.text,
                                isError: (error) => bloc.add(TextControllerOnError(error)),
                                typeField: widget.typeField,
                              ).validate()
                            : (_) => null,
                      ),
                    ),
                    Visibility(
                      visible: widget.isDatePicker,
                      child: Padding(
                        padding: const EdgeInsets.only(left: AppDimensions.small),
                        child: GestureDetector(
                          onTap: () {
                            final _now = DateTime.now();
                            final _initialDate = widget.controller.text.toDate(format: 'dd/MM/yyyy');
                            showDatePicker(
                              context: context,
                              initialDate: _initialDate ?? _now,
                              firstDate: _now,
                              lastDate: _now.add(const Duration(days: 90)),
                            ).then((value) {
                              if (value != null) {
                                final _dateString = value.toText(format: 'dd/MM/yyyy');
                                widget.controller.text = _dateString;
                              }
                            });
                          },
                          child: RoundedContainer(
                            height: 42,
                            width: 42,
                            color: AppColors.primary.withOpacity(0.15),
                            radius: 10.0,
                            child: const Center(
                              child: Icon(
                                Icons.calendar_month,
                                color: AppColors.primary,
                                size: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              widget.bottomDescription.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: AppDimensions.xSmall),
                      child: Text(
                        widget.bottomDescription,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0,
                          color: AppColors.textGrey,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
