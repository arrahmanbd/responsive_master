part of 'package:responsive_master/responsive_master.dart';

class ResponsiveBuilder extends StatefulWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.transition = ResponsiveTransition.fade,
    this.duration = const Duration(milliseconds: 300),
  });

  final ResponsiveTransition transition;
  final Duration duration;

  /// Builder provides a [MediaInfo] object with full responsive info.
  final Widget Function(MediaInfo ui) builder;

  @override
  State<ResponsiveBuilder> createState() => _ResponsiveBuilderState();
}

class _ResponsiveBuilderState extends State<ResponsiveBuilder> {
  late MediaInfo _layoutData;
  String _generateKey(MediaInfo data) {
    return '${data.isMobile
            ? "mobile"
            : data.isTablet
            ? "tablet"
            : "desktop"}'
        '_${data.isLandscape ? "landscape" : "portrait"}';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _layoutData = MediaInfo.fromThis(context);
  }

  @override
  Widget build(BuildContext context) {
    _layoutData = MediaInfo.fromThis(context);

    return AnimatedSwitcher(
      duration: widget.duration,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: ResponsiveTransitionBuilder.resolve(widget.transition),
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: Alignment.center,
        children: [...previousChildren, if (currentChild != null) currentChild],
      ),
      child: KeyedSubtree(
        key: ValueKey(_generateKey(_layoutData)),
        child: widget.builder(_layoutData),
      ),
    );
  }
}

class SliverBuilder extends StatelessWidget {
  final Widget Function(MediaInfo media) builder;
  final Duration duration;
  final ResponsiveTransition transition;

  const SliverBuilder({
    super.key,
    required this.builder,
    this.duration = const Duration(milliseconds: 300),
    this.transition = ResponsiveTransition.slide,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaInfo.fromThis(context);
    return SliverToBoxAdapter(
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        transitionBuilder: ResponsiveTransitionBuilder.resolve(transition),
        layoutBuilder: (currentChild, previousChildren) => Stack(
          alignment: Alignment.center,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        ),
        child: KeyedSubtree(
          key: ValueKey(
            '${media.isMobile
                ? "mobile"
                : media.isTablet
                ? "tablet"
                : "desktop"}_${media.isLandscape ? "landscape" : "portrait"}',
          ),
          child: builder(media),
        ),
      ),
    );
  }
}
