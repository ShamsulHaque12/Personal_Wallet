import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String? titleText;
  final String? hintText;
  final Color? hintTextColor;
  final Color? fillColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final bool? readOnly;
  final bool isSuffixIconOnTap;
  final bool isDropdown;
  final bool isPassword;
  final String? controllerTag;
  final List<String>? dropdownItems;
  final Widget? suffixIcon;
  final BorderSide? borderSide;
  final VoidCallback? onChanged;
  final int? maxLines;
  final bool? obscureText;

  const CustomTextField({
    super.key,
    this.textEditingController,
    this.titleText,
    this.hintText,
    this.hintTextColor,
    this.fillColor,
    this.textColor,
    this.height,
    this.width,
    this.readOnly = false,
    this.controllerTag,
    this.dropdownItems,
    this.isDropdown = false,
    this.isPassword = false,
    this.isSuffixIconOnTap = false,
    this.onChanged,
    this.suffixIcon,
    this.borderSide,
    this.maxLines = 1,
    this.obscureText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isOpen = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null && widget.titleText!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Text(
              widget.titleText!,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),

        Stack(
          children: [
            SizedBox(
              height: widget.isDropdown && isOpen
                  ? (widget.height ?? 48.h) +
                        ((widget.dropdownItems?.length ?? 0) * 38.h)
                  : widget.height ?? 48.h,
              width: widget.width ?? screenWidth,
            ),

            TextFormField(
              controller: widget.textEditingController,
              readOnly: widget.isDropdown || widget.readOnly!,
              maxLines: widget.maxLines,
              obscureText: widget.isPassword && !_isPasswordVisible,
              style: TextStyle(
                fontSize: 14.sp,
                color: widget.textColor ?? Colors.black,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText ?? "",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: widget.hintTextColor ?? Colors.grey,
                ),
                filled: true,
                fillColor: widget.fillColor ?? Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: widget.borderSide ?? BorderSide(width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: widget.borderSide ?? BorderSide(width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide:
                      widget.borderSide ??
                      BorderSide(width: 1.5, color: Colors.blue),
                ),

                // ✅ Dynamic suffix icon
                suffixIcon: widget.isDropdown
                    ? InkWell(
                        onTap: () => setState(() => isOpen = !isOpen),
                        child: Icon(
                          isOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down_outlined,
                        ),
                      )
                    : widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      )
                    : widget.suffixIcon,
              ),
            ),

            if (widget.isDropdown && isOpen)
              Positioned(
                top: (widget.height ?? 48.h),
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: widget.dropdownItems?.length ?? 0,
                    separatorBuilder: (_, __) => Divider(height: 0),
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          widget.textEditingController!.text =
                              widget.dropdownItems![index];
                          setState(() => isOpen = false);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            widget.dropdownItems![index],
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
