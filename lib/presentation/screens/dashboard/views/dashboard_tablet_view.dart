import 'package:flutter/material.dart';

import '../../../../core/constants/numbers.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/components/section_header.dart';
import '../widgets/components/welcome_header.dart';
import '../widgets/sections/management_section.dart';
import '../widgets/sections/quick_actions_section.dart';
import '../widgets/sections/reports_section.dart';
import '../widgets/sections/stats_overview_section.dart';

/// Tablet view for dashboard screen with adaptive layout
class DashboardTabletView extends StatelessWidget {
  const DashboardTabletView({required this.provider, super.key});

  final DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DoubleConstants.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Compact header
          const WelcomeHeader(isCompact: true),
          const SizedBox(height: DoubleConstants.spacingM),
          
          // Stats cards in 2 columns
          StatsOverviewSection(
            provider: provider,
            crossAxisCount: 2,
            childAspectRatio: 2.2,
          ),
          const SizedBox(height: DoubleConstants.spacingL),
          
          // Quick actions
          const SectionHeader(
            title: 'Quick Actions',
            isCompact: true,
          ),
          const SizedBox(height: DoubleConstants.spacingS),
          QuickActionsSection(
            provider: provider,
            crossAxisCount: 4,
          ),
          const SizedBox(height: DoubleConstants.spacingL),
          
          // Management tools
          const SectionHeader(
            title: 'Management',
            isCompact: true,
          ),
          const SizedBox(height: DoubleConstants.spacingS),
          ManagementSection(
            provider: provider,
            crossAxisCount: 3,
            childAspectRatio: 1.2,
          ),
          const SizedBox(height: DoubleConstants.spacingL),
          
          // Reports
          const SectionHeader(
            title: 'Reports & Analytics',
            isCompact: true,
          ),
          const SizedBox(height: DoubleConstants.spacingS),
          const ReportsSection(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
          ),
        ],
      ),
    );
  }
}