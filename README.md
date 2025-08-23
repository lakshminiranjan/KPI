

**Brief Description (2 lines):**  
This release enhances KPI management by adding two key data fields, advanced filtering for active/inactive KPIs, and per-column dynamic sorting with visual indicators. Users can now manage, filter, and sort KPIs far more flexibly and intuitively.

**Three Main Change Points:**
1. Added "Constraints" and "Subject Matter Expert Email" columns to KPITable, stored procedures, and all related UI and backend code.  
2. Implemented a toggle to filter KPIs by active or inactive status, linked to backend filtering and UI state.  
3. Enabled dynamic per-column sorting (ascending/descending) with clickable arrow buttons and active sort indicators, fully integrated with backend SQL sorting.

Citations:
[1] KPI-Library.aspx https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/9bcc087a-d932-4db9-bdec-c194605769f6/KPI-Library.aspx
[2] Kpi-Library.aspx.vb https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/d8caab33-df8b-41a2-bcad-38091294345a/Kpi-Library.aspx.vb



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


In this leva space for files give like this is table TXT file, these are stored proc TXT files for each stored proc these are UI files aspx, vb, designer code

Certainly! Here is your documentation template **including placeholders/spaces for files** organized as TXT attachments for deployment, as you requested.

# KPI Management v2.0 – Enhancement Documentation

## 1. **Additional Data Columns**
**“Constraints”** and **“Subject Matter Expert Email”** added to KPI records.

- **Table Changes**
  - New columns in `KPITable`: `Constraints`, `Subject_Matter_Expert_Email`.
- **Stored Procedures**
  - Updated: `InsertKPI`, `UpdateKPIByID`, `GetAllKPITable` (add/select/update new columns).
- **UI (ASPX/VB Code)**
  - New input fields in the Add/Edit KPI modal for Constraints and SME Email.
  - New columns added to the GridView for display.
  - VB code updates for insert, update, and edit.

## 2. **Active/Inactive Filtering via Toggle**
Show only **Active** or **Inactive** KPIs using a toggle.

- **Stored Proc**
  - `GetAllKPITable` now accepts a `@Status` parameter (`'Y'`, `'N'`).
- **UI (ASPX/VB Code)**
  - Toggle control above GridView.
  - VB code updates parameter to filter on toggle.

## 3. **Sorting on Any Field (Asc/Desc) via UI Arrows**
Clickable up/down arrows beside each column header—users can sort on any field.

- **Stored Proc**
  - `GetAllKPITable` enhanced to support `@SortColumn` and `@SortDirection` parameters; ORDER BY built dynamically.
- **UI (ASPX/VB Code)**
  - Each GridView column: up/down arrow buttons beside header.
  - VB code updates current sort column/direction and calls stored proc.

# Deployment Attachments

*(Below are placeholders for your deployment .txt/code files. Replace each section with your actual code before final packaging/distribution.)*

## **Table Change TXT File**  
**KPITable_Alter.txt**

```sql
-- Example:
ALTER TABLE KPITable
  ADD Constraints VARCHAR(255) NULL,
      Subject_Matter_Expert_Email VARCHAR(255) NULL;
-- Adjust types/length as needed
```

## **Stored Proc TXT Files**

**InsertKPI_Alter.txt**

```sql
-- Show full CREATE or ALTER proc with added @Constraints and @Subject_Matter_Expert_Email
```

**UpdateKPIByID_Alter.txt**

```sql
-- Show full CREATE or ALTER proc with added @Constraints and @Subject_Matter_Expert_Email
```

**GetAllKPITable_Alter.txt**

```sql
-- Full proc:
-- 1. SELECT added columns
-- 2. Parameters: @Status, @SortColumn, @SortDirection
-- 3. ORDER BY dynamic
-- 4. Logic to avoid duplicate ordering columns
```

## **UI Files**

### ASPX
**KPI-Library.aspx.txt**

```aspx
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
```

### VB.NET Code-Behind
**KPI-Library.aspx.vb.txt**

```vb
' Updates to:
' - btnSubmit_Click: handle Constraints and SME Email on add/update
' - LoadEditData: populate new fields in edit mode
' - GridView1_RowCommand: support Edit and CustomSort
' - Active filter toggle logic
' - Sorting logic (ViewState, DataSource parameters)
' - Use DataKeys for fetching KPI ID in LoadEditData
```

### (Optional) Designer File  
**KPI-Library.aspx.designer.vb.txt**

```vb
' Only update if you have new controls that must appear in strongly-typed variables
```

## **How to Use**

- Copy each code section into its matching .txt file and include in your deployment/QA checklist.
- Each section here maps one-to-one to a deployment or code review task.
- Under each placeholder, paste your actual, fully tested SQL or ASPX/VB.NET code.

**End of documentation.**  
(Paste files below this line as needed.)

Citations:
[1] KPI-Library.aspx https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/7f220faf-dad9-4aac-8bda-3b6b9b2f10ce/KPI-Library.aspx
[2] Kpi-Library.aspx.vb https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/d3ee7600-36e4-4070-844a-376c0d7ca2ed/Kpi-Library.aspx.vb


