part of 'package:responsive_master/responsive_master.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;

  const BaseScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MainLayout(main: child);
  }
}
