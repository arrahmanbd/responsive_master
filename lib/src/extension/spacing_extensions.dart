part of 'package:responsive_master/responsive_master.dart';

/// *****************************************************************************
/// 📐 **Unified Spacing Extensions using Responsive Scale Units**
/// *****************************************************************************

extension UnifiedSpacing on num {
  // Margin
  EdgeInsets get m => EdgeInsets.all(r); // Margin all sides
  EdgeInsets get mt => EdgeInsets.only(top: h); // Margin top (vertical)
  EdgeInsets get mb => EdgeInsets.only(bottom: h); // Margin bottom (vertical)
  EdgeInsets get ml => EdgeInsets.only(left: w); // Margin left (horizontal)
  EdgeInsets get mr => EdgeInsets.only(right: w); // Margin right (horizontal)
  EdgeInsets get mx =>
      EdgeInsets.symmetric(horizontal: w); // Margin horizontal (x)
  EdgeInsets get my => EdgeInsets.symmetric(vertical: h); // Margin vertical (y)

  // Padding
  EdgeInsets get p => EdgeInsets.all(r); // Padding all sides
  EdgeInsets get pt => EdgeInsets.only(top: h); // Padding top (vertical)
  EdgeInsets get pb => EdgeInsets.only(bottom: h); // Padding bottom (vertical)
  EdgeInsets get pl => EdgeInsets.only(left: w); // Padding left (horizontal)
  EdgeInsets get pr => EdgeInsets.only(right: w); // Padding right (horizontal)
  EdgeInsets get px =>
      EdgeInsets.symmetric(horizontal: w); // Padding horizontal (x)
  EdgeInsets get py =>
      EdgeInsets.symmetric(vertical: h); // Padding vertical (y)

  // Unified square & rectangle spacing
  SizedBox get s => SizedBox(height: h, width: w); // Square spacing
}