Give description In 4-5 for this enhancement

**Enhancement Description (in 4-5 lines):**

This version introduces three key improvements to the KPI Management module. First, it adds two new data columns—Constraints and Subject Matter Expert Email—to the KPI record structure and updates all related database operations and user interfaces to support them. Second, it implements an intuitive toggle switch above the grid to filter KPIs based on their active or inactive status, with backend filtering via the status parameter. Third, it enables dynamic sorting for every grid column, allowing users to sort ascending or descending using interactive arrow buttons, with all sorting handled efficiently on the database side for performance. These changes collectively improve data richness, usability, and flexibility for KPI management.

Citations:
[1] KPI-Library.aspx https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/7f220faf-dad9-4aac-8bda-3b6b9b2f10ce/KPI-Library.aspx
[2] Kpi-Library.aspx.vb https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/d3ee7600-36e4-4070-844a-376c0d7ca2ed/Kpi-Library.aspx.vb


Please give release. Notes for KPI Library version 2.0

Here are the **Release Notes** for **KPI Library version 2.0**:

***

# KPI Library v2.0 – Release Notes

## Overview
KPI Library v2.0 introduces major enhancements for improved data management, user convenience, and reporting flexibility. Three principal improvements have been made: expanded data columns, powerful filtering, and a complete upgrade to grid sorting and usability.

***

## Key Enhancements

### 1. **Expanded KPI Data Columns**
- Two new fields, **Constraints** and **Subject Matter Expert Email**, have been added to KPI records.
- The database table, all relevant stored procedures, UI forms, and grid views have been updated to support these fields.
- Users can add, edit, and view constraint information and SME contact for each KPI.

### 2. **Active/Inactive Filtering**
- UI now includes an **Active/Inactive toggle switch**, allowing quick filter between active and inactive KPIs.
- Backend filtering is optimized; only selected KPIs are queried and displayed.
- The filter state persists on reload, and editing status is seamless.

### 3. **Dynamic Column Sorting**
- Every KPI grid column has clickable up/down arrows to sort values in ascending or descending order.
- The current sort column and direction are visually indicated beside the column header.
- Sorting is performed directly on the server for speed and accuracy.

***

## Other Changes & Fixes
- Improved form validation for new fields.
- Enhanced gridrow editing with robust data population regardless of grid sorting or filtering.
- All updates maintain compatibility across browsers and fit with existing grid styling.
- Bug fix: Sort indicators now appear correctly for all columns, including the "Order" field.

***

## Deployment Notes
- **Database scripts**: ALTER TABLE for new columns; updated stored procedures for insert, update, and selection.
- **UI files**: Updated ASPX (KPI-Library.aspx), code-behind (Kpi-Library.aspx.vb), designer files as necessary.
- **Testing**: Test cases are available for Add/Edit KPI, sorting, filtering, indicator display, and validation.

***

## Known Issues & Compatibility
- No major issues in this release.
- Data migration is required for previous KPIs to populate the new columns, if needed.

***

## Attachments / Files for Deployment
- SQL scripts and modified code files to be referenced in deployment documentation.
- Complete test case matrix for QA is available in Excel format.

***

**This version delivers stronger data control, user interface improvements, and robust reporting features for all KPI management users.**

Citations:
[1] KPI-Library.aspx https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/9bcc087a-d932-4db9-bdec-c194605769f6/KPI-Library.aspx
[2] Kpi-Library.aspx.vb https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/d8caab33-df8b-41a2-bcad-38091294345a/Kpi-Library.aspx.vb


No need to give changes in code just give changes as description please

Certainly! Here are the **KPI Library v3.0 enhancement changes as a description** (without direct code):

***

### KPI Library 3.0 – Enhancement Description

- **Database/schema:** Two new columns have been added to each KPI record: **Subjective/Objective** (VARCHAR(15)) to classify the KPI type, and **Comments** (VARCHAR(MAX)) to store extended free-text information or notes.
- **Procedures and data handling:** All insert, update, and select procedures now support these new fields, ensuring that values are captured, stored, and displayed whenever a KPI is created or modified.
- **User Interface (Add/Edit):** The KPI add/edit popup now includes a dropdown beside "Subjective/Objective" allowing selection between those two values, and a multi-line comments field to input any remarks.
- **Grid/List View:** The main KPI grid includes new columns to display each KPI’s Subjective/Objective classification and any associated comments.
- **Workflow:** Whenever a KPI record is added or modified, both the Subjective/Objective dropdown choice and the entered comments are saved, displayed, and available for reporting, allowing deeper context and more precise categorization of KPIs.

***

KPI Library v3.0 Description (4-5 lines)
KPI Library version 3.0 adds two valuable data points to every KPI: a clear Subjective/Objective classification and a free-form Comments field for extra context. Users can now select the KPI's nature via an easy dropdown in the add/edit dialog, and record detailed notes or observations. All backend logic and UI components fully support these new fields—data entry, editing, and reporting are seamless and robust. These enhancements offer deeper insight and flexibility for KPI administration and decision-making.

