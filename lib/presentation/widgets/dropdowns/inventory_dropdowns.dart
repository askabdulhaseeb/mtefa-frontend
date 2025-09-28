/// Modular inventory dropdown components
/// 
/// This file replaces the previous 504-line monolithic inventory_dropdown_with_add.dart
/// with a component-based architecture following the clean code principles.
/// 
/// Components are organized as:
/// - Base components: Reusable core dropdown functionality
/// - Single select: Specialized dropdowns for entities 
/// - Multi select: Components for selecting multiple items
/// - Loading states: Loading indicators for async operations
library;

// Base components
export 'components/base_dropdown_with_add.dart';
export 'components/loading_dropdown.dart';

// Single select dropdowns
export 'components/single_select_dropdowns.dart';

// Multi select dropdowns  
export 'components/multi_select_dropdowns.dart';