import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isFullWidth;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isFullWidth = true,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.height = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    final Widget buttonContent = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: AppDimensions.space12),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.white,
          ),
        ),
        if (icon != null && !isLoading) ...[
          const SizedBox(width: AppDimensions.space8),
          Icon(
            icon,
            size: 20,
            color: textColor ?? Colors.white,
          ),
        ],
      ],
    );

    return Container(
      width: isFullWidth ? double.infinity : null,
      height: height,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.roundedPill,
        boxShadow: onPressed != null ? AppDimensions.buttonShadow : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? Colors.white,
          disabledBackgroundColor: AppColors.border,
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.roundedPill,
          ),
          elevation: 0,
        ),
        child: buttonContent,
      ),
    );
  }
}

class PillButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;
  final double height;
  final EdgeInsets padding;

  const PillButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.surface,
    this.textColor = AppColors.primary,
    this.iconColor,
    this.height = 36.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 14.0),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: AppDimensions.roundedPill,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppDimensions.roundedPill,
        child: Container(
          height: height,
          padding: padding,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: iconColor ?? textColor,
                ),
                const SizedBox(width: AppDimensions.space6),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