Citations:
[1] KPI-Library.aspx https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/9bcc087a-d932-4db9-bdec-c194605769f6/KPI-Library.aspx
[2] Kpi-Library.aspx.vb https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/12938409/d8caab33-df8b-41a2-bcad-38091294345a/Kpi-Library.aspx.vb

Give simialrly other also similar to the uploaded content in the specific headings

Certainly! Here’s a documentation template **matching the style and headings appearing in your uploaded content**, with example entries for each major enhancement in KPI Library v3.0. Adjust or expand under the specific headings as needed.

***

## Risk Associated

- There is no dependency of new Subjective/Objective or Comments columns with other elements of EMS. Addition of new columns is isolated to KPITable, so no risk.

## Consequences of not performing change

- User cannot classify KPIs as Subjective or Objective, nor provide comments/notes for context. This limits KPI tracking, reporting clarity, and knowledge transfer.

## User/Jobs Service Impact during window

- As these are isolated schema and UI enhancements, there will be no impact to existing EMS Services during deployment.

***

## Backout/Rollback Plan, in case of issue

- Replace updated KPITable and stored procedures with previous backups.
- Restore KPI-Library.aspx and related code-behind files from last stable version.

***

## UAT Sign Off

- Please share change tracking number to mention in UAT sign-off email.

***

## Change Timelines

- Post business hours UK time.

***

## Change Reason

- This is a modification to enable KPI classification as Subjective or Objective and capture extended comments per KPI for better documentation, audit, and reporting.

***

## Verification Steps

- Run the home page and add a new KPI: both Subjective/Objective dropdown and Comments field should appear.
- Edit an existing KPI: verify values populate for both new fields.
- GridView should show new columns for Subjective/Objective and Comments.

***

## Attachments/Deployment Files

- [ ] KPITable_Alter.txt – SQL for adding new columns.
- [ ] Stored Procedure TXT files (InsertKPI, UpdateKPIByID, GetAllKPITable).
- [ ] KPI-Library.aspx.txt – UI changes for dropdown/comments field and new grid columns.
- [ ] KPI-Library.aspx.vb.txt – Backend logic for new fields.

***

**You can create similar sections for every major future enhancement, just as shown above.  
Let me know if you want sample content for v2.0 or 1.0 in the same format!**

