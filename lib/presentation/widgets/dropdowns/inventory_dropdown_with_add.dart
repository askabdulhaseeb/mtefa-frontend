/// REFACTORED: This file has been modernized with component-based architecture
/// 
/// The previous 504-line monolithic implementation has been broken down into:
/// - BaseDropdownWithAdd: Core reusable dropdown functionality  
/// - Single select components: Specialized dropdowns for each entity type
/// - Multi-select components: For colors and sizes selection
/// - Loading components: For async loading states
/// 
/// This maintains backward compatibility while using the new modular components internally.
library;

// Export all the new modular components for external use
export 'components/base_dropdown_with_add.dart';
export 'components/loading_dropdown.dart';
export 'components/single_select_dropdowns.dart';
export 'components/multi_select_dropdowns.dart';

// Re-export inventory_dropdowns for convenience
export 'inventory_dropdowns.dart';