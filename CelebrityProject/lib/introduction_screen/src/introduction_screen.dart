library introduction_screen;

//import section
import 'dart:math';
import 'package:celepraty/introduction_screen/introduction_screen.dart';
import 'package:celepraty/introduction_screen/src/model/position.dart';
import 'package:celepraty/introduction_screen/src/ui/intro_button.dart';
import 'package:celepraty/introduction_screen/src/ui/intro_page.dart';
import 'package:collection/collection.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import './helper.dart';


class IntroductionScreen extends StatefulWidget {

  final List<PageViewModel>? pages;
  final List<Widget>? rawPages;
  final VoidCallback? onDone;
  final VoidCallback? onSkip;
  final ValueChanged<int>? onChange; // Callback when page change

  final Widget? done; //done button
  final Widget? skip; //skip button
  final Widget? back; //back button

  final bool showSkipButton; //is the skip button should be display
  final bool showDoneButton; //if the done button should be rendered at all the end
  final bool showBackButton; //is the Back button should be display

  final bool isProgress; //is the progress indicator should be display
  final bool isProgressTap; //enable or not onTap feature on progress indicator

  final bool freeze; //is the user is allow to change page

  final Color? globalBackgroundColor;
  final DotsDecorator dotsDecorator;
  final Decoration? dotsContainerDecorator;

  final int animationDuration; //animation duration in milliseconds
  final int initialPage;
  final int skipOrBackFlex;
  final int dotsFlex;
  final int nextFlex;
  final Curve curve; //Type of animation between pages


  final ButtonStyle? baseBtnStyle; // Base style for all buttons
  final ButtonStyle? doneStyle; // Done button style
  final ButtonStyle? skipStyle; // Skip button style
  final ButtonStyle? backStyle; // Back button style

  final String? doneSemantic;  // Done button semantic label
  final String? skipSemantic; // Skip button semantic label
  final String? backSemantic; // Back button semantic label

  final bool isTopSafeArea; // Enable or disabled top SafeArea
  final bool isBottomSafeArea; // Enable or disabled bottom SafeArea


  final Position controlsPosition; // Controls position
  final EdgeInsets controlsMargin; // Margin for controls
  final EdgeInsets controlsPadding; // Padding for controls

  final Widget? globalHeader; // A header widget to be shown on every screen
  final Widget? globalFooter; // A footer widget to be shown on every screen

  // ScrollController of vertical SingleChildScrollView for every single page
  final List<ScrollController?>? scrollControllers;

  // Scroll/Axis direction of pages, can he horizontal or vertical
  final Axis pagesAxis;
  final ScrollPhysics scrollPhysics; // PageView scroll physics (only when freeze is set to false)
  final bool rtl; // Is right to left behaviour

  const IntroductionScreen({Key? key,
    this.pages,
    this.rawPages,
    this.onDone,
    this.onSkip,
    this.onChange,
    this.done,
    this.skip,
    this.back,
    this.showSkipButton = false,
    this.showBackButton = false,
    this.showDoneButton = true,
    this.isProgress = true,
    this.isProgressTap = true,
    this.freeze = false,
    this.globalBackgroundColor,
    this.dotsDecorator =  const DotsDecorator(),
    this.dotsContainerDecorator,
    this.animationDuration = 350,
    this.initialPage = 0,
    this.skipOrBackFlex = 1,
    this.dotsFlex = 1,
    this.nextFlex = 1,
    this.curve =  Curves.easeIn,
    this.baseBtnStyle,
    this.doneStyle,
    this.skipStyle,
    this.backStyle,
    this.doneSemantic,
    this.skipSemantic,
    this.backSemantic,
    this.isTopSafeArea = false,
    this.isBottomSafeArea = false,
    this.controlsPosition  = const Position(left: 0, right: 0, bottom: 0),
    this.controlsMargin = EdgeInsets.zero,
    this.controlsPadding = const EdgeInsets.all(16.0),
    this.globalHeader,
    this.globalFooter,
    this.scrollControllers,
    this.pagesAxis = Axis.horizontal,
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.rtl = false})
      : assert(pages != null || rawPages != null),
        assert(
        (pages != null && pages.length > 0) ||
            (rawPages != null && rawPages.length > 0),
        "You provide at least one page on introduction screen !",
        ),
        assert(!showDoneButton || (done != null && onDone != null)),
        assert((showSkipButton && skip != null) || !showSkipButton),
        assert((showBackButton != showSkipButton) || (!showBackButton && !showSkipButton)),
        assert(skipOrBackFlex >= 0 && dotsFlex >= 0 && nextFlex >= 0),
        assert(initialPage >= 0),
      super(key: key);

  @override
  IntroductionScreenState createState() => IntroductionScreenState();
}

class IntroductionScreenState extends State<IntroductionScreen> {
  late PageController _pageController;
  double _currentPage = 0.0;
  bool _isSkipPressed = false;
  bool _isScrolling = false;

