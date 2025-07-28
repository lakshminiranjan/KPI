To document this enhancements as three major changes in this version 2.0 give like what and changed for each task. First added two new columns naming 'constraints' and 'Subject Matter expert email' which requires changes in Kpi table, insert, update, select all kpi stored proc, in UI aspx, vb code changes and second filtering kpis according to the active field which gives active/inactive according to the toggle implemented and requires changes in Get all kpis stored proc and ui changes in aspx, vb code and third change is that sorting each field by implementing ascending or descending the record by adding a button beside column names. This third task also require changes in get all kpis stored proc and in UI aspx, vb code. After  completing of describing three tasks leave space under documentation for txt files which will have sql queries and aspx, vb files that are need to be changed for deployment

Certainly! Here’s concise and clear release documentation for **v2.0**, organized by the three major enhancements you introduced. Each section lists WHAT was changed, and WHERE (SQL, ASPX, VB.NET), in a technical "change log" style for stakeholders and deployment.

# KPI Management v2.0 – Enhancement Documentation

## 1. **Additional Data Columns:**  
### Added **“Constraints”** and **“Subject Matter Expert Email”** to KPI Data

**What & Where Changed:**
- **Database:**
  - Extended **KPITable** to include two new columns:  
    - `Constraints` (VARCHAR/appropriate type)
    - `Subject_Matter_Expert_Email` (VARCHAR/appropriate type)
- **Stored Procedures:**
  - Updated the following procs to support new fields:
    - **InsertKPI**: Add `@Constraints`, `@Subject_Matter_Expert_Email` input params and insert logic.
    - **UpdateKPIByID**: Add/maintain new fields in update logic and as parameters.
    - **GetAllKPITable**: Add both new columns to SELECT result set.
- **UI ASPX:**
  - Added input fields for both new attributes in the KPI add/edit modal/form:
    - `<asp:TextBox ID="txtConstraints" ... />`
    - `<asp:TextBox ID="txtSMEEmail" ... />`
  - Extended GridView to show *Constraints* and *Subject Matter Expert Email* columns.
- **VB.NET Code:**
  - Updated backend to:
    - Capture/save the new Constraint and SME Email values when adding/editing a KPI.
    - Populate these fields during editing (in `LoadEditData`).
    - Pass them into insert/update SqlDataSource parameters.

## 2. **Filtering KPIs By Active/Inactive Status via Toggle**

**What & Where Changed:**
- **Stored Procedures:**
  - Enhanced **GetAllKPITable** to accept a `@Status` parameter (`'Y'` for active, `'N'` for inactive).
  - Returns only matching records.
- **UI ASPX:**
  - Added a toggle switch above the GridView to select “Active” or “Inactive” KPIs.
  - Bound toggle state to the filtering logic—when toggled, updates the KPI listing.
- **VB.NET Code:**
  - Handles the toggle’s state change event, sets the `@Status` parameter for the data source, and refreshes the GridView accordingly.
  - Ensures the toggle’s state persists and reflects the correct label (“Active”/“Inactive”).

## 3. **Sorting by Any Field – Ascending/Descending Controls**

**What & Where Changed:**
- **Stored Procedures:**
  - Enhanced **GetAllKPITable** to accept `@SortColumn` and `@SortDirection` parameters and use dynamic SQL for ordering by any allowed field and direction.
  - Prevents duplicate ordering on the same column (e.g., when sorting by OrderWithinSecton).
- **UI ASPX:**
  - For each GridView column, added up/down arrow buttons (▲/▼) beside the column name, with hover effect.
  - Configured each button to sort that column in asc/desc order when clicked.
  - Visual indicator highlights the active sort column and direction.
- **VB.NET Code:**
  - Handles sorting commands from GridView (which column/direction), stores state in ViewState.
  - Updates SqlDataSource parameters accordingly and re-binds the grid.
  - Ensures sorting works for all columns, including newly added ones.
  - Renders the arrow for the currently sorted column in the header.

# FILES TO MODIFY / ATTACHMENTS (to be pasted below for deployment)

**[Leave space here for:]**
- All relevant SQL scripts (ALTER TABLE, ALTER PROCEDURE, etc.)
- Updated .aspx (markup/UI)
- Updated Default.aspx.vb (code-behind)

**End of documentation section.**  
(Paste your TXT or code file contents below as needed for QA/deployment.)

Citations:
[1] KPI-Library.aspx https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/7f220faf-dad9-4aac-8bda-3b6b9b2f10ce/KPI-Library.aspx
[2] Kpi-Library.aspx.vb https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/d3ee7600-36e4-4070-844a-376c0d7ca2ed/Kpi-Library.aspx.vb


Deployment Attachments
(Below are placeholders for your deployment .txt/code files. Replace each section with your actual code before final packaging/distribution.)

Table Change TXT File
KPITable_Alter.txt

sql
-- Example:
ALTER TABLE KPITable
  ADD Constraints VARCHAR(255) NULL,
      Subject_Matter_Expert_Email VARCHAR(255) NULL;
-- Adjust types/length as needed
Stored Proc TXT Files
InsertKPI_Alter.txt

sql
-- Show full CREATE or ALTER proc with added @Constraints and @Subject_Matter_Expert_Email
UpdateKPIByID_Alter.txt

sql
-- Show full CREATE or ALTER proc with added @Constraints and @Subject_Matter_Expert_Email
GetAllKPITable_Alter.txt

sql
-- Full proc:
-- 1. SELECT added columns
-- 2. Parameters: @Status, @SortColumn, @SortDirection
-- 3. ORDER BY dynamic
-- 4. Logic to avoid duplicate ordering columns
UI Files
ASPX
KPI-Library.aspx.txt

text
<!--
- New fields in modal (for Constraints, SME Email)
- GridView
    * Add two new columns for Constraints and SME Email
    * Toggle switch for active/inactive filter
    * Up/Down arrows for sorting on each column
    * Edit button as first column
- DataKeyNames="KPI ID"
- Each TemplateField for each data column
-->
VB.NET Code-Behind
KPI-Library.aspx.vb.txt

text
' Updates to:
' - btnSubmit_Click: handle Constraints and SME Email on add/update
' - LoadEditData: populate new fields in edit mode
' - GridView1_RowCommand: support Edit and CustomSort
' - Active filter toggle logic
' - Sorting logic (ViewState, DataSource parameters)
' - Use DataKeys for fetching KPI ID in LoadEditData
(Optional) Designer File
KPI-Library.aspx.designer.vb.txt

text
' Only update if you have new controls that must appear in strongly-typed variables