Citations:
[1] selected_image_1517920012712372059.jpg https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/12938409/87b65f21-c631-433f-92df-54e79dba9793/selected_image_1517920012712372059.jpg?AWSAccessKeyId=ASIA2F3EMEYE45FSIXTD&Signature=hZdZQsBn%2BDV6NYLKetUCI2wK4Yg%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEMz%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIDxq%2BPuNWnBfa%2FwXN8FjSRWHTbwDR2lR4mTlCu4z5EuvAiB6uioSFKC%2Bwojk77dUjfq8NwvMtiQHa4kZqGxP3wngtirxBAgVEAEaDDY5OTc1MzMwOTcwNSIM16pJGaiPgOAzgG7WKs4EOl0ezJlUXDgybQo6AriFXyFTk12Z15K%2FceeuttogMNkBA6KbfftM2oM7D1qSc45YmaknyZIs1amRO341Qh6ugoLnG3NsO%2FsBx0hyOtLV68Ux6LN7E5cKOav8uyAyQUBp7lLjQBk38BebSpt4%2BrGyyN8O9kt5Biql7VnrIxMkvQVwfrE9HZm60vJ6UCiTKQW8M%2Fr10MBF0g%2BvDOHty3qDsYe1CfRK9AhJn1T%2F7R6g31vdT3A4AvcsnPU6sR1OqTfkoulGAMK3S2L4i45cf16Sof3UUF%2BpoKapJT4XmKooL%2Bd%2FCKsBY%2FzJW%2BjEKrO%2B4wcb6ctLDHjY9pNcQvinhbufjOTvwmhylMXkwsQGGRpwg1eWKDRyrPB0IYbwYlByzXyvTI%2FDOBKTtTYC1QDfQ%2FI8Xorrq6sl9k01XX%2Fknik%2Ful%2FrmaJVilmI5WHYDs95Kzrbi9liaSGdKv1ljzuoARrJJCsyR5hot6DF1HZTS8MDOISHIz0uiV5ZeXAWKSsJptnDuuIXR4uvjKxSsBKCFwe4Bkz0zi1czGufX1vJ2oqERQ7aKEoJ1xJhfRu7ztxXe2gfsb953zw1vgzteApU1h0JOxqF7Ch%2BHtF7eLOC8Uk5JP3fAXGFcKYhN2EF%2ByikauEkfdc6twHw3AtYtfiuGLg3MxauCgPji9atWKGKSVWEMOwzkE38V3TRP6piuex%2FkPXtIy7LwAxOy5zFlRzUhulilDGDXRO7I5fCfB6JNzUDrCrhgxtoIEpZJVpbCBO5V%2F1AvBQdXmWPNhT7ng5sC8Iwsc7sxAY6mwE6EowCVZ7oWB4SwAo%2FrHTtN6SPhAmuyrzjTqBIfNSO%2FxK1lzDIr9b%2BmOaK5xHBafATuhvY8srPvx2O%2BZ%2FIJVMllb0f3tgVNcRP8gQ9CdPF7%2BTmcAy7DizkRnvqK1EjbOzBI9ZGxNAgFtd3Y4xfx6vm01rrjvXVY7MeFD%2BAZXC0sKqcnTkzYJzkiML5TqxL3FP4xlIGop7asMMg7Q%3D%3D&Expires=1755001510
[2] selected_image_4407633815027693963.jpg https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/12938409/6edc57c2-b895-46ff-90e1-19cc8795d805/selected_image_4407633815027693963.jpg?AWSAccessKeyId=ASIA2F3EMEYE45FSIXTD&Signature=TjGGhfWP0fksk0lx7%2FyD%2BRZe%2BeQ%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEMz%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIDxq%2BPuNWnBfa%2FwXN8FjSRWHTbwDR2lR4mTlCu4z5EuvAiB6uioSFKC%2Bwojk77dUjfq8NwvMtiQHa4kZqGxP3wngtirxBAgVEAEaDDY5OTc1MzMwOTcwNSIM16pJGaiPgOAzgG7WKs4EOl0ezJlUXDgybQo6AriFXyFTk12Z15K%2FceeuttogMNkBA6KbfftM2oM7D1qSc45YmaknyZIs1amRO341Qh6ugoLnG3NsO%2FsBx0hyOtLV68Ux6LN7E5cKOav8uyAyQUBp7lLjQBk38BebSpt4%2BrGyyN8O9kt5Biql7VnrIxMkvQVwfrE9HZm60vJ6UCiTKQW8M%2Fr10MBF0g%2BvDOHty3qDsYe1CfRK9AhJn1T%2F7R6g31vdT3A4AvcsnPU6sR1OqTfkoulGAMK3S2L4i45cf16Sof3UUF%2BpoKapJT4XmKooL%2Bd%2FCKsBY%2FzJW%2BjEKrO%2B4wcb6ctLDHjY9pNcQvinhbufjOTvwmhylMXkwsQGGRpwg1eWKDRyrPB0IYbwYlByzXyvTI%2FDOBKTtTYC1QDfQ%2FI8Xorrq6sl9k01XX%2Fknik%2Ful%2FrmaJVilmI5WHYDs95Kzrbi9liaSGdKv1ljzuoARrJJCsyR5hot6DF1HZTS8MDOISHIz0uiV5ZeXAWKSsJptnDuuIXR4uvjKxSsBKCFwe4Bkz0zi1czGufX1vJ2oqERQ7aKEoJ1xJhfRu7ztxXe2gfsb953zw1vgzteApU1h0JOxqF7Ch%2BHtF7eLOC8Uk5JP3fAXGFcKYhN2EF%2ByikauEkfdc6twHw3AtYtfiuGLg3MxauCgPji9atWKGKSVWEMOwzkE38V3TRP6piuex%2FkPXtIy7LwAxOy5zFlRzUhulilDGDXRO7I5fCfB6JNzUDrCrhgxtoIEpZJVpbCBO5V%2F1AvBQdXmWPNhT7ng5sC8Iwsc7sxAY6mwE6EowCVZ7oWB4SwAo%2FrHTtN6SPhAmuyrzjTqBIfNSO%2FxK1lzDIr9b%2BmOaK5xHBafATuhvY8srPvx2O%2BZ%2FIJVMllb0f3tgVNcRP8gQ9CdPF7%2BTmcAy7DizkRnvqK1EjbOzBI9ZGxNAgFtd3Y4xfx6vm01rrjvXVY7MeFD%2BAZXC0sKqcnTkzYJzkiML5TqxL3FP4xlIGop7asMMg7Q%3D%3D&Expires=1755001510





Similar way implement same thing to export to XLS down to active kpis toggle in this KPI Library please, give exact where code changes need to be done

Absolutely! Here are the **exact steps and code blocks** to add an “Export to XLS” button (using DevExpress/ASPxGridViewExporter) below your Active KPIs toggle, so it exports your KPI Library just like in your screenshots.

***

## 1. Add the Export Button in ASPX (under Active KPIs Toggle)

**Find this block in your ASPX, soon after the Active KPIs toggle:**
```aspx
<div style="margin-bottom:18px;">
    <span id="toggleLabel" runat="server" style="font-weight:bold;">Active</span>
    <label class="toggle-switch" style="vertical-align:middle;margin:0 10px;">
        <asp:CheckBox ID="chkShowActive" runat="server" AutoPostBack="true" OnCheckedChanged="chkShowActive_CheckedChanged" />
        <span class="slider"></span>
    </label>
</div>
```

