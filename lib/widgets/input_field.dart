import 'package:flutter/material.dart';
import 'package:firefly/styles/text_styles.dart';

class MyInputField extends StatefulWidget {
  final String? label;
  final Function onChanged;
  String? error;
  String? prefill;
  String? type;
  final double verticalPadding;
  final double borderRadius;
  MyInputField(
      {this.label,
      required this.onChanged,
      this.borderRadius = 16,
      this.verticalPadding = 20,
      this.error,
      this.type,
      this.prefill,
      super.key});

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  final colorUnfocused = Colors.grey;
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController(text: widget.prefill);
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          style: textMediumPrimary,
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: textMediumHint,
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: colorUnfocused),
            ),
          ),
          keyboardType: widget.type != null && widget.type == 'phone'
              ? TextInputType.phone
              : TextInputType.text,
          onChanged: (text) {
            widget.onChanged(text);
            setState(() {
              widget.error = null;
              widget.prefill = text;
            });
          },
        ),
        if (widget.error != null && widget.error!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.error!,
                style: textSmallError,
              ),
            ],
          )
      ],
    );
  }
}