  PageController get controller => _pageController;

  @override
  void initState() {
    super.initState();
    int initialPage = min(widget.initialPage, getPagesLength() - 1);
    _currentPage = initialPage.toDouble();
    _pageController = PageController(initialPage: initialPage);
  }

  int getPagesLength() {
    return (widget.pages ?? widget.rawPages!).length;
  }

  void next() => animateScroll(_currentPage.round() + 1);

  void previous() => animateScroll(_currentPage.round() - 1);

  Future<void> _onSkip() async {
    if (widget.onSkip != null) {
      widget.onSkip!();
    } else {
      await skipToEnd();
    }
  }

  Future<void> skipToEnd() async {
    setState(() => _isSkipPressed = true);
    await animateScroll(getPagesLength() - 1);
    if (mounted) {
      setState(() => _isSkipPressed = false);
    }
  }

  Future<void> animateScroll(int page) async {
    setState(() => _isScrolling = true);
    await _pageController.animateToPage(
      max(min(page, getPagesLength() - 1), 0),
      duration: Duration(milliseconds: widget.animationDuration),
      curve: widget.curve,
    );
    if (mounted) {
      setState(() => _isScrolling = false);
    }
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics && metrics.page != null) {
      if (mounted) {
        setState(() => _currentPage = metrics.page!);
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    final isLastPage = (_currentPage.round() == getPagesLength() - 1);

    Widget? leftBtn;
    if (widget.showSkipButton && !_isSkipPressed && !isLastPage) {
      leftBtn = IntroButton(
        child: widget.skip!,
        style: widget.baseBtnStyle?.merge(widget.skipStyle) ?? widget.skipStyle,
        semanticLabel: widget.skipSemantic,
        onPressed: _onSkip,
      );
    } else if (widget.showBackButton && _currentPage.round() > 0) {
      leftBtn = IntroButton(
        child: widget.back!,
        style: widget.baseBtnStyle?.merge(widget.backStyle) ?? widget.backStyle,
        semanticLabel: widget.backSemantic,
        onPressed: !_isScrolling ? previous : null,
      );
    }

    Widget? rightBtn;
    if (isLastPage && widget.showDoneButton) {
      rightBtn = IntroButton(
        child: widget.done!,
        style: widget.baseBtnStyle?.merge(widget.doneStyle) ?? widget.doneStyle,
        semanticLabel: widget.doneSemantic,
        onPressed: !_isScrolling ? widget.onDone : null,
      );
    }
    return Scaffold(
      backgroundColor: widget.globalBackgroundColor,
      body: Stack(
        children:  [
          Positioned.fill(
            child: NotificationListener<ScrollNotification>(
              onNotification: _onScroll,
              child: PageView(
                reverse: widget.rtl,
                scrollDirection: widget.pagesAxis,
                controller: _pageController,
                onPageChanged: widget.onChange,
                physics: widget.freeze ?
                const NeverScrollableScrollPhysics() : widget.scrollPhysics,
                children: widget.pages?.mapIndexed(
                    (index, page) => IntroPage(
                      page: page,
                      scrollController: widget.scrollControllers
                          ?.elementAtOrNull(index),
                      isTopSafeArea: widget.isTopSafeArea,
                      isBottomSafeArea: widget.isBottomSafeArea,
                    ),
                ).toList() ?? widget.rawPages!,
              ),
            ),
      ),
          if (widget.globalHeader != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: widget.globalHeader!,
            ),
          Positioned(
            left: widget.controlsPosition.left,
            top: widget.controlsPosition.top,
            right: widget.controlsPosition.right,
            bottom: widget.controlsPosition.bottom,
            child: Column(
              children: [
                Container(
                  padding: widget.controlsPadding,
                  margin: widget.controlsMargin,
                  decoration: widget.dotsContainerDecorator,
                  child: Row(
                    children: [
                      Expanded(
                        flex: widget.skipOrBackFlex,
                        child: leftBtn ?? const SizedBox(),
                      ),
                      Expanded(
                        flex: widget.dotsFlex,
                        child: Center(
                          child: widget.isProgress
                              ? Semantics(
                            label:
                            "Page ${_currentPage.round() + 1} of ${getPagesLength()}",
                            excludeSemantics: true,
                            child: DotsIndicator(
                              reversed: widget.rtl,
                              dotsCount: getPagesLength(),
                              position: _currentPage,
                              decorator: widget.dotsDecorator,
                              onTap: widget.isProgressTap &&
                                  !widget.freeze
                                  ? (pos) => animateScroll(pos.toInt())
                                  : null,
                            ),
                          )
                              : const SizedBox(),
                        ),
                      ),
                      Expanded(
                        flex: widget.nextFlex,
                        child: rightBtn ?? const SizedBox(),
                      ),
                    ].asReversed(widget.rtl),
                  ),
                ),
                if (widget.globalFooter != null) widget.globalFooter!
              ],
            ),
          ),
        ],
      ),
    );
  }
}