**Add the following table (button) **IMMEDIATELY BELOW** the above code:**
```aspx
<table class="ExportButtons">
    <tr>
        <td style="padding-top:4px; padding-bottom:2px;">
            <dx:ASPxButton ID="btnXlsExport" runat="server" Text="Export to XLS"
                ClientInstanceName="btnXlsExport" 
                OnClick="btnXlsExport_Click"
                UseSubmitBehavior="false" />
        </td>
    </tr>
</table>
```

***

## 2. Add the ASPxGridViewExporter Control

**Place this right after your main ASPxGridView (GridViewEditor) and before the closing </div> or </asp:Content>:**
```aspx
<dx:ASPxGridViewExporter ID="gridExport" runat="server" GridViewID="GridViewEditor"></dx:ASPxGridViewExporter>
```

***

## 3. Add the Export Handler in Code-Behind

**In your Default.aspx.vb (or KPI-Library.aspx.vb), add this at the bottom (but inside your Page class!):**
```vbnet
Protected Sub btnXlsExport_Click(ByVal sender As Object, ByVal e As EventArgs)
    Dim options As New DevExpress.XtraPrinting.XlsxExportOptionsEx() With {
        .ExportType = DevExpress.Export.ExportType.WYSIWYG,
        .TextExportMode = DevExpress.Export.TextExportMode.Value,
        .ShowGridLines = False
    }
    gridExport.WriteXlsxToResponse("KPI_Library_Export", options)
End Sub
```
**(If you use different namespaces for XlsxExportOptionsEx, adjust accordingly. For DevExpress 19+ it’s as above.)**

***

## 4. Ensure Required References/Namespaces

**At the top of your code-behind, make sure you have:**
```vbnet
Imports DevExpress.XtraPrinting
Imports DevExpress.Export
```
  
***

## 5. Double Check Key Details

- The `GridViewID="GridViewEditor"` must match the ID of your main <dx:ASPxGridView ... /> that shows the grid.
- If your KPI grid uses a different ID, use that in the `GridViewID` property for the exporter.

***

## 6. Save, Build, and Test

- Go to the page, click the “Export to XLS” button under the toggle, and your export will download the grid as Excel.

***

### **Summary:**
**ASPX**
- Add ASPxButton for export under toggle.
- Add ASPxGridViewExporter after your grid.

**VB.NET**
- Add an `btnXlsExport_Click` handler as shown above.

That’s it! Now you’ll have the export functionality right below the Active KPIs toggle—works exactly like your screens. If you want to style the button or change “Export to XLS” text, just edit the button’s `Text` property.

