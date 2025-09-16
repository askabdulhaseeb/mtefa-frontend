import 'package:flutter/material.dart';

import '../../../../core/constants/numbers.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/components/section_header.dart';
import '../widgets/components/welcome_header.dart';
import '../widgets/sections/management_section.dart';
import '../widgets/sections/quick_actions_section.dart';
import '../widgets/sections/reports_section.dart';
import '../widgets/sections/stats_overview_section.dart';

/// Mobile view for dashboard screen with scrollable cards
class DashboardMobileView extends StatelessWidget {
  const DashboardMobileView({required this.provider, super.key});

  final DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: provider.refreshDashboard,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(DoubleConstants.spacingS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Compact welcome header
            WelcomeHeader(
              isCompact: true,
              onRefresh: () => provider.refreshDashboard(),
            ),
            const SizedBox(height: DoubleConstants.spacingM),
            
            // Key stats in scrollable row
            StatsOverviewSection(
              provider: provider,
              isScrollable: true,
              crossAxisCount: 2, // Not used in scrollable mode
            ),
            const SizedBox(height: DoubleConstants.spacingM),
            
            // Quick actions
            const SectionHeader(
              title: 'Quick Actions',
              isCompact: true,
            ),
            const SizedBox(height: DoubleConstants.spacingS),
            QuickActionsSection(
              provider: provider,
              crossAxisCount: 2,
              childAspectRatio: 1.3,
            ),
            const SizedBox(height: DoubleConstants.spacingM),
            
            // Management - using list view for mobile
            const SectionHeader(
              title: 'Management',
              isCompact: true,
            ),
            const SizedBox(height: DoubleConstants.spacingS),
            ManagementSection(
              provider: provider,
              isListView: true,
            ),
            const SizedBox(height: DoubleConstants.spacingM),
            
            // Reports - compact cards
            const SectionHeader(
              title: 'Reports',
              isCompact: true,
            ),
            const SizedBox(height: DoubleConstants.spacingS),
            const ReportsSection(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              useCompactCards: true,
            ),
            const SizedBox(height: DoubleConstants.spacingXL),
          ],
        ),
      ),
    );
  }
}