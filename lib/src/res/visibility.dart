part of 'package:responsive_master/responsive_master.dart';

class HiddenOn extends StatelessWidget {
  final List<ScreenSize> sizes;
  final Widget child;

  const HiddenOn({required this.sizes, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final screen = getScreenSize(MediaQuery.of(context).size.width);
    return sizes.contains(screen) ? const SizedBox.shrink() : child;
  }
}

class VisibleOn extends StatelessWidget {
  final List<ScreenSize> sizes;
  final Widget child;

  const VisibleOn({required this.sizes, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final screen = getScreenSize(MediaQuery.of(context).size.width);
    return sizes.contains(screen) ? child : const SizedBox.shrink();
  }
}