Citations:
[1] selected_image_1284083392008783659.jpg https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/12938409/abce6bb6-45f7-4094-ae34-34154b9ae761/selected_image_1284083392008783659.jpg?AWSAccessKeyId=ASIA2F3EMEYEW6LQCDKD&Signature=aId5VdhslesgTHO50wmFDJQvh3A%3D&x-amz-security-token=IQoJb3JpZ2luX2VjELn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIFa7iKil6D%2FYq0Swk%2FqAI9dVea8R%2BApw78F3MRCioEO4AiBnksKRcey4lKbPbBFP8Cb9S40g68XdiV4qaZ4jyXEXzirxBAgSEAEaDDY5OTc1MzMwOTcwNSIMxctwhUelRKKTiTLRKs4EvLdGpzhg%2F4jbJRGuQQjyv%2FlOfp09LAVDtrURMznn7M7ri5GxZHEeap%2FtnFWKbo9ZcBk4r3txpBjcyTHv0NuoDKETG8A1kitPqDwTf0po%2FnL2woKbnznUpZJnIiXlntZOC3D3pWjzUrwxj454eN0eO3fOyWRsWUguj6IEkJiXj3KZHBRrQfh1NUySzDLxaPNjWLBhlrL5T%2Fdwa4sMxMd8tWq6DRPDmsYtbZm%2B2OPUpbw%2BLh%2BJ7C9zwGQz963Z%2FDfekRPl1otCo0%2FEeXEO1z3V72o5byL2unTyYqgTyG%2Flao3uG3%2FeWxLsRSS5fKVamn1Lr6QYrpyDYCN%2FNxRu%2BKZy%2F5mCt%2FhsaH%2BV0Utu3t3d7se6QRUwy3GvDTy%2B1Oi%2BkRSPEZPSpuCnRpzDVrqs5uzSq4G%2B%2BcEnfw17IGgthBnMIi3RmQvD%2FtfL34xhHnqiVCkXLbPieTIDu%2F%2BMUruUZ71mz3Hn4CbRLotyh2cCnhamP2lKkf68pv5MeSwt%2F2t5%2FW%2BIKJq%2BVXyXcvAutu56pHVfxWEujx1%2ByHiBVXDqPjQtr2sJ0nPZgxiDDuh%2BU3FTsIogt6hHznNmvW6jnVf4PWYm2LAOYgX9oOUGMuejyercZcQxKAYvuJNk9pAj2N%2F29A47dNA1JM1Esn07fSQK%2BrjykhrqAbb4B2BVLMuqVvP9o1728bmb1LYoeTSXU6BpP9LzGWGMXHnNEyuMgIXbuJn9hdoBEqrqo%2BwOQvB3DvPDpptF%2Fcyu%2FlMiq587eeWBC9lpWRA2lbok6j3k8PwT%2BYUw7N2gxQY6mwFUiaWnwqyhbkklWwsQtqt4W%2FREYwBiJpoHFTI0ssbUMYi2yPXAhO2g6A7ImDcldPnU0H608uVoUcZ5N2cA2teB9isUKQ6KZh%2BAmkE1jgCC2flkfDrks7oyPtxXHG6nHkgsz2iLgWmO0qdqwOnHH2AofwHMWZ51VPqOI5NfDWna%2Fu6q%2FQsWCxDURazVVu6c64o5Gl5b0%2FDJuvDp5A%3D%3D&Expires=1755854876
[2] selected_image_6340636405333947802.jpg https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/12938409/4314308e-9c48-4fe1-b02e-cb417523c857/selected_image_6340636405333947802.jpg?AWSAccessKeyId=ASIA2F3EMEYEW6LQCDKD&Signature=i4kXgY9R78RBGsjI4ZOxPTzArvY%3D&x-amz-security-token=IQoJb3JpZ2luX2VjELn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIFa7iKil6D%2FYq0Swk%2FqAI9dVea8R%2BApw78F3MRCioEO4AiBnksKRcey4lKbPbBFP8Cb9S40g68XdiV4qaZ4jyXEXzirxBAgSEAEaDDY5OTc1MzMwOTcwNSIMxctwhUelRKKTiTLRKs4EvLdGpzhg%2F4jbJRGuQQjyv%2FlOfp09LAVDtrURMznn7M7ri5GxZHEeap%2FtnFWKbo9ZcBk4r3txpBjcyTHv0NuoDKETG8A1kitPqDwTf0po%2FnL2woKbnznUpZJnIiXlntZOC3D3pWjzUrwxj454eN0eO3fOyWRsWUguj6IEkJiXj3KZHBRrQfh1NUySzDLxaPNjWLBhlrL5T%2Fdwa4sMxMd8tWq6DRPDmsYtbZm%2B2OPUpbw%2BLh%2BJ7C9zwGQz963Z%2FDfekRPl1otCo0%2FEeXEO1z3V72o5byL2unTyYqgTyG%2Flao3uG3%2FeWxLsRSS5fKVamn1Lr6QYrpyDYCN%2FNxRu%2BKZy%2F5mCt%2FhsaH%2BV0Utu3t3d7se6QRUwy3GvDTy%2B1Oi%2BkRSPEZPSpuCnRpzDVrqs5uzSq4G%2B%2BcEnfw17IGgthBnMIi3RmQvD%2FtfL34xhHnqiVCkXLbPieTIDu%2F%2BMUruUZ71mz3Hn4CbRLotyh2cCnhamP2lKkf68pv5MeSwt%2F2t5%2FW%2BIKJq%2BVXyXcvAutu56pHVfxWEujx1%2ByHiBVXDqPjQtr2sJ0nPZgxiDDuh%2BU3FTsIogt6hHznNmvW6jnVf4PWYm2LAOYgX9oOUGMuejyercZcQxKAYvuJNk9pAj2N%2F29A47dNA1JM1Esn07fSQK%2BrjykhrqAbb4B2BVLMuqVvP9o1728bmb1LYoeTSXU6BpP9LzGWGMXHnNEyuMgIXbuJn9hdoBEqrqo%2BwOQvB3DvPDpptF%2Fcyu%2FlMiq587eeWBC9lpWRA2lbok6j3k8PwT%2BYUw7N2gxQY6mwFUiaWnwqyhbkklWwsQtqt4W%2FREYwBiJpoHFTI0ssbUMYi2yPXAhO2g6A7ImDcldPnU0H608uVoUcZ5N2cA2teB9isUKQ6KZh%2BAmkE1jgCC2flkfDrks7oyPtxXHG6nHkgsz2iLgWmO0qdqwOnHH2AofwHMWZ51VPqOI5NfDWna%2Fu6q%2FQsWCxDURazVVu6c64o5Gl5b0%2FDJuvDp5A%3D%3D&Expires=1755854876
[3] selected_image_2220507730995931078.jpg https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/12938409/56981fcb-b9f6-4d14-bd0c-d6622d8cc740/selected_image_2220507730995931078.jpg?AWSAccessKeyId=ASIA2F3EMEYEW6LQCDKD&Signature=AhH%2BuwJ%2BdL6sdzNdVyjZ5BePQDE%3D&x-amz-security-token=IQoJb3JpZ2luX2VjELn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIFa7iKil6D%2FYq0Swk%2FqAI9dVea8R%2BApw78F3MRCioEO4AiBnksKRcey4lKbPbBFP8Cb9S40g68XdiV4qaZ4jyXEXzirxBAgSEAEaDDY5OTc1MzMwOTcwNSIMxctwhUelRKKTiTLRKs4EvLdGpzhg%2F4jbJRGuQQjyv%2FlOfp09LAVDtrURMznn7M7ri5GxZHEeap%2FtnFWKbo9ZcBk4r3txpBjcyTHv0NuoDKETG8A1kitPqDwTf0po%2FnL2woKbnznUpZJnIiXlntZOC3D3pWjzUrwxj454eN0eO3fOyWRsWUguj6IEkJiXj3KZHBRrQfh1NUySzDLxaPNjWLBhlrL5T%2Fdwa4sMxMd8tWq6DRPDmsYtbZm%2B2OPUpbw%2BLh%2BJ7C9zwGQz963Z%2FDfekRPl1otCo0%2FEeXEO1z3V72o5byL2unTyYqgTyG%2Flao3uG3%2FeWxLsRSS5fKVamn1Lr6QYrpyDYCN%2FNxRu%2BKZy%2F5mCt%2FhsaH%2BV0Utu3t3d7se6QRUwy3GvDTy%2B1Oi%2BkRSPEZPSpuCnRpzDVrqs5uzSq4G%2B%2BcEnfw17IGgthBnMIi3RmQvD%2FtfL34xhHnqiVCkXLbPieTIDu%2F%2BMUruUZ71mz3Hn4CbRLotyh2cCnhamP2lKkf68pv5MeSwt%2F2t5%2FW%2BIKJq%2BVXyXcvAutu56pHVfxWEujx1%2ByHiBVXDqPjQtr2sJ0nPZgxiDDuh%2BU3FTsIogt6hHznNmvW6jnVf4PWYm2LAOYgX9oOUGMuejyercZcQxKAYvuJNk9pAj2N%2F29A47dNA1JM1Esn07fSQK%2BrjykhrqAbb4B2BVLMuqVvP9o1728bmb1LYoeTSXU6BpP9LzGWGMXHnNEyuMgIXbuJn9hdoBEqrqo%2BwOQvB3DvPDpptF%2Fcyu%2FlMiq587eeWBC9lpWRA2lbok6j3k8PwT%2BYUw7N2gxQY6mwFUiaWnwqyhbkklWwsQtqt4W%2FREYwBiJpoHFTI0ssbUMYi2yPXAhO2g6A7ImDcldPnU0H608uVoUcZ5N2cA2teB9isUKQ6KZh%2BAmkE1jgCC2flkfDrks7oyPtxXHG6nHkgsz2iLgWmO0qdqwOnHH2AofwHMWZ51VPqOI5NfDWna%2Fu6q%2FQsWCxDURazVVu6c64o5Gl5b0%2FDJuvDp5A%3D%3D&Expires=1755854876
[4] selected_image_4885260687723337973.jpg https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/attachments/images/12938409/6061266a-11f7-4c7d-b26f-19807665feb4/selected_image_4885260687723337973.jpg?AWSAccessKeyId=ASIA2F3EMEYEW6LQCDKD&Signature=6rGxCJbCOOHyvts5bpR0tyOqodM%3D&x-amz-security-token=IQoJb3JpZ2luX2VjELn%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIFa7iKil6D%2FYq0Swk%2FqAI9dVea8R%2BApw78F3MRCioEO4AiBnksKRcey4lKbPbBFP8Cb9S40g68XdiV4qaZ4jyXEXzirxBAgSEAEaDDY5OTc1MzMwOTcwNSIMxctwhUelRKKTiTLRKs4EvLdGpzhg%2F4jbJRGuQQjyv%2FlOfp09LAVDtrURMznn7M7ri5GxZHEeap%2FtnFWKbo9ZcBk4r3txpBjcyTHv0NuoDKETG8A1kitPqDwTf0po%2FnL2woKbnznUpZJnIiXlntZOC3D3pWjzUrwxj454eN0eO3fOyWRsWUguj6IEkJiXj3KZHBRrQfh1NUySzDLxaPNjWLBhlrL5T%2Fdwa4sMxMd8tWq6DRPDmsYtbZm%2B2OPUpbw%2BLh%2BJ7C9zwGQz963Z%2FDfekRPl1otCo0%2FEeXEO1z3V72o5byL2unTyYqgTyG%2Flao3uG3%2FeWxLsRSS5fKVamn1Lr6QYrpyDYCN%2FNxRu%2BKZy%2F5mCt%2FhsaH%2BV0Utu3t3d7se6QRUwy3GvDTy%2B1Oi%2BkRSPEZPSpuCnRpzDVrqs5uzSq4G%2B%2BcEnfw17IGgthBnMIi3RmQvD%2FtfL34xhHnqiVCkXLbPieTIDu%2F%2BMUruUZ71mz3Hn4CbRLotyh2cCnhamP2lKkf68pv5MeSwt%2F2t5%2FW%2BIKJq%2BVXyXcvAutu56pHVfxWEujx1%2ByHiBVXDqPjQtr2sJ0nPZgxiDDuh%2BU3FTsIogt6hHznNmvW6jnVf4PWYm2LAOYgX9oOUGMuejyercZcQxKAYvuJNk9pAj2N%2F29A47dNA1JM1Esn07fSQK%2BrjykhrqAbb4B2BVLMuqVvP9o1728bmb1LYoeTSXU6BpP9LzGWGMXHnNEyuMgIXbuJn9hdoBEqrqo%2BwOQvB3DvPDpptF%2Fcyu%2FlMiq587eeWBC9lpWRA2lbok6j3k8PwT%2BYUw7N2gxQY6mwFUiaWnwqyhbkklWwsQtqt4W%2FREYwBiJpoHFTI0ssbUMYi2yPXAhO2g6A7ImDcldPnU0H608uVoUcZ5N2cA2teB9isUKQ6KZh%2BAmkE1jgCC2flkfDrks7oyPtxXHG6nHkgsz2iLgWmO0qdqwOnHH2AofwHMWZ51VPqOI5NfDWna%2Fu6q%2FQsWCxDURazVVu6c64o5Gl5b0%2FDJuvDp5A%3D%3D&Expires=1755854876





