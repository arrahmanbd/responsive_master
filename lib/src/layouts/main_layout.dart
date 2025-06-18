part of 'package:responsive_master/responsive_master.dart';

class MainLayout extends StatefulWidget {
  final Widget main;
  final Widget? sidebar;
  final PreferredSizeWidget? appBar;

  const MainLayout({super.key, required this.main, this.sidebar, this.appBar});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool get isMobile => MediaQuery.of(context).size.width < 768;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: widget.appBar,
      drawer: isMobile && widget.sidebar != null ? widget.sidebar : null,
      body: Row(
        children: [
          if (!isMobile && widget.sidebar != null) widget.sidebar!,
          Expanded(child: widget.main),
        ],
      ),
    );
  }
}
