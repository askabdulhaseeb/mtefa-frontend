# Candela RMS Software Flow

## Login Flow

System Start
↓
Login Screen (User ID + Password)
↓
User Authentication
↓
Group Rights Validation
↓
Main Dashboard Access

## Counter Cash Flow

Main Dashboard
↓
Shop Activities → New POS Cash
↓
Enter Opening Balance
↓
Receive Cash (if any from manager)
↓
Cash Skimming (optional - cash given to manager)
↓
Shift Status: OPEN
↓
Ready for Sales Operations

## Selling Flow

Active POS Session
↓
Shop Activities → Sales and Return
↓
Select Sales Person (optional)
↓
Select Customer/Member (optional)
↓
Product Entry Methods:
├── F1: Product List
├── F5: Product List with Stock Details  
├── F6: Product with Quantity
└── Touch Screen Buttons (if configured)
↓
Enter Product Details:
├── Quantity
├── Rate/Price
├── Discount (if applicable)
└── Tax
↓
Payment Mode Selection:
├── Cash
├── Credit
├── Cash/Credit (dual)
└── Credit Card
↓
Invoice Generation
↓
Print Invoice
↓
Transaction

## Listing/Reports Flow

Main Dashboard
↓
Reports Menu
↓
Report Categories:
├── A-Accounts Reports (Customer Ledger, etc.)
├── C-Sales Reports (Shop Sales, Sales Person Wise)
├── D-Stock Reports (Inventory, Stock Movement)
└── Other Reports
↓
Select Specific Report
↓
Set Parameters:
├── Date Range
├── Product/Customer Filter
├── Shop Selection
└── Other Criteria
↓
Generate Report
↓
View/Print/Export Report

## End-of-Shift Flow

Sales Operations Complete
↓
Cash/Shift Closing
↓
Enter Physical Cash Count
↓
System Reconciliation
↓
Generate X-Report
↓
Submit Cash to Manager
↓
Shift Status: CLOSED
↓
Next Shift/Day Setup

## Manager Closing Flow

All Shifts Closed
↓
Account Transactions Entry
↓
Shop Activities → Daily Cash Flow
↓
Physical vs System Cash Reconciliation
↓
Bank Deposits/HO Submissions
↓
Shop Closing Complete

## Physical Audit Flow

Periodic Process
↓
Shop Activities → Physical Audit
↓
Select Audit Date/Items
↓
Load Products for Counting
↓
Enter Physical Quantities
↓
System vs Physical Comparison
↓
Implement Audit
↓
Inventory Updates Applied
