import 'package:flutter/material.dart';

import '../../../../core/constants/numbers.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/components/section_header.dart';
import '../widgets/components/welcome_header.dart';
import '../widgets/sections/management_section.dart';
import '../widgets/sections/quick_actions_section.dart';
import '../widgets/sections/reports_section.dart';
import '../widgets/sections/stats_overview_section.dart';

/// Desktop view for dashboard screen with grid layout
class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({required this.provider, super.key});

  final DashboardProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(DoubleConstants.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Welcome header
          const WelcomeHeader(),
          const SizedBox(height: DoubleConstants.spacingL),
          
          // Stats overview
          StatsOverviewSection(
            provider: provider,
            crossAxisCount: 4,
            childAspectRatio: 1.5,
          ),
          const SizedBox(height: DoubleConstants.spacingXL),
          
          // Quick actions section
          const SectionHeader(
            title: 'Quick Actions',
            subtitle: 'Frequently used functions',
          ),
          const SizedBox(height: DoubleConstants.spacingM),
          QuickActionsSection(
            provider: provider,
            crossAxisCount: 5,
          ),
          const SizedBox(height: DoubleConstants.spacingXL),
          
          // Management section
          const SectionHeader(
            title: 'Management',
            subtitle: 'Manage your business',
          ),
          const SizedBox(height: DoubleConstants.spacingM),
          ManagementSection(
            provider: provider,
            crossAxisCount: 5,
          ),
          const SizedBox(height: DoubleConstants.spacingXL),
          
          // Reports & Analytics section
          const SectionHeader(
            title: 'Reports & Analytics',
            subtitle: 'View insights and reports',
          ),
          const SizedBox(height: DoubleConstants.spacingM),
          const ReportsSection(
            crossAxisCount: 5,
          ),
        ],
      ),
    );
  }
}