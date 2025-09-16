/// Static dropdown options for inventory form fields
class InventoryDropdownOptions {
  static const List<String> lineItems = <String>[
    'Physical Product',
    'Digital Product',
    'Service',
    'Bundle',
    'Raw Material',
    'Finished Goods',
    'Work in Progress',
    'Consignment',
  ];

  static const List<String> suppliers = <String>[
    'ABC Suppliers Ltd',
    'Global Trading Co',
    'Local Vendors Inc',
    'Premium Materials',
    'Wholesale Direct',
    'Quality Source',
    'Trade Partners',
    'Supply Chain Pro',
  ];

  static const List<String> categories = <String>[
    'Electronics',
    'Clothing',
    'Food & Beverages',
    'Home & Garden',
    'Health & Beauty',
    'Books & Media',
    'Sports & Outdoor',
    'Toys & Games',
    'Automotive',
    'Office Supplies',
  ];

  static const List<String> subCategories = <String>[
    'Mobile Phones',
    'Laptops',
    'Accessories',
    'Men\'s Wear',
    'Women\'s Wear',
    'Children\'s Wear',
    'Beverages',
    'Snacks',
    'Fresh Food',
    'Furniture',
  ];

  static const List<String> productGroups = <String>[
    'Standard Products',
    'Premium Products',
    'Economy Products',
    'Seasonal Items',
    'Limited Edition',
    'Bulk Items',
    'Custom Products',
    'Import Items',
  ];

  static const List<String> ageGroups = <String>[
    'All Ages',
    'Kids (0-12)',
    'Teens (13-17)',
    'Adults (18-64)',
    'Seniors (65+)',
    'Toddlers (1-3)',
    'Preschool (4-6)',
    'School Age (7-12)',
  ];

  static const List<String> packagingTypes = <String>[
    'Box',
    'Bag',
    'Bottle',
    'Can',
    'Pouch',
    'Tube',
    'Jar',
    'Blister Pack',
    'Shrink Wrap',
    'Bulk',
  ];

  static const List<String> productGenders = <String>[
    'Unisex',
    'Male',
    'Female',
    'Boys',
    'Girls',
    'Men',
    'Women',
    'Not Applicable',
  ];

  static const List<String> currencies = <String>[
    'PKR - Pakistani Rupee',
    'USD - US Dollar',
    'EUR - Euro',
    'GBP - British Pound',
    'AED - UAE Dirham',
    'SAR - Saudi Riyal',
    'INR - Indian Rupee',
    'CAD - Canadian Dollar',
  ];

  static const List<String> purchaseConvUnits = <String>[
    'Pieces',
    'Kilograms',
    'Grams',
    'Liters',
    'Milliliters',
    'Meters',
    'Centimeters',
    'Square Meters',
    'Cubic Meters',
    'Dozens',
    'Boxes',
    'Cartons',
  ];

  static const List<String> acquireTypes = <String>[
    'Purchase',
    'Manufacturing',
    'Consignment',
    'Transfer',
    'Gift/Donation',
    'Return/Exchange',
    'Assembly',
    'Production',
  ];

  /// Get categories based on selected line item
  static List<String> getCategoriesForLineItem(String? lineItem) {
    if (lineItem == null) return categories;
    
    switch (lineItem) {
      case 'Physical Product':
        return <String>[
          'Electronics',
          'Clothing',
          'Home & Garden',
          'Sports & Outdoor',
          'Automotive',
        ];
      case 'Digital Product':
        return <String>[
          'Software',
          'Digital Media',
          'E-books',
          'Apps',
          'Games',
        ];
      case 'Service':
        return <String>[
          'Consulting',
          'Maintenance',
          'Installation',
          'Training',
          'Support',
        ];
      default:
        return categories;
    }
  }

  /// Get subcategories based on selected category
  static List<String> getSubCategoriesForCategory(String? category) {
    if (category == null) return subCategories;
    
    switch (category) {
      case 'Electronics':
        return <String>[
          'Mobile Phones',
          'Laptops',
          'Tablets',
          'Accessories',
          'Components',
        ];
      case 'Clothing':
        return <String>[
          'Men\'s Wear',
          'Women\'s Wear',
          'Children\'s Wear',
          'Footwear',
          'Accessories',
        ];
      default:
        return subCategories;
    }
  }

  /// Get default currency
  static String get defaultCurrency => 'PKR - Pakistani Rupee';

  /// Get default purchase conversion unit
  static String get defaultPurchaseConvUnit => 'Pieces';
}