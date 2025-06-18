part of 'package:responsive_master/responsive_master.dart';

class CustomSidebar extends StatelessWidget {
  final Function(String route)? onItemSelected;
  final String selectedRoute;

  const CustomSidebar({
    super.key,
    required this.selectedRoute,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _SidebarItem(
        icon: Icons.dashboard,
        label: 'Dashboard',
        route: '/dashboard',
      ),
      _SidebarItem(
        icon: Icons.shopping_cart,
        label: 'Products',
        route: '/products',
      ),
      _SidebarItem(icon: Icons.settings, label: 'Settings', route: '/settings'),
      _SidebarItem(icon: Icons.logout, label: 'Logout', route: '/logout'),
    ];

    return Container(
      width: 250,
      height: double.infinity,
      color: Colors.grey[100],
      child: Column(
        children: [
          const DrawerHeader(
            child: Text(
              'Admin Panel',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ...items.map(
            (item) => _SidebarTile(
              item: item,
              selected: selectedRoute == item.route,
              onTap: () => onItemSelected?.call(item.route),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem {
  final IconData icon;
  final String label;
  final String route;

  _SidebarItem({required this.icon, required this.label, required this.route});
}

class _SidebarTile extends StatefulWidget {
  final _SidebarItem item;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<_SidebarTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.selected;
    final backgroundColor = isSelected
        ? Colors.blue[50]
        : _hovered
        ? Colors.grey[200]
        : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: backgroundColor,
          child: Row(
            children: [
              Icon(
                widget.item.icon,
                color: isSelected ? Colors.blue : Colors.black54,
              ),
              const SizedBox(width: 16),
              Text(
                widget.item.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.blue : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