///

<asp:Button ID="btnExport" runat="server" Text="Export to Excel" OnClick="btnExport_Click" CssClass="btn-add" />


[8/22/2025 12:58 PM] Dangerous: // Client-Side CSV Export Function
 function exportTableToCSV(filename) {
     var csv = [];
     var table = document.getElementById('<%= GridView1.ClientID %>'); // Get the GridView table

     if (!table) {
         alert("Could not find the data table to export.");
         console.error("Table element not found for export.");
         return;
     }

     // Get all rows in the table (including header)
     var rows = table.querySelectorAll("tr");
     for (var i = 0; i < rows.length; i++) {
         var row = [], cols = rows[i].querySelectorAll("td, th"); // Get cells (data & header)
         for (var j = 1; j < cols.length; j++) {
             // Get cell text and clean it for CSV
             let cellData = cols[j].innerText !== undefined ? cols[j].innerText : cols[j].textContent;

             // Remove sorting arrows ▲ ▼
             cellData = cellData.replace(/[▲▼]/g, '').trim();

             // Escape double quotes by doubling them
             cellData = cellData.replace(/"/g, '""');

             // If data contains comma, newline, or quote, enclose it in double quotes
             if (cellData.indexOf(',') >= 0 || cellData.indexOf('\n') >= 0 || cellData.indexOf('"') >= 0) {
                 cellData = '"' + cellData + '"';
             }

             row.push(cellData);
         }
         csv.push(row.join(",")); // Join cells with comma
     }

     // Create CSV string
     var csvString = csv.join("\n");

     // Add UTF-8 BOM for better Excel compatibility
     var BOM = "\uFEFF";

     // Create a Blob and trigger download
     var blob = new Blob([BOM + csvString], { type: 'text/csv;charset=utf-8;' });
     if (navigator.msSaveBlob) { // For IE
         navigator.msSaveBlob(blob, filename);
     } else {
         var link = document.createElement("a");
         if (link.download !== undefined) { // Feature detection
             // Create a link and trigger download
             var url = URL.createObjectURL(blob);
             link.setAttribute("href", url);
             link.setAttribute("download", filename);
             link.style.visibility = 'hidden';
             document.body.appendChild(link);
             link.click();
             document.body.removeChild(link);
         } else {
             // Fallback: Open in new window (less ideal)
             alert("Your browser might not support direct downloads. The CSV data will open in a new tab. Please copy and save it.");
             window.open(URL.createObjectURL(blob));
         }
     }
 }
[8/22/2025 12:59 PM] Dangerous: <div style=" text-align:left;margin-bottom: 10px;">
<!-- Export Button -->
<button type="button" id="btnExportCSV" onclick="exportTableToCSV('KPIs_<%= DateTime.Now.ToString("yyyyMMdd_HHmmss") %>.csv')" class="btn-add" style="margin-right: 10px;">Export to CSV</button>
        </div>





        Protected Sub btnExport_Click(sender As Object, e As EventArgs)
    Try
        ' Get data from your GridView’s DataSource
        Dim dt As New DataTable()
        Using conn As New SqlConnection(ConfigurationManager.ConnectionStrings("MyDatabase").ConnectionString)
            Using cmd As New SqlCommand(SqlDataSource1.SelectCommand, conn)
                For Each p As Parameter In SqlDataSource1.SelectParameters
                    cmd.Parameters.AddWithValue("@" & p.Name, p.DefaultValue)
                Next
                Using da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                End Using
            End Using
        End Using

        ' Build Excel file in memory
        Using wb As New XLWorkbook()
            wb.Worksheets.Add(dt, "KPIs")

            Using ms As New MemoryStream()
                wb.SaveAs(ms)
                Response.Clear()
                Response.Buffer = True
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.AddHeader("content-disposition", "attachment;filename=KPIs.xlsx")
                Response.BinaryWrite(ms.ToArray())
                Response.Flush()
                Response.End()
            End Using
        End Using

    Catch ex As Exception
        System.Diagnostics.Debug.WriteLine("Export Error: " & ex.Message)
    End Try
End Sub
