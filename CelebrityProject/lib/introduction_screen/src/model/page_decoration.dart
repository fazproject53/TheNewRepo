import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageDecoration {

  final Color? pageColor; // Background page color

  final TextStyle titleTextStyle; // TextStyle for title
  final TextStyle bodyTextStyle; // TextStyle for body
  final BoxDecoration? boxDecoration; // BoxDecoration for page

  final int imageFlex; // Flex ratio of the image
  final int bodyFlex; // Flex ratio of the body

  final EdgeInsets imagePadding; // Padding of image
  final EdgeInsets contentMargin; // Margin of content (title + description + footer)
  final EdgeInsets titlePadding; // Padding of title
  final EdgeInsets? bodyPadding; // Padding of body
  final EdgeInsets footerPadding; // Padding of footer

  final Alignment bodyAlignment; // Body alignment
  final Alignment imageAlignment; // Image alignment

  final bool fullScreen; // Layout the page using the full screen with the image behind the text.

  const PageDecoration({
    this.pageColor,
    this.titleTextStyle = const TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      color: Colors.white70,
      fontFamily: 'Cairo'
    ),
    this.bodyTextStyle = const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
        color: Colors.white70,
        fontFamily: 'Cairo'
    ),
    this.boxDecoration,
    this.imageFlex = 1,
    this.bodyFlex = 1,
    this.imagePadding =  const EdgeInsets.only(bottom: 24.0),
    this.contentMargin = const EdgeInsets.all(20.0),
    this.titlePadding = const EdgeInsets.only(top: 150.0),
    this.bodyPadding,
    this.footerPadding = const EdgeInsets.symmetric(vertical: 50.0),
    this.bodyAlignment = Alignment.topCenter,
    this.imageAlignment = Alignment.bottomCenter,
    this.fullScreen = false,


  }) : assert(pageColor == null || boxDecoration == null,
  'Cannot provide both a Color and a BoxDecoration\n');

  PageDecoration copyWith({
    Color? pageColor,
    TextStyle? titleTextStyle,
    TextStyle? bodyTextStyle,
    BoxDecoration? boxDecoration,
    int? imageFlex,
    int? bodyFlex,
    EdgeInsets? imagePadding,
    EdgeInsets? contentMargin,
    EdgeInsets? titlePadding,
    EdgeInsets? descriptionPadding,
    EdgeInsets? footerPadding,
    Alignment? bodyAlignment,
    Alignment? imageAlignment,
    bool? fullScreen,
  }) {
    assert(
    pageColor == null || boxDecoration == null,
    'Cannot provide both a Color and a BoxDecoration\n',
    );

    return PageDecoration(
      pageColor: pageColor ?? this.pageColor,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
      boxDecoration: boxDecoration ?? this.boxDecoration,
      imageFlex: imageFlex ?? this.imageFlex,
      bodyFlex: bodyFlex ?? this.bodyFlex,
      imagePadding: imagePadding ?? this.imagePadding,
      contentMargin: contentMargin ?? this.contentMargin,
      titlePadding: titlePadding ?? this.titlePadding,
      bodyPadding: descriptionPadding ?? bodyPadding,
      footerPadding: footerPadding ?? this.footerPadding,
      bodyAlignment: bodyAlignment ?? this.bodyAlignment,
      imageAlignment: imageAlignment ?? this.imageAlignment,
      fullScreen: fullScreen ?? this.fullScreen,
    );
  }
}
