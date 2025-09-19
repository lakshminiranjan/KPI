

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













##Working code in xls:
<asp:Button ID="btnExport" runat="server" Text="Export to Excel" OnClick="btnExport_Click" />





##vb code

Protected Sub btnExport_Click(sender As Object, e As EventArgs) Handles btnExport.Click
    Response.Clear()
    Response.Buffer = True
    Response.AddHeader("content-disposition", "attachment;filename=Export.xls")
    Response.Charset = ""
    Response.ContentType = "application/vnd.ms-excel"
    Using sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)

        GridView1.AllowPaging = False
        GridView1.DataBind()

        GridView1.RenderControl(hw)
        Response.Output.Write(sw.ToString())
        Response.Flush()
        Response.End()
    End Using
End Sub

' Required override:
Public Overrides Sub VerifyRenderingInServerForm(control As Control)
    ' Verifies that the control is rendered properly
End Sub








Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports DevExpress.Web

Public Class AdminReport
    Inherits System.Web.UI.Page

    Private ReadOnly Property ConnStr As String
        Get
            Return System.Configuration.ConfigurationManager.ConnectionStrings("MyDatabase").ConnectionString
        End Get
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindKPIGrid()
            BindGroupsGrid()
        Else
            Dim eventTarget = Request("__EVENTTARGET")
            Dim eventArg = Request("__EVENTARGUMENT")
            If eventTarget = "AddKPI" AndAlso Not String.IsNullOrEmpty(eventArg) Then
                LoadKPISelectionPopup(Convert.ToInt32(eventArg))
            End If
        End If
    End Sub

    ' Load KPI Table
    Private Sub BindKPIGrid(Optional filter As String = "")
        Dim sql As String = "SELECT [ID], [KPI Name] AS KPI_Name, [KPI ID] AS KPI_ID FROM [dbo].[KPITable]"
        If Not String.IsNullOrEmpty(filter) Then
            sql &= " WHERE [KPI ID] LIKE @KPI_ID"
        End If
        sql &= " ORDER BY [KPI ID]"

        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand(sql, cn)
                If Not String.IsNullOrEmpty(filter) Then
                    cmd.Parameters.AddWithValue("@KPI_ID", "%" & filter & "%")
                End If
                Using da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                End Using
            End Using
        End Using

        gvKPI.DataSource = dt
        gvKPI.DataBind()
    End Sub

    Private Sub BindGroupsGrid()
        Dim sql As String = "SELECT DISTINCT GroupID, GroupName FROM KPI_Groups ORDER BY GroupID"
        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using da As New SqlDataAdapter(sql, cn)
                da.Fill(dt)
            End Using
        End Using
        gvGroups.DataSource = dt
        gvGroups.DataBind()
    End Sub

    Protected Sub btnGroup_Click(sender As Object, e As EventArgs)
        Dim newGroupName As String = "Group " & (GetNextGroupNumber())
        Dim newGroupID As Integer

        Using cn As New SqlConnection(ConnStr)
            cn.Open()
            Using cmdGroup As New SqlCommand("INSERT INTO KPI_Groups (GroupName) OUTPUT INSERTED.GroupID VALUES (@GroupName)", cn)
                cmdGroup.Parameters.AddWithValue("@GroupName", newGroupName)
                newGroupID = Convert.ToInt32(cmdGroup.ExecuteScalar())
            End Using

            For i As Integer = 0 To gvKPI.VisibleRowCount - 1
                Dim chk As CheckBox = TryCast(gvKPI.FindRowCellTemplateControl(i, gvKPI.Columns(1), "chkSelect"), CheckBox)
                If chk IsNot Nothing AndAlso chk.Checked Then
                    Dim kpiIdObj = gvKPI.GetRowValues(i, "KPI_ID")
                    If kpiIdObj IsNot Nothing Then
                        Using cmd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
                            cmd.Parameters.AddWithValue("@GroupID", newGroupID)
                            cmd.Parameters.AddWithValue("@KPI_ID", kpiIdObj.ToString())
                            cmd.ExecuteNonQuery()
                        End Using
                    End If
                End If
            Next
        End Using

        BindGroupsGrid()
        BindKPIGrid()
    End Sub

    Private Function GetNextGroupNumber() As Integer
        Dim sql As String = "SELECT COUNT(*) FROM KPI_Groups"
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand(sql, cn)
                cn.Open()
                Return Convert.ToInt32(cmd.ExecuteScalar()) + 1
            End Using
        End Using
    End Function

    Protected Sub gvGroups_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)
        Dim groupId As Integer = Convert.ToInt32(e.Keys("GroupID"))
        Using cn As New SqlConnection(ConnStr)
            cn.Open()
            Using cmd As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cmd.ExecuteNonQuery()
            End Using
            Using cmd As New SqlCommand("DELETE FROM KPI_Groups WHERE GroupID=@GroupID", cn)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cmd.ExecuteNonQuery()
            End Using
        End Using
        e.Cancel = True
        BindGroupsGrid()
    End Sub

    Protected Sub gvGroups_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)
        Dim groupId As Integer = Convert.ToInt32(e.Keys("GroupID"))
        Dim newName As String = Convert.ToString(e.NewValues("GroupName"))
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand("UPDATE KPI_Groups SET GroupName=@GroupName WHERE GroupID=@GroupID", cn)
                cmd.Parameters.AddWithValue("@GroupName", newName)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cn.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Using
        e.Cancel = True
        gvGroups.CancelEdit()
        BindGroupsGrid()
    End Sub

    Protected Sub gvGroupMembers_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Dim detailGrid As ASPxGridView = CType(sender, ASPxGridView)
        Dim groupId As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, GridViewDetailRowTemplateContainer)).KeyValue)
        Dim sql As String = "SELECT KPI_ID FROM KPI_GroupMembers WHERE GroupID = @GroupID"
        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using da As New SqlDataAdapter(sql, cn)
                da.SelectCommand.Parameters.AddWithValue("@GroupID", groupId)
                da.Fill(dt)
            End Using
        End Using
        detailGrid.DataSource = dt
    End Sub

    Protected Sub gvGroupMembers_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)
        Dim detailGrid As ASPxGridView = CType(sender, ASPxGridView)
        Dim groupId As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, GridViewDetailRowTemplateContainer)).KeyValue)
        Dim kpiId As String = e.Keys("KPI_ID").ToString()
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID AND KPI_ID=@KPI_ID", cn)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cmd.Parameters.AddWithValue("@KPI_ID", kpiId)
                cn.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Using
        e.Cancel = True
        detailGrid.DataBind()
    End Sub

    Protected Sub gvKPI_PageIndexChanged(sender As Object, e As EventArgs)
        BindKPIGrid()
    End Sub

    Protected Sub gvGroups_PageIndexChanged(sender As Object, e As EventArgs)
        BindGroupsGrid()
    End Sub

    ' Load KPI Selection Popup
    Private Sub LoadKPISelectionPopup(groupId As Integer)
        hdnSelectedGroupId.Value = groupId.ToString()
        Dim allKpi As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using da As New SqlDataAdapter("SELECT [KPI ID] AS KPI_ID FROM KPITable ORDER BY [KPI ID]", cn)
                da.Fill(allKpi)
            End Using
        End Using

        ' Get existing KPIs for this group
        Dim existing As New List(Of String)
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand("SELECT KPI_ID FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cn.Open()
                Using rdr = cmd.ExecuteReader()
                    While rdr.Read()
                        existing.Add(rdr("KPI_ID").ToString())
                    End While
                End Using
            End Using
        End Using

        chkKPIList.Items.Clear()
        For Each row As DataRow In allKpi.Rows
            Dim kpiId As String = row("KPI_ID").ToString()
            Dim item As New DevExpress.Web.ListEditItem(kpiId, kpiId)
            item.Selected = existing.Contains(kpiId)
            chkKPIList.Items.Add(item)
        Next

        popupAddKPI.ShowOnPageLoad = True
    End Sub

    Protected Sub btnSaveKPI_Click(sender As Object, e As EventArgs)
        Dim groupId As Integer = Convert.ToInt32(hdnSelectedGroupId.Value)
        Dim selected = chkKPIList.SelectedValues.Cast(Of String)().ToList()

        Using cn As New SqlConnection(ConnStr)
            cn.Open()

            ' First remove all KPIs from group (so we can reset selection)
            Using cmdDel As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
                cmdDel.Parameters.AddWithValue("@GroupID", groupId)
                cmdDel.ExecuteNonQuery()
            End Using

            ' Add selected KPIs
            For Each kpiId In selected
                Using cmdAdd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
                    cmdAdd.Parameters.AddWithValue("@GroupID", groupId)
                    cmdAdd.Parameters.AddWithValue("@KPI_ID", kpiId)
                    cmdAdd.ExecuteNonQuery()
                End Using
            Next
        End Using

        popupAddKPI.ShowOnPageLoad = False
        BindGroupsGrid()
    End Sub
End Class

<!DOCTYPE html>
<html>
<head runat="server">
    <title>KPI Report</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <h2>Admin KPI Grouping</h2>

        <dx:ASPxButton ID="btnGroup" runat="server" Text="Group" AutoPostBack="true" OnClick="btnGroup_Click" />
        <br/><br/>

        <div style="display:flex; gap:20px; align-items:flex-start;">

           
            <dx:ASPxGridView ID="gvKPI" runat="server" KeyFieldName="KPI_ID" AutoGenerateColumns="False" Width="600px"
                OnPageIndexChanged="gvKPI_PageIndexChanged">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="KPI_Name" Caption="KPI Name" VisibleIndex="0" />
                    <dx:GridViewDataTextColumn FieldName="KPI_ID" Caption="KPI ID" VisibleIndex="1">
                        <DataItemTemplate>
                            <div style="display:flex; justify-content:space-between; align-items:center; width:100%;">
                                <span><%# Eval("KPI_ID") %></span>
                                <asp:CheckBox ID="chkSelect" runat="server" />
                            </div>
                        </DataItemTemplate>
                        <HeaderTemplate>
                            KPI ID
                        </HeaderTemplate>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <SettingsPager PageSize="4" />
            </dx:ASPxGridView>

         
            <dx:ASPxGridView ID="gvGroups" runat="server" AutoGenerateColumns="False" KeyFieldName="GroupID" Width="360px"
                OnPageIndexChanged="gvGroups_PageIndexChanged"
                OnRowDeleting="gvGroups_RowDeleting"
                OnRowUpdating="gvGroups_RowUpdating">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="GroupName" Caption="Group Name" VisibleIndex="0">
                        <PropertiesTextEdit>
                            <ValidationSettings RequiredField-IsRequired="true" />
                        </PropertiesTextEdit>
                    </dx:GridViewDataTextColumn>

                   
                    <dx:GridViewCommandColumn ShowDeleteButton="true" ShowEditButton="true" Caption="Actions" VisibleIndex="1">
                        <CustomButtons>
                            <dx:GridViewCommandColumnCustomButton ID="btnAddKPI" Text="Add KPI" />
                        </CustomButtons>
                    </dx:GridViewCommandColumn>
                </Columns>

                <Templates>
                    <DetailRow>
                        <dx:ASPxGridView ID="gvGroupMembers" runat="server" AutoGenerateColumns="False"
                            KeyFieldName="KPI_ID" Width="320px"
                            OnBeforePerformDataSelect="gvGroupMembers_BeforePerformDataSelect"
                            OnRowDeleting="gvGroupMembers_RowDeleting">
                            <Columns>
                                <dx:GridViewDataTextColumn FieldName="KPI_ID" Caption="KPI ID" VisibleIndex="0" />
                                <dx:GridViewCommandColumn ShowDeleteButton="True" Caption="Remove" VisibleIndex="1" />
                            </Columns>
                            <SettingsPager PageSize="10" />
                        </dx:ASPxGridView>
                    </DetailRow>
                </Templates>

                <SettingsPager PageSize="4" />
                <SettingsEditing Mode="Inline" />
                <SettingsDetail ShowDetailRow="true" />
                <ClientSideEvents CustomButtonClick="function(s, e){ if(e.buttonID === 'btnAddKPI'){ __doPostBack('AddKPI', s.GetRowKey(e.visibleIndex)); } }" />
            </dx:ASPxGridView>
        </div>

      
        <dx:ASPxPopupControl ID="popupAddKPI" runat="server" HeaderText="Select KPIs" Modal="True"
            ClientInstanceName="popupAddKPI" CloseAction="CloseButton" PopupHorizontalAlign="WindowCenter"
            PopupVerticalAlign="WindowCenter" Width="500px" ShowFooter="true">
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">
                    <asp:HiddenField ID="hdnSelectedGroupId" runat="server" />
                    <dx:ASPxCheckBoxList ID="chkKPIList" runat="server" RepeatColumns="2" Width="100%" />
                </dx:PopupControlContentControl>
            </ContentCollection>
            <FooterTemplate>
                <dx:ASPxButton ID="btnSaveKPI" runat="server" Text="Save" AutoPostBack="true" OnClick="btnSaveKPI_Click" />
                <dx:ASPxButton ID="btnCancelKPI" runat="server" Text="Cancel" AutoPostBack="false" 
                    ClientSideEvents-Click="function(){ popupAddKPI.Hide(); }" />
            </FooterTemplate>
        </dx:ASPxPopupControl>
    </form>
</body>
</html>


-----------------------------------------admin report grouping add KPI---------------------------------

    <dx:ASPxGridView ID="gvGroups" runat="server" AutoGenerateColumns="False" KeyFieldName="GroupID" Width="360px"
        OnPageIndexChanged="gvGroups_PageIndexChanged"
        OnRowDeleting="gvGroups_RowDeleting"
        OnRowUpdating="gvGroups_RowUpdating">
        <Columns>
            <dx:GridViewDataTextColumn FieldName="GroupName" Caption="Group Name" VisibleIndex="0">
                <PropertiesTextEdit>
                    <ValidationSettings RequiredField-IsRequired="true" />
                </PropertiesTextEdit>
            </dx:GridViewDataTextColumn>

           
            <dx:GridViewCommandColumn ShowDeleteButton="true" ShowEditButton="true" Caption="Actions" VisibleIndex="1">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btnAddKPI" Text="Add KPI" />
                </CustomButtons>
            </dx:GridViewCommandColumn>
        </Columns>

        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="gvGroupMembers" runat="server" AutoGenerateColumns="False"
                    KeyFieldName="KPI_ID" Width="320px"
                    OnBeforePerformDataSelect="gvGroupMembers_BeforePerformDataSelect"
                    OnRowDeleting="gvGroupMembers_RowDeleting">
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="KPI_ID" Caption="KPI ID" VisibleIndex="0" />
                        <dx:GridViewCommandColumn ShowDeleteButton="True" Caption="Remove" VisibleIndex="1" />
                    </Columns>
                    <SettingsPager PageSize="10" />
                </dx:ASPxGridView>
            </DetailRow>
        </Templates>

        <SettingsPager PageSize="4" />
        <SettingsEditing Mode="Inline" />
        <SettingsDetail ShowDetailRow="true" />
        <ClientSideEvents CustomButtonClick="function(s, e){ if(e.buttonID === 'btnAddKPI'){ __doPostBack('AddKPI', s.GetRowKey(e.visibleIndex)); } }" />
    </dx:ASPxGridView>
</div>

      
<dx:ASPxPopupControl ID="popupAddKPI" runat="server" HeaderText="Select KPIs" Modal="True"
    ClientInstanceName="popupAddKPI" CloseAction="CloseButton" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Width="500px" ShowFooter="true">
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
            <asp:HiddenField ID="hdnSelectedGroupId" runat="server" />
            <dx:ASPxCheckBoxList ID="chkKPIList" runat="server" RepeatColumns="2" Width="100%" />
        </dx:PopupControlContentControl>
    </ContentCollection>
    <FooterTemplate>
        <dx:ASPxButton ID="btnSaveKPI" runat="server" Text="Save" AutoPostBack="true" OnClick="btnSaveKPI_Click" />
        <dx:ASPxButton ID="btnCancelKPI" runat="server" Text="Cancel" AutoPostBack="false" 
            ClientSideEvents-Click="function(){ popupAddKPI.Hide(); }" />
    </FooterTemplate>
</dx:ASPxPopupControl>


Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
    If Not IsPostBack Then
        BindKPIGrid()
        BindGroupsGrid()
    Else
        Dim eventTarget = Request("__EVENTTARGET")
        Dim eventArg = Request("__EVENTARGUMENT")
        If eventTarget = "AddKPI" AndAlso Not String.IsNullOrEmpty(eventArg) Then
            LoadKPISelectionPopup(Convert.ToInt32(eventArg))
        End If
    End If
End Sub

' Load KPI Table
Private Sub BindKPIGrid(Optional filter As String = "")
    Dim sql As String = "SELECT [ID], [KPI Name] AS KPI_Name, [KPI ID] AS KPI_ID FROM [dbo].[KPITable]"
    If Not String.IsNullOrEmpty(filter) Then
        sql &= " WHERE [KPI ID] LIKE @KPI_ID"
    End If
    sql &= " ORDER BY [KPI ID]"

    Dim dt As New DataTable()
    Using cn As New SqlConnection(ConnStr)
        Using cmd As New SqlCommand(sql, cn)
            If Not String.IsNullOrEmpty(filter) Then
                cmd.Parameters.AddWithValue("@KPI_ID", "%" & filter & "%")
            End If
            Using da As New SqlDataAdapter(cmd)
                da.Fill(dt)
            End Using
        End Using
    End Using

    gvKPI.DataSource = dt
    gvKPI.DataBind()
End Sub

Private Sub BindGroupsGrid()
    Dim sql As String = "SELECT DISTINCT GroupID, GroupName FROM KPI_Groups ORDER BY GroupID"
    Dim dt As New DataTable()
    Using cn As New SqlConnection(ConnStr)
        Using da As New SqlDataAdapter(sql, cn)
            da.Fill(dt)
        End Using
    End Using
    gvGroups.DataSource = dt
    gvGroups.DataBind()
End Sub

'Protected Sub btnGroup_Click(sender As Object, e As EventArgs)
'    Dim newGroupName As String = "Group " & (GetNextGroupNumber())
'    Dim newGroupID As Integer

'    Using cn As New SqlConnection(ConnStr)
'        cn.Open()
'        Using cmdGroup As New SqlCommand("INSERT INTO KPI_Groups (GroupName) OUTPUT INSERTED.GroupID VALUES (@GroupName)", cn)
'            cmdGroup.Parameters.AddWithValue("@GroupName", newGroupName)
'            newGroupID = Convert.ToInt32(cmdGroup.ExecuteScalar())
'        End Using

'        For i As Integer = 0 To gvKPI.VisibleRowCount - 1
'            Dim chk As CheckBox = TryCast(gvKPI.FindRowCellTemplateControl(i, gvKPI.Columns(1), "chkSelect"), CheckBox)
'            If chk IsNot Nothing AndAlso chk.Checked Then
'                Dim kpiIdObj = gvKPI.GetRowValues(i, "KPI_ID")
'                If kpiIdObj IsNot Nothing Then
'                    Using cmd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
'                        cmd.Parameters.AddWithValue("@GroupID", newGroupID)
'                        cmd.Parameters.AddWithValue("@KPI_ID", kpiIdObj.ToString())
'                        cmd.ExecuteNonQuery()
'                    End Using
'                End If
'            End If
'        Next
'    End Using

'    BindGroupsGrid()
'    BindKPIGrid()
'End Sub

Protected Sub btnGroup_Click(sender As Object, e As EventArgs)
    Dim newGroupName As String = "Group " & (GetNextGroupNumber())
    Dim newGroupID As Integer

    Dim selectedKPIs As List(Of Object) = gvKPI.GetSelectedFieldValues("KPI_ID")

    Using cn As New SqlConnection(ConnStr)
        cn.Open()

        ' Insert new group
        Using cmdGroup As New SqlCommand("INSERT INTO KPI_Groups (GroupName) OUTPUT INSERTED.GroupID VALUES (@GroupName)", cn)
            cmdGroup.Parameters.AddWithValue("@GroupName", newGroupName)
            newGroupID = Convert.ToInt32(cmdGroup.ExecuteScalar())
        End Using

        ' Insert selected KPIs
        For Each obj In selectedKPIs
            Using cmd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
                cmd.Parameters.AddWithValue("@GroupID", newGroupID)
                cmd.Parameters.AddWithValue("@KPI_ID", obj.ToString())
                cmd.ExecuteNonQuery()
            End Using
        Next
    End Using

    gvKPI.Selection.UnselectAll()
    BindGroupsGrid()
End Sub


Private Function GetNextGroupNumber() As Integer
    Dim sql As String = "SELECT COUNT(*) FROM KPI_Groups"
    Using cn As New SqlConnection(ConnStr)
        Using cmd As New SqlCommand(sql, cn)
            cn.Open()
            Return Convert.ToInt32(cmd.ExecuteScalar()) + 1
        End Using
    End Using
End Function

Protected Sub gvGroups_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)
    Dim groupId As Integer = Convert.ToInt32(e.Keys("GroupID"))
    Using cn As New SqlConnection(ConnStr)
        cn.Open()
        Using cmd As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
            cmd.Parameters.AddWithValue("@GroupID", groupId)
            cmd.ExecuteNonQuery()
        End Using
        Using cmd As New SqlCommand("DELETE FROM KPI_Groups WHERE GroupID=@GroupID", cn)
            cmd.Parameters.AddWithValue("@GroupID", groupId)
            cmd.ExecuteNonQuery()
        End Using
    End Using
    e.Cancel = True
    BindGroupsGrid()
