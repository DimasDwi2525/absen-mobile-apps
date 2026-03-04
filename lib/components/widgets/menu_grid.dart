import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(icon, color: Colors.lightBlue, size: 32),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 36,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.login,
        'label': 'Checked In',
        'onTap': () => _navigateTo(context, 'Checked In'),
      },
      {
        'icon': Icons.logout,
        'label': 'Checked Out',
        'onTap': () => _navigateTo(context, 'Checked Out'),
      },
      {
        'icon': Icons.location_on,
        'label': 'Site Attendance',
        'onTap': () => _navigateTo(context, 'Site Attendance'),
      },
      {
        'icon': Icons.access_time,
        'label': 'Overtime',
        'onTap': () => _navigateTo(context, 'Overtime'),
      },
      {
        'icon': Icons.folder,
        'label': 'Project',
        'onTap': () => _navigateTo(context, 'Project'),
      },
      {
        'icon': Icons.history,
        'label': 'History',
        'onTap': () => _navigateTo(context, 'History'),
      },
      {
        'icon': Icons.beach_access,
        'label': 'Leave Request',
        'onTap': () => _navigateTo(context, 'Leave Request'),
      },
      {
        'icon': Icons.event_note,
        'label': 'Permission Request',
        'onTap': () => _navigateTo(context, 'Permission Request'),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Row 1: 4 cards
          Row(
            children: [
              Expanded(
                child: MenuCard(
                  icon: menuItems[0]['icon'],
                  label: menuItems[0]['label'],
                  onTap: menuItems[0]['onTap'],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MenuCard(
                  icon: menuItems[1]['icon'],
                  label: menuItems[1]['label'],
                  onTap: menuItems[1]['onTap'],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MenuCard(
                  icon: menuItems[2]['icon'],
                  label: menuItems[2]['label'],
                  onTap: menuItems[2]['onTap'],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MenuCard(
                  icon: menuItems[3]['icon'],
                  label: menuItems[3]['label'],
                  onTap: menuItems[3]['onTap'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Row 2: 4 cards
          Row(
            children: [
              Expanded(
                child: MenuCard(
                  icon: menuItems[4]['icon'],
                  label: menuItems[4]['label'],
                  onTap: menuItems[4]['onTap'],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MenuCard(
                  icon: menuItems[5]['icon'],
                  label: menuItems[5]['label'],
                  onTap: menuItems[5]['onTap'],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MenuCard(
                  icon: menuItems[6]['icon'],
                  label: menuItems[6]['label'],
                  onTap: menuItems[6]['onTap'],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MenuCard(
                  icon: menuItems[7]['icon'],
                  label: menuItems[7]['label'],
                  onTap: menuItems[7]['onTap'],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, String pageName) {
    // Placeholder navigation - implement actual navigation in real app
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Navigating to $pageName...')));
  }
}
