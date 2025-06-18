part of 'package:responsive_master/responsive_master.dart';

class Col extends StatelessWidget {
  final Widget child;
  final int? xs, sm, md, lg, xl;
  final int? offsetXs, offsetSm, offsetMd, offsetLg, offsetXl;

  const Col({
    required this.child,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.offsetXs,
    this.offsetSm,
    this.offsetMd,
    this.offsetLg,
    this.offsetXl,
    super.key,
  });

  int _getSpan(ScreenSize size) {
    switch (size) {
      case ScreenSize.xs:
        return xs ?? sm ?? md ?? lg ?? xl ?? 12;
      case ScreenSize.sm:
        return sm ?? md ?? lg ?? xl ?? xs ?? 12;
      case ScreenSize.md:
        return md ?? lg ?? xl ?? sm ?? xs ?? 12;
      case ScreenSize.lg:
        return lg ?? xl ?? md ?? sm ?? xs ?? 12;
      case ScreenSize.xl:
        return xl ?? lg ?? md ?? sm ?? xs ?? 12;
    }
  }

  int _getOffset(ScreenSize size) {
    switch (size) {
      case ScreenSize.xs:
        return offsetXs ?? offsetSm ?? offsetMd ?? offsetLg ?? offsetXl ?? 0;
      case ScreenSize.sm:
        return offsetSm ?? offsetMd ?? offsetLg ?? offsetXl ?? offsetXs ?? 0;
      case ScreenSize.md:
        return offsetMd ?? offsetLg ?? offsetXl ?? offsetSm ?? offsetXs ?? 0;
      case ScreenSize.lg:
        return offsetLg ?? offsetXl ?? offsetMd ?? offsetSm ?? offsetXs ?? 0;
      case ScreenSize.xl:
        return offsetXl ?? offsetLg ?? offsetMd ?? offsetSm ?? offsetXs ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final screen = getScreenSize(width);
    final span = _getSpan(screen);
    final offset = _getOffset(screen);

    final spanFraction = span / 12;
    final offsetFraction = offset / 12;

    return FractionallySizedBox(
      widthFactor: spanFraction + offsetFraction,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * offsetFraction,
        ),
        child: child,
      ),
    );
  }
}