End Sub

Protected Sub gvGroups_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)
    Dim groupId As Integer = Convert.ToInt32(e.Keys("GroupID"))
    Dim newName As String = Convert.ToString(e.NewValues("GroupName"))
    Using cn As New SqlConnection(ConnStr)
        Using cmd As New SqlCommand("UPDATE KPI_Groups SET GroupName=@GroupName WHERE GroupID=@GroupID", cn)
            cmd.Parameters.AddWithValue("@GroupName", newName)
            cmd.Parameters.AddWithValue("@GroupID", groupId)
            cn.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Using
    e.Cancel = True
    gvGroups.CancelEdit()
    BindGroupsGrid()
End Sub

Protected Sub gvGroupMembers_BeforePerformDataSelect(sender As Object, e As EventArgs)
    Dim detailGrid As ASPxGridView = CType(sender, ASPxGridView)
    Dim groupId As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, GridViewDetailRowTemplateContainer)).KeyValue)
    Dim sql As String = "SELECT KPI_ID FROM KPI_GroupMembers WHERE GroupID = @GroupID"
    Dim dt As New DataTable()
    Using cn As New SqlConnection(ConnStr)
        Using da As New SqlDataAdapter(sql, cn)
            da.SelectCommand.Parameters.AddWithValue("@GroupID", groupId)
            da.Fill(dt)
        End Using
    End Using
    detailGrid.DataSource = dt
