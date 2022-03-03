import 'package:celepraty/introduction_screen/src/model/page_decoration.dart';
import 'package:flutter/material.dart';

class PageViewModel {
  final String? title; // Title of page
  final Widget? titleWidget; // Title of page

  final String? body; // Text of page (description)
  final Widget? bodyWidget; // Widget content of page (description)
  final Widget? image; // Image of page
  final Widget? footer; // Footer widget

  final PageDecoration decoration; // Page decoration
  final bool reverse; // if widget Order is reverse - body before image
  final bool useScrollView; // wrap content in scrollView

  // use Row instead of Column when in landscape to place image next to the content.
  final bool useRowInLandscape;

  PageViewModel({
    this.title,
    this.titleWidget,
    this.body,
    this.bodyWidget,
    this.image,
    this.footer,
    this.reverse = false,
    this.decoration = const PageDecoration(),
    this.useScrollView = true,
    this.useRowInLandscape = false,
  })  : assert(
          title != null || titleWidget != null,
          "You must provide either title (String) or titleWidget (Widget).",
        ),
        assert(
          (title == null) != (titleWidget == null),
          "You can not provide both title and titleWidget.",
        ),
        assert(
          body != null || bodyWidget != null,
          "You must provide either body (String) or bodyWidget (Widget).",
        ),
        assert(
          (body == null) != (bodyWidget == null),
          "You can not provide both body and bodyWidget.",
        );
}
