import 'package:flutter/material.dart';

class GenericInputBox extends StatelessWidget {
  const GenericInputBox({
    super.key,
    this.backgroundColor = Colors.white,
    this.hintText = '',
    required TextEditingController textInputController,
    required this.width,
    required this.enabled,
    this.height = 75,
    this.maxLines,
    this.fontSizeHintText = 15.3,
    this.colorHintText = Colors.grey,
    this.validation,
    this.textInputType = TextInputType.text,
    this.title = '',
    this.leadIcon = const Icon(Icons.short_text),
    this.onChangedAction,
  }) : _textInputController = textInputController;

  final double width;
  final double? height;
  final TextEditingController _textInputController;
  final bool enabled;
  final Color? backgroundColor;
  final String? hintText;
  final int? maxLines;
  final double? fontSizeHintText;
  final Color? colorHintText;
  final FormFieldValidator<String>? validation;
  final TextInputType textInputType;
  final String title;
  final Icon? leadIcon;
  final Function? onChangedAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('Generic_input_box'),
      width: width,
      height: height,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        showCursor: true,
        maxLines: maxLines,
        controller: _textInputController,
        enabled: enabled,
        cursorColor: Colors.grey,
        style: const TextStyle(
            color: Colors.black, fontSize: 13.3, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 215, 214, 214),
              ),
              borderRadius: BorderRadius.circular(15)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 215, 214, 214),
              ),
              borderRadius: BorderRadius.circular(15)),
          border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: backgroundColor,
          hintText: hintText,
          labelText: title,
          labelStyle: TextStyle(color: colorHintText),
          icon: leadIcon,
          hintStyle: TextStyle(
              fontSize: fontSizeHintText, fontWeight: FontWeight.w500),
          errorStyle: const TextStyle(
            color: Colors.red, // or any other color
          ),
        ),
        validator: validation,
        onChanged: (value) {
          if (onChangedAction == null) {
            return;
          }
          onChangedAction!(value);
        },
      ),
    );
  }
}