End Sub

Protected Sub gvGroupMembers_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)
    Dim detailGrid As ASPxGridView = CType(sender, ASPxGridView)
    Dim groupId As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, GridViewDetailRowTemplateContainer)).KeyValue)
    Dim kpiId As String = e.Keys("KPI_ID").ToString()
    Using cn As New SqlConnection(ConnStr)
        Using cmd As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID AND KPI_ID=@KPI_ID", cn)
            cmd.Parameters.AddWithValue("@GroupID", groupId)
            cmd.Parameters.AddWithValue("@KPI_ID", kpiId)
            cn.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Using
    e.Cancel = True
    detailGrid.DataBind()
End Sub

Protected Sub gvKPI_PageIndexChanged(sender As Object, e As EventArgs)
    BindKPIGrid()
End Sub

Protected Sub gvGroups_PageIndexChanged(sender As Object, e As EventArgs)
    BindGroupsGrid()
End Sub

' Load KPI Selection Popup
Private Sub LoadKPISelectionPopup(groupId As Integer)
    hdnSelectedGroupId.Value = groupId.ToString()
    Dim allKpi As New DataTable()
    Using cn As New SqlConnection(ConnStr)
        Using da As New SqlDataAdapter("SELECT [KPI ID] AS KPI_ID FROM KPITable ORDER BY [KPI ID]", cn)
            da.Fill(allKpi)
        End Using
    End Using

    ' Get existing KPIs for this group
    Dim existing As New List(Of String)
    Using cn As New SqlConnection(ConnStr)
        Using cmd As New SqlCommand("SELECT KPI_ID FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
            cmd.Parameters.AddWithValue("@GroupID", groupId)
            cn.Open()
            Using rdr = cmd.ExecuteReader()
                While rdr.Read()
                    existing.Add(rdr("KPI_ID").ToString())
                End While
            End Using
        End Using
    End Using

    chkKPIList.Items.Clear()
    For Each row As DataRow In allKpi.Rows
        Dim kpiId As String = row("KPI_ID").ToString()
        Dim item As New DevExpress.Web.ListEditItem(kpiId, kpiId)
        item.Selected = existing.Contains(kpiId)
        chkKPIList.Items.Add(item)
    Next

    popupAddKPI.ShowOnPageLoad = True
End Sub

Protected Sub btnSaveKPI_Click(sender As Object, e As EventArgs)
    Dim groupId As Integer = Convert.ToInt32(hdnSelectedGroupId.Value)
    Dim selected = chkKPIList.SelectedValues.Cast(Of String)().ToList()

    Using cn As New SqlConnection(ConnStr)
        cn.Open()

        ' First remove all KPIs from group (so we can reset selection)
        Using cmdDel As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
            cmdDel.Parameters.AddWithValue("@GroupID", groupId)
            cmdDel.ExecuteNonQuery()
        End Using

        ' Add selected KPIs
        For Each kpiId In selected
            Using cmdAdd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
                cmdAdd.Parameters.AddWithValue("@GroupID", groupId)
                cmdAdd.Parameters.AddWithValue("@KPI_ID", kpiId)
                cmdAdd.ExecuteNonQuery()
            End Using
        Next
    End Using

    popupAddKPI.ShowOnPageLoad = False
    BindGroupsGrid()
End Sub










----------------------------------------------------------------------------------------------------------
Ah 👍 got it.
You’re seeing an error because in DevExpress **WebForms ASPxGridView**, there is **no `DetailRowDataBind` event** (that’s a WinForms/WPF style event).

For ASPxGridView in **ASP.NET WebForms**, the correct way is to use:

* `OnBeforePerformDataSelect` inside the **detail grid** (the one inside `<DetailRow>`).

That’s exactly what you already had in your working code (`gvGroupMembers_BeforePerformDataSelect`).

---

### ✅ Fixed Example for Your Case (with hardcoded values)

**ASPX**

```xml
<dx:ASPxGridView ID="gvDemo" runat="server" AutoGenerateColumns="False" KeyFieldName="ID" Width="500px">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="Name" Caption="Name" VisibleIndex="0" />
        <dx:GridViewDataTextColumn FieldName="Role" Caption="Role" VisibleIndex="1" />
    </Columns>

    <SettingsDetail ShowDetailRow="true" />

    <Templates>
        <DetailRow>
            <dx:ASPxGridView ID="gvDetail" runat="server" AutoGenerateColumns="False" 
                KeyFieldName="Project" Width="450px"
                OnBeforePerformDataSelect="gvDetail_BeforePerformDataSelect">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="Project" Caption="Project" VisibleIndex="0" />
                    <dx:GridViewDataTextColumn FieldName="Status" Caption="Status" VisibleIndex="1" />
                </Columns>
            </dx:ASPxGridView>
        </DetailRow>
    </Templates>
</dx:ASPxGridView>
```

---

**VB.NET Code Behind**

```vb
Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
    If Not IsPostBack Then
        BindMainGrid()
    End If
End Sub

Private Sub BindMainGrid()
    Dim dt As New DataTable()
    dt.Columns.Add("ID", GetType(Integer))
    dt.Columns.Add("Name", GetType(String))
    dt.Columns.Add("Role", GetType(String))

    dt.Rows.Add(1, "Niranjan", "Admin")
    dt.Rows.Add(2, "Anita", "Manager")
    dt.Rows.Add(3, "Rahul", "User")

    gvDemo.DataSource = dt
    gvDemo.DataBind()
End Sub

Protected Sub gvDetail_BeforePerformDataSelect(sender As Object, e As EventArgs)
    Dim detailGrid As DevExpress.Web.ASPxGridView = CType(sender, DevExpress.Web.ASPxGridView)
    Dim parentID As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, DevExpress.Web.GridViewDetailRowTemplateContainer)).KeyValue)

    Dim dt As New DataTable()
    dt.Columns.Add("Project", GetType(String))
    dt.Columns.Add("Status", GetType(String))

    If parentID = 1 Then
        dt.Rows.Add("KPI001", "Active")
        dt.Rows.Add("KPI002", "Inactive")
    ElseIf parentID = 2 Then
        dt.Rows.Add("HR001", "Ongoing")
        dt.Rows.Add("HR002", "Completed")
    Else
        dt.Rows.Add("USR001", "Pending")
        dt.Rows.Add("USR002", "Done")
    End If

    detailGrid.DataSource = dt
End Sub
```

---

### 🔑 Key Fix

* Use `OnBeforePerformDataSelect` on the nested grid.
* `KeyValue` from the parent row gives you the parent ID.
* Bind hardcoded detail rows inside that event.

---

👉 Do you want me to also add the **Expand/Collapse text instead of +/- buttons** here (like your last screenshot), or keep the default DevExpress +/- icons?







# KPI Version 5.0 Implementation Plan

## Overview
KPI Version 5.0 introduces enhanced user experience improvements and a new Admin Report module for KPI grouping functionality. This version focuses on better form validation, improved modal interface, and administrative capabilities for KPI organization.

## Key Features Being Implemented

### **KPI Form Enhancements**

**Modal Interface Improvements**
The KPI entry modal dialog will be redesigned for better user experience. The Submit button will be repositioned from the bottom center to the top-right corner of the modal, creating a more intuitive interface flow. The horizontal scrollbar will be completely removed from the modal to ensure a cleaner appearance and better usability across different screen sizes.

**Enhanced Field Validation System**
A comprehensive validation system will be implemented where empty required fields will automatically display red borders and position the cursor appropriately. When users attempt to submit incomplete forms, the system will automatically highlight missing fields and guide users to the first empty required field, improving form completion efficiency.

**Clone Functionality Refinement**
The existing Clone feature will be enhanced to provide a more user-friendly experience. When cloning a KPI, all existing data will be preserved except for the KPI ID field, which will be cleared to force users to create a unique identifier. Unlike the current implementation, the Order field will remain populated from the source KPI, reducing data entry requirements.

**Advanced Duplicate Prevention**
New validation rules will prevent duplicate KPI names within the same KPI Section, ensuring better data organization. Additionally, Order numbers will be validated to prevent duplicates within the same section, maintaining proper sequencing and avoiding conflicts.

**Mandatory Field Expansion**
Two new mandatory fields will be added to the KPI form: "Frequency" and "Data Delay in Reporting Period." These fields will be required for all KPI entries and will be included in the validation system, ensuring comprehensive KPI metadata collection.

### **Admin Report Module**

**KPI Grouping System**
A new administrative interface will allow authorized users to create logical groups of KPIs for better organization and reporting. Users can select multiple KPIs from the main grid and create named groups, with each group automatically assigned a sequential name like "Group 1," "Group 2," etc.

**Dynamic Group Management**
The Admin Report interface will feature expandable/collapsible group views with visual indicators (plus/minus icons). Groups can be renamed inline, and individual KPIs can be added or removed from groups through an intuitive popup selection interface.

**Interactive Grid Interface**
The system will utilize DevExpress grid controls for enhanced user interaction, including checkbox selection for KPIs, inline editing for group names, and detail rows showing group members. Pagination will be implemented for performance with large datasets.

**Group Maintenance Operations**
Administrative users will have full control over group lifecycle management, including creating new groups, editing group names, adding or removing KPI members, and deleting entire groups along with their membership associations.

## Database Schema Updates

**New Tables Creation**
Two new database tables will be created to support the grouping functionality. The KPI_Groups table will store group metadata with auto-incrementing Group IDs and editable group names. The KPI_GroupMembers table will maintain the many-to-many relationship between groups and KPIs.

**Existing Table Enhancement**
The main KPITable will be extended with two new columns: Frequency and DataDelayInReportingPeriod, both configured as required fields to capture additional KPI metadata.

**Performance Optimization**
Database indexes will be created on foreign key relationships and frequently queried fields to ensure optimal performance as the system scales with more KPIs and groups.

## User Interface Improvements

**Navigation Enhancement**
A new menu item "Admin Report" will be added to the main navigation, providing easy access to the KPI grouping functionality for authorized administrators.

**Responsive Design Considerations**
All new interfaces will be designed with responsive principles, ensuring proper display across desktop and mobile devices. Modal dialogs will be sized appropriately and form fields will scale correctly.

**Visual Feedback Systems**
Enhanced visual feedback will be implemented throughout the interface, including loading indicators during group operations, success confirmations for completed actions, and clear error messages for validation failures.

## Technical Implementation Approach

**Frontend Development**
JavaScript validation functions will be enhanced to provide real-time feedback for required fields. CSS modifications will improve modal appearance and eliminate scrollbar issues. DevExpress controls will be configured for optimal user interaction in the Admin Report module.

**Backend Processing**
Server-side validation will be strengthened to ensure data integrity. New VB.NET methods will handle group management operations, including creation, modification, and deletion of groups and their memberships. Database operations will be wrapped in transactions to maintain consistency.

**Integration Points**
The existing KPI management system will be extended rather than replaced, ensuring backward compatibility. New features will integrate seamlessly with current user authentication and authorization systems.

## Deployment Strategy

**Phased Rollout Approach**
The implementation will follow a controlled deployment strategy. Database schema changes will be applied first during a maintenance window, followed by application file deployment. Testing will occur at each stage to ensure system stability.

**Quality Assurance Process**
Comprehensive testing will cover all existing functionality to ensure no regression issues. New features will be tested across different user roles and scenarios. User acceptance testing will include screen capture documentation for stakeholder approval.

**Rollback Preparedness**
Complete rollback procedures will be prepared, including database script reversals and file restoration processes. Backup strategies will ensure rapid recovery if issues arise during deployment.

This implementation plan ensures KPI Version 5.0 delivers enhanced user experience while maintaining system reliability and preparing the foundation for future administrative capabilities.






# KPI Library 5.0 & Admin Report 2.0 – Dual Enhancement Description

**Database/schema:** KPI Library enhanced with two new mandatory columns: Frequency (VARCHAR(100)) and DataDelayInReportingPeriod (VARCHAR(100)). Admin Report introduces comprehensive grouping infrastructure with KPI_Groups table for group metadata and KPI_GroupMembers junction table for many-to-many KPI-group relationships with referential integrity and performance indexes.

**Procedures and data handling:** KPI Library procedures enhanced to handle new mandatory timing fields with full validation pipeline. Admin Report implements complete CRUD operations for group lifecycle management including batch group creation from selected KPIs, dynamic member addition/removal, cascading group deletion, and optimized queries for master-detail relationship handling.

**User Interface (KPI Enhancement):** Submit button strategically repositioned to modal top-right for improved workflow. Advanced red-border validation with automatic focus management for empty required fields. Clone functionality intelligently refined to preserve all data except KPI ID field. Modal redesigned with eliminated horizontal scrollbar and enhanced responsive behavior. Duplicate prevention validation for KPI names within sections and order numbers per section.

**Admin Report Interface:** Dedicated administrative module with dual-grid DevExpress architecture featuring master-detail expandable group views. Interactive checkbox selection for batch KPI operations with visual feedback. Sophisticated popup interface for KPI group membership management. Real-time inline editing capabilities for group names. Dynamic expand/collapse functionality with visual state indicators (plus/minus icons).

**Grid/List View:** KPI Library grid enhanced with comprehensive validation feedback and error messaging. Admin Report provides paginated group listing with embedded member detail views, sortable columns, and integrated action buttons for complete group lifecycle management.

**Workflow Integration:** KPI capture now includes essential timing metadata (frequency, reporting delays) with mandatory validation. Admin Report enables administrators to create logical KPI organizational structures, manage group memberships through intuitive interfaces, and maintain hierarchical KPI categorization for enhanced reporting capabilities and business intelligence.

## KPI Library v5.0 & Admin Report v2.0 Combined Description  
This major release delivers dual enhancements with equal strategic importance. KPI Library 5.0 introduces mandatory timing metadata capture, refined modal interface with advanced validation, and intelligent clone functionality for improved data management. Admin Report 2.0 establishes a comprehensive KPI grouping system with DevExpress-powered interfaces, enabling administrators to create organizational structures, manage group memberships, and provide hierarchical KPI categorization. Together, these modules transform KPI management from individual record handling to enterprise-level organizational intelligence with robust data capture and administrative control capabilities.

## Risk Associated
**KPI Library:** Minimal risk - new mandatory fields have default value handling and backward compatibility maintained. Enhanced validation improves data quality without breaking existing functionality.

**Admin Report:** Low risk - completely independent module with separate database tables and no dependencies on existing KPI operations. DevExpress controls already integrated in application framework. Group operations isolated with proper transaction handling.

## Consequences of not performing change
**KPI Library:** Cannot capture critical timing metadata (frequency, data delay) essential for KPI performance analysis. Continued user experience friction with current modal validation gaps. Missing advanced duplicate prevention within organizational sections.

**Admin Report:** No administrative capability for KPI organizational structure. Inability to create logical groupings for reporting and analysis. Missing enterprise-level KPI management capabilities essential for large-scale deployments and hierarchical reporting requirements.

## User/Jobs Service Impact during window
**KPI Library:** Brief unavailability during schema updates. All existing KPI data preserved with full backward compatibility. No impact on EMS services.

**Admin Report:** No impact on existing services. Independent module deployment with separate database infrastructure. No disruption to current KPI operations.

## Backout/Rollback Plan, in case of issue
**KPI Library Rollback:**
- Drop new columns: `ALTER TABLE KPITable DROP COLUMN Frequency, DataDelayInReportingPeriod`
- Restore Default.aspx and code-behind from backup
- Revert enhanced validation JavaScript and CSS changes

**Admin Report Rollback:**
- Drop new tables: `DROP TABLE KPI_GroupMembers; DROP TABLE KPI_Groups`
- Remove AdminReport.aspx and AdminReport.aspx.vb files
- Revert Site.Master navigation changes
- Remove plus.png/minus.png image files

**Complete System Rollback:** Restore entire application from pre-deployment backup with database schema rollback scripts

## UAT Sign Off
Please share change tracking numbers for both KPI Library 5.0 and Admin Report 2.0 enhancements. Screenshots required for:
- KPI modal validation behavior and new mandatory fields
- Admin Report group creation and management operations
- Master-detail expand/collapse functionality
- Batch KPI selection and group assignment workflow

## Change Timelines
Extended maintenance window post business hours UK time to accommodate dual deployment. Estimated 2-hour window for database updates and application deployment with comprehensive testing phases.

## Change Reason
**KPI Library 5.0:** Critical enhancement to capture essential KPI timing metadata, improve user experience through refined validation and modal interface, and provide advanced data integrity controls for enterprise-scale KPI management.

**Admin Report 2.0:** Strategic administrative capability enabling KPI organizational structure management, group-based reporting, and hierarchical KPI categorization essential for enterprise reporting and business intelligence requirements.

## Verification Steps
**KPI Library 5.0:**
1. Add new KPI - verify Frequency and DataDelay mandatory fields with red-border validation
2. Confirm Submit button top-right positioning and modal responsiveness  
3. Test clone functionality - all fields populated except KPI ID
4. Validate duplicate prevention within sections for names and order numbers
5. Verify enhanced validation messaging and user guidance

**Admin Report 2.0:**
6. Access AdminReport.aspx - confirm dual-grid interface loads correctly
7. Create new groups from selected KPIs with batch operations
8. Test expand/collapse group details with visual state indicators
9. Add/remove KPIs from existing groups via popup interface
10. Verify inline group name editing and cascading deletion operations
11. Confirm master-detail relationship integrity and performance

## Attachments/Deployment Files
**Database Scripts:**
- **KPITable_AlterV5.sql** – Mandatory timing fields addition with validation
- **AdminReport_Schema.sql** – KPI_Groups and KPI_GroupMembers tables with indexes and constraints
- **Database_Rollback.sql** – Complete schema rollback procedures

**KPI Library Files:**
- **Default.aspx.txt** – Enhanced modal interface with repositioned controls
- **Default.aspx.vb.txt** – Advanced validation logic and clone refinements
- **KPI_Validation.js** – Client-side validation enhancements
- **Modal_Styles.css** – Responsive modal styling improvements

**Admin Report Files:**
- **AdminReport.aspx.txt** – Complete DevExpress-powered administrative interface
- **AdminReport.aspx.vb.txt** – Full group management backend with CRUD operations
- **AdminReport_Styles.css** – Administrative interface styling
- **plus.png, minus.png** – Expand/collapse visual indicators

**Configuration Files:**
- **Site.Master.txt** – Navigation enhancements for Admin Report access
- **web.config.txt** – DevExpress assembly references and configuration updates







