import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/core/my_scaffold.dart';
import '../../widgets/core/responsive_widget.dart';
import 'providers/dashboard_provider.dart';
import 'views/dashboard_desktop_view.dart';
import 'views/dashboard_mobile_view.dart';
import 'views/dashboard_tablet_view.dart';

/// Main dashboard screen with responsive design
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashboardProvider>(
      create: (_) => DashboardProvider(),
      child: const _DashboardContent(),
    );
  }
}

/// Inner dashboard content that has access to the provider
class _DashboardContent extends StatefulWidget {
  const _DashboardContent();

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  @override
  void initState() {
    super.initState();
    // Initialize dashboard data on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeDashboard();
    });
  }

  Future<void> _initializeDashboard() async {
    final DashboardProvider provider = context.read<DashboardProvider>();
    await provider.initializeDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (BuildContext context, DashboardProvider provider, Widget? child) {
        return MyScaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          safeArea: false,
          appBar: _buildAppBar(context, provider),
          drawer: _buildDrawer(context),
          body: ResponsiveWidget(
            mobile: DashboardMobileView(provider: provider),
            tablet: DashboardTabletView(provider: provider),
            desktop: DashboardDesktopView(provider: provider),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, DashboardProvider provider) {
    final ThemeData theme = Theme.of(context);
    
    return AppBar(
      title: const Text('Dashboard'),
      backgroundColor: theme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      actions: <Widget>[
        // Notifications
        IconButton(
          icon: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              const Icon(Icons.notifications),
              if (provider.pendingOrders > 0)
                Positioned(
                  right: -3,
                  top: -3,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                  ),
                ),
            ],
          ),
          onPressed: () {
            debugPrint('Open notifications');
          },
        ),
        
        // User menu
        PopupMenuButton<String>(
          icon: const Icon(Icons.account_circle),
          onSelected: (String value) {
            switch (value) {
              case 'profile':
                debugPrint('Navigate to profile');
              case 'logout':
                debugPrint('Logout');
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
            const PopupMenuItem<String>(
              value: 'profile',
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.store, size: 30, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'MTEFA POS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Multi-brand Management',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.dashboard,
            title: 'Dashboard',
            isSelected: true,
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.point_of_sale,
            title: 'New Sale',
            onTap: () {
              Navigator.pop(context);
              debugPrint('Navigate to New Sale');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.shopping_bag,
            title: 'Products',
            onTap: () {
              Navigator.pop(context);
              debugPrint('Navigate to Products');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.inventory,
            title: 'Inventory',
            onTap: () {
              Navigator.pop(context);
              debugPrint('Navigate to Inventory');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.people,
            title: 'Customers',
            onTap: () {
              Navigator.pop(context);
              debugPrint('Navigate to Customers');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.local_shipping,
            title: 'Suppliers',
            onTap: () {
              Navigator.pop(context);
              debugPrint('Navigate to Suppliers');
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.analytics,
            title: 'Reports',
            onTap: () {
              Navigator.pop(context);
              debugPrint('Navigate to Reports');
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              debugPrint('Navigate to Settings');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    final ThemeData theme = Theme.of(context);
    
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? theme.primaryColor : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? theme.primaryColor : null,
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }
}