part of 'package:responsive_master/responsive_master.dart';

class Kontainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const Kontainer({required this.child, this.maxWidth = 1140, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
