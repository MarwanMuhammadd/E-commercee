import 'package:counter/utlis/app_color.dart';
import 'package:flutter/material.dart';

class LabelWithTextfield extends StatefulWidget {
  
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obsecureText;

  const LabelWithTextfield({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    required this.hintText,
    this.obsecureText = false,
  });

  @override
  State<LabelWithTextfield> createState() => _LabelWithTextfieldState();
}

class _LabelWithTextfieldState extends State<LabelWithTextfield> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 16),
          TextFormField(
            validator:
                (value) =>
                    value == null || value.isEmpty
                        ? "${widget.label} cannot be empty"
                        : null,
            controller: widget.controller,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red),
              ),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              fillColor: AppColors.greyShade,
              prefixIcon: Icon(widget.prefixIcon),
              hintText: widget.hintText,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
