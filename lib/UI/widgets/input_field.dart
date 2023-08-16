import 'package:cars_app/UI/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final BuildContext? formContext;
  bool obsecure;
  final bool showEye;
  final IconData? icon;
  final bool withBorder;
  final FormFieldValidator<String>? validator;
  final bool multiLine;
  final TextInputType keybordType;
  final String? valMessage;
  final Function? onEditingComplete;
  InputField({
    Key? key,
    this.label,
    required this.controller,
    this.obsecure = false,
    this.formContext,
    this.valMessage,
    this.withBorder = false,
    this.validator,
    this.showEye = false,
    this.icon,
    this.hint,
    this.multiLine = false,
    this.keybordType = TextInputType.text,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: widget.formContext == null
          ? () {
              if (widget.onEditingComplete != null) {
                widget.onEditingComplete!();
              }
            }
          : () {
              FocusScope.of(widget.formContext!).nextFocus();
            },
      controller: widget.controller,
      obscureText: widget.obsecure,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodyText1,
      maxLines: widget.multiLine ? 3 : 1,
      keyboardType: widget.keybordType,
      decoration: InputDecoration(
          prefixIcon: widget.icon == null
              ? null
              : Icon(
                  widget.icon,
                  color: grayColor,
                ),
          labelText: widget.label,
          hintText: widget.hint,
          labelStyle: Theme.of(context).textTheme.labelSmall,
          suffixIcon: widget.showEye
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.obsecure = !widget.obsecure;
                    });
                  },
                  splashRadius: 12,
                  icon: Icon(widget.obsecure
                      ? Icons.visibility
                      : Icons.visibility_off))
              : null,
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          disabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          errorStyle: const TextStyle(
              fontSize: 10,
              height: 1,
              color: Colors.redAccent,
              fontWeight: FontWeight.bold),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(15.Q)),
          enabledBorder: OutlineInputBorder(
              borderSide: widget.withBorder
                  ? const BorderSide(color: Colors.black12)
                  : BorderSide(color: grayColor),
              borderRadius: BorderRadius.circular(15.Q)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: mainColor, width: 2),
              borderRadius: BorderRadius.circular(15.Q)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: mainColor, width: 2),
              borderRadius: BorderRadius.circular(15.Q)),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.Q))),
      validator: widget.validator ??
          (value) {
            if (value!.isEmpty) {
              return widget.valMessage;
            } else {
              return null;
            }
          },
    );
  }
}
