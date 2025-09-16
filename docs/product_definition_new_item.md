# Product Definition Inputs (New Item)

> NOTE: Each dropdown will have a “+” icon on the right side, allowing users to add new entries at runtime. Clicking the icon will open a popup dialog where users can enter details, which will then be saved to the local database and immediately appear in the dropdown. When data is synced, these entries will automatically sync with the cloud database as well.
> 

## Required Inputs

- **Line Item** - Select from dropdown (Ladies Shirts, Pharmacy, etc.) - Dropdown
- **Product Code** - Auto-generated via template (F2) or manual entry - Input Field
- **Product Name** - Item name (Kurti, Disprin, etc.) - Input Field
- **Supplier** - Select from dropdown - Dropdown (Visibility Depends on Line Item)
- **Average Cost** - Cost price per unit - Input Field (double only)

## Optional Inputs

### Basic Details

- **Product Image** - Visual reference
- **Category** - Product classification - Dropdown (Visibility Depends on Line Item)
- **Sub Category** - Product classification - Dropdown (Visibility Depends on Category)
- **Product Group** - Grouping for reports - Dropdown
- **Age Group** - Target demographic - Dropdown (Visibility Depends on Category)
- **Packaging Type** - How product is packaged - Dropdown
- **Product Gender** - Male/Female/Unisex - Dropdown
- **Shop Quality** - Quality grade/level - Input Field (double only)
- Store Quality - Quantity in the store - Input Field (double only)

### Pricing & Sales

- **Price** - Retail price (leave empty for flexible pricing) - Input Field (double only)
- **VAT** - Tax percentage - Input Field (double only)
- **User Price** ✓ - Allow flexible pricing at POS - Input Field (double only)
- **Product ID** - Alternative identifier - Input Field (String)
- **Select Currency** - If multi-currency - Dropdown (Default PKR)

### Inventory Management

- **Minimum Level** - Reorder point - Input Field (double only)
- **Optimal Level** - Target stock level  - Input Field (double only)
- **Maximum Level** - Maximum stock limit  - Input Field (double only)

### Purchase Configuration

- **Purchase Conv. Unit** - Pack, Bottle, etc. - Dropdown (Visibility Depends on Category)
- **Purchase Conv. Factor** - Units per pack (10 tablets/pack) - Input Field (double only)
- **Acquire Type** - Purchased/Local/Outsourced - Dropdown (Visibility Depends on Line Item)
- **Purchase Type** - Local/Import - Dropdown (Visibility Depends on Line Item)
- **Manufacturing** - Manufactured/Outsourced - Dropdown (Visibility Depends on Line Item)

### Size & Color (if Line Item configured)

- **Product Sizes** - Check applicable sizes (Small, Medium, Large) - Dropdown (Visibility Depends on Category)
- **Product Combinations** - Check applicable colors - Dropdown (Visibility Depends on Category)
- **Default Size & Color** - Set defaults - Dropdown (Visibility Depends on Category)

### Additional

- **Date** - Entry date - Date Picker
- **Life Type** - Product lifecycle category - Dropdown (Visibility Depends on Category)
- **Comments** - Additional notes - Input Field (String)