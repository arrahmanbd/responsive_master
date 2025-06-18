part of 'package:responsive_master/responsive_master.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? logo;
  final List<NavItem>? navItems;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double height;

  const ResponsiveAppBar({
    super.key,
    this.logo,
    this.navItems,
    this.actions,
    this.backgroundColor,
    this.height = 70,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: backgroundColor ?? Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          logo ??
              const Text(
                "LOGO",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
          const Spacer(),
          if (!isMobile && navItems != null) ...[
            for (final item in navItems!) _NavItemWidget(item: item),
            const SizedBox(width: 20),
          ],
          if (actions != null) ...actions!,
          if (isMobile && navItems != null)
            PopupMenuButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              itemBuilder: (context) => navItems!
                  .map(
                    (item) => PopupMenuItem(
                      child: Text(item.label),
                      onTap: item.onTap,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class NavItem {
  final String label;
  final VoidCallback onTap;

  NavItem({required this.label, required this.onTap});
}

class _NavItemWidget extends StatefulWidget {
  final NavItem item;

  const _NavItemWidget({required this.item});

  @override
  State<_NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<_NavItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isHovered ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.item.label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

@override
Size get preferredSize => const Size.fromHeight(56);
