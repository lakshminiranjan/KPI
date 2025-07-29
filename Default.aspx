
<%@ Page Title="KPI Management" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="KPILibrary._Default" %>
<%@ Import Namespace="System.Web.Services" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .sortable-header .sort-arrows { opacity: 0; transition: opacity 0.2s; display:inline-block; }
        .sortable-header:hover .sort-arrows { opacity: 1; }
        .arrow-icon { background: none; border: none; font-size: 14px; margin-left: 3px; cursor: pointer; color: #2196F3; padding:0 2px; }
        .sort-indicator { font-weight:bold; color:darkorange; margin-left:3px; }

        .modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            width: 800px;
            height: 500px;
            overflow-y: auto;
            background-color: #fff;
            transform: translate(-50%, -50%);
            border-radius: 12px;
            padding: 20px; 
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            z-index: 1000;
        }
        .close-btn { float: right; font-size: 20px; font-weight: bold; cursor: pointer; }
        .error-span { 
            color: red; 
            font-size: 12px; 
            margin-left: 10px; 
            display:none;
            visibility:hidden;
            font-weight: bold;
        }
        .error-span.show {
            display: inline;
            visibility: visible;
        }
        .toggle-switch { position: relative; display: inline-block; width: 40px; height: 20px; }
        .toggle-switch input { opacity: 0; width: 0; height: 0; }
        .slider {
            position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc; transition: .4s; border-radius: 20px;
        }
        .toggle-switch input:checked + .slider { background-color: #2196F3; }
        .slider:before {
            position: absolute; content: ""; height: 16px; width: 16px; left: 2px; bottom: 2px;
            background-color: white; transition: .4s; border-radius: 50%;
        }
        .toggle-switch input:checked + .slider:before { transform: translateX(20px); }
        .btn-add, .btn-edit { padding: 6px 12px; border: none; border-radius: 4px; color: white; cursor: pointer; }
        .btn-add { background-color: #4CAF50; }
        .btn-edit { background-color: #2196F3; }
        table { width: 100%; border-collapse: collapse; }
        table td, table th { padding: 8px; border: 1px solid #ccc; }
        .grid-style {
            border-collapse: collapse;
            width: 100%;
        }

        .grid-style td, .grid-style th {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center; /* Center-align content for better appearance */
        }

        .grid-style th {
            background-color: #f2f2f2;
            position: sticky;
            top: 0;
            z-index: 10;
            border-bottom: 1px solid #ccc;
        }

        .modal input[type="text"], .modal textarea {
            width: 520px; max-width: none !important; box-sizing: border-box;
        }
        .grid-container {
            max-height: 650px; /* or whatever scroll height you want */
            overflow-y: auto;
            border: 1px solid #ccc;
        }

        .grid-container table {
            border-collapse: collapse;
            width: 100%;
        }
        
        .grid-container th {
            position: sticky;
            top: 0;
            background-color: #ddd;
            z-index: 10;
            border-bottom: 1px solid #ccc;
        }

    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        let lblKPIError = null;
        let inputField = null;
        let isCheckingKPI = false;

        function showPopup() {
            document.getElementById('kpiModal').style.display = 'block';




        }

        function hidePopup() {
            document.getElementById('kpiModal').style.display = 'none';


            document.getElementById("<%= lblOrderError.ClientID %>").style.display = "none";
            document.getElementById("<%= lblDuplicateMetricKPIError.ClientID %>").style.display = "none";
            document.getElementById("<%= lblKPIError.ClientID %>").style.display = "none";
        }

        function showElement(element) {
            if (element) {
                element.classList.add('show');
            }
        }

        function hideElement(element) {
            if (element) {
                element.classList.remove('show');
            }
        }

        function debounce(func, delay) {
            let timer;
            return function () {
                clearTimeout(timer);
                timer = setTimeout(() => {
                    func.apply(this, arguments);
                }, delay);
            };
        }

        function createKPIErrorLabel() {
            const inputField = document.getElementById('<%=txtKPIID.ClientID%>');
            if (!inputField) {
                console.error("Cannot create error label: Input field not found");
                return null;
            }

            const errorSpan = document.createElement('span');
            errorSpan.id = 'dynamicKPIError';
            errorSpan.className = 'error-span';
            errorSpan.innerText = "KPI ID already exists";
            inputField.parentNode.appendChild(errorSpan);
            console.log("Dynamic error label created");
            return errorSpan;
        }

        function checkKPIID() {
            if (isCheckingKPI) {
                return;
            }

            if (!inputField) {
                inputField = document.getElementById('<%=txtKPIID.ClientID%>');
            }
            if (!lblKPIError) {
                lblKPIError = document.getElementById('<%=lblKPIError.ClientID%>');
                if (!lblKPIError) {
                    lblKPIError = document.getElementById('dynamicKPIError') || createKPIErrorLabel();
                }
            }

            if (!inputField || !lblKPIError) {
                console.error("Input field or error label not found");
                return;
            }

            var kpiID = inputField.value.trim().replace(/\s{2,}/g, ' ');
            inputField.value = kpiID;

            if (kpiID === "") {
                hideElement(lblKPIError);
                return;
            }

            var isEdit = document.getElementById('<%=hfIsEdit.ClientID%>');
            var originalKPIID = document.getElementById('<%=hfKPIID.ClientID%>');
            if (isEdit && originalKPIID && isEdit.value === "true" && kpiID === originalKPIID.value) {
                hideElement(lblKPIIDError);
                return;
            }

            isCheckingKPI = true;

            $.ajax({
                type: "POST",
                url: "Default.aspx/CheckKPIExists",
                data: JSON.stringify({ kpiID: kpiID }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                timeout: 10000,
                success: function (response) {
                    console.log("AJAX Response:", response);
                    if (response.d === true) {
                        lblKPIError.innerText = "KPI ID already exists";
                        showElement(lblKPIError);
                    } else {
                        hideElement(lblKPIError);
                    }
                    isCheckingKPI = false;
                },
                error: function (xhr, status, error) {
                    console.error("AJAX error:", xhr.status, xhr.responseText, error);
                    isCheckingKPI = false;
                }
            });
        }

        function validateBeforeSubmit() {
            if (!inputField) {
                inputField = document.getElementById('<%=lblKPIError.ClientID%>');
            }
            if (!lblKPIError) {
                lblKPIError = document.getElementById('<%=txtKPIID.ClientID%>');
        if (!lblKPIError) {
            lblKPIError = document.getElementById('dynamicKPIError') || createKPIErrorLabel();
        }
    }

    if (!inputField || !lblKPIError) {
        console.error("Input field or error label not found during submission");
        return true; // Let it pass instead of blocking
    }

    var kpiID = inputField.value.trim().replace(/\s{2,}/g, ' ');
    inputField.value = kpiID;

    var isEdit = document.getElementById('<%=hfIsEdit.ClientID%>');
            var originalKPIID = document.getElementById('<%=hfKPIID.ClientID%>');
            if (isEdit && originalKPIID && isEdit.value === "true" && kpiID === originalKPIID.value) {
                hideElement(lblKPIError);
                return true;
            }

            if (lblKPIError.classList.contains('show')) {
                showElement(lblKPIError);
                return false;
            }

            let isValid = true;
            $.ajax({
                type: "POST",
                url: "Default.aspx/CheckKPIExists",
                data: JSON.stringify({ kpiID: kpiID }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (response) {
                    if (response.d === true) {
                        lblKPIError.innerText = "KPI ID already exists";
                        showElement(lblKPIError);
                        isValid = false;
                    } else {
                        hideElement(lblKPIError);
                    }
                },
                error: function (xhr, status, error) {
                    console.warn("AJAX validation failed. Bypassing check and allowing submission.");
                    hideElement(lblKPIError); // Hide error if present
                    isValid = true; // Allow insert even on error
                }
            });

            return isValid;
        }

        $(document).ready(function () {
            console.log("Document ready, initializing KPI ID validation");

            inputField = document.getElementById('<%=txtKPIID.ClientID%>');
            lblKPIError = document.getElementById('<%=lblKPIError.ClientID%>');
            if (!lblKPIError) {
                lblKPIError = document.getElementById('dynamicKPIError') || createKPIErrorLabel();
            }

            console.log("Input field found:", inputField !== null);
            console.log("Error label found:", lblKPIError !== null);

            if (inputField && lblKPIError) {
                $(inputField).off('input.kpivalidation blur.kpivalidation');
                $(inputField).on('input.kpivalidation', debounce(checkKPIID, 500));
                $(inputField).on('blur.kpivalidation', checkKPIID);
                console.log("Event listeners attached for KPI ID validation");
            } else {
                console.error("Failed to initialize: Input or error label missing");
            }

            if (lblKPIError) {
                hideElement(lblKPIError);
            }

            var submitButton = document.getElementById('<%=btnSubmit.ClientID%>');
            if (submitButton) {
                $(submitButton).off('click.kpivalidation').on('click.kpivalidation', function (e) {
                    if (!validateBeforeSubmit()) {
                        e.preventDefault();
                        showPopup();
                        return false;
                    }
                });
            }
        });

        function showKPIError(message) {
            if (!lblKPIError) {
                lblKPIError = document.getElementById('<%=lblKPIError.ClientID%>');
                if (!lblKPIError) {
                    lblKPIError = document.getElementById('dynamicKPIError') || createKPIErrorLabel();
                }
            }
            if (lblKPIError) {
                lblKPIError.innerText = message || "KPI ID already exists";
                showElement(lblKPIError);
            }
        }

        function hideKPIError() {
            if (!lblKPIError) {
                lblKPIError = document.getElementById('<%=lblKPIError.ClientID%>');
                if (!lblKPIError) {
                    lblKPIError = document.getElementById('dynamicKPIError') || createKPIErrorLabel();
                }
            }
            if (lblKPIError) {
                hideElement(lblKPIError);
            }
        }
    </script>

    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-edit" OnClick="btnLogout_Click" Style="float:right; margin:10px;" />

    <div id="kpiModal" class="modal">
        <span class="close-btn" onclick="hidePopup()">×</span>
        <h3><asp:Label ID="lblFormTitle" runat="server" Text="Add KPI" /></h3>

        <table>
            <tr><td>Metric:</td><td><asp:TextBox ID="txtMetric" runat="server" /></td></tr>
            <tr><td>Name:</td><td><asp:TextBox ID="txtKPIName" runat="server" /><asp:Label ID="lblDuplicateMetricKPIError" runat="server"   ForeColor="Red" Style="color: red;font-size: 12px; margin-top:5px;display:block;"  /></td></tr>
            <tr><td>KPI ID:</td><td><asp:TextBox ID="txtKPIID" runat="server" /><asp:Label ID="lblKPIError" runat="server" CssClass="error-span" Text="KPI ID already exists" ForeColor="Red" Visible="false" /></td></tr>
            <tr><td>Short Desc:</td><td><asp:TextBox ID="txtShortDesc" runat="server" TextMode="MultiLine" Rows="3" /></td></tr>
            <tr><td>Order:</td><td><asp:TextBox ID="txtOrder" runat="server" /><asp:Label ID="lblOrderError" runat="server"   Text="Please add numbers between 1–999" ForeColor="Red" Style="color: red;font-size: 12px; margin-top:5px;display:block;"  /></td></tr>
            <tr><td>Impact:</td><td><asp:TextBox ID="txtImpact" runat="server" TextMode="MultiLine" Rows="3" /></td></tr>
            <tr><td>Numerator:</td><td><asp:TextBox ID="txtNumerator" runat="server" TextMode="MultiLine" Rows="3" /></td></tr>
            <tr><td>Denominator:</td><td><asp:TextBox ID="txtDenom" runat="server" TextMode="MultiLine" Rows="3" /></td></tr>
            <tr><td>Unit:</td><td><asp:TextBox ID="txtUnit" runat="server" /></td></tr>
            <tr><td>Datasource:</td><td><asp:TextBox ID="txtDatasource" runat="server" /></td></tr>
            <tr><td>KPI_Section:</td><td><asp:TextBox ID="txtSection" runat="server" /></td></tr>
            <tr><td>Active:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkActive" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td>FLAG_DIVISINAL:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkFlagDivisinal" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td>FLAG_VENDOR:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkFlagVendor" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td>FLAG_ENGAGEMENTID:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkFlagEngagement" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td>FLAG_CONTRACTID:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkFlagContract" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td>FLAG_COSTCENTRE:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkFlagCostcentre" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td>FLAG_DEUBALvl4:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkFlagDeuballvl4" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td>FLAG_HRID:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkFlagHRID" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td>FLAG_REQUESTID:</td><td><label class="toggle-switch"><asp:CheckBox ID="chkFlagRequest" runat="server" /><span class="slider"></span></label></td></tr>
            <tr><td colspan="2" style="text-align:center;"><asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn-add" /></td></tr>
        </table>
        <asp:HiddenField ID="hfIsEdit" runat="server" />
        <asp:HiddenField ID="hfKPIID" runat="server" />
    </div>



    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
        ConnectionString="<%$ ConnectionStrings:MyDatabase %>"
        SelectCommand="dbo.GetAllKPITable"
        SelectCommandType="StoredProcedure"
        InsertCommand="dbo.InsertKPI"
        InsertCommandType="StoredProcedure"
        UpdateCommand="dbo.UpdateKPIByID"
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
        <asp:Parameter Name="Status" Type="String" DefaultValue="Y" />
        <asp:Parameter Name="SortColumn" Type="String" DefaultValue="KPI or Standalone Metric" />
        <asp:Parameter Name="SortDirection" Type="String" DefaultValue="ASC" />
        </SelectParameters>

        <InsertParameters>
            <asp:Parameter Name="KPI_ID" />
            <asp:Parameter Name="KPI_or_Standalone_Metric" />
            <asp:Parameter Name="KPI_Name" />
            <asp:Parameter Name="KPI_Short_Description" />
            <asp:Parameter Name="KPI_Impact" />
            <asp:Parameter Name="Numerator_Description" />
            <asp:Parameter Name="Denominator_Description" />
            <asp:Parameter Name="Unit" />
            <asp:Parameter Name="Datasource" />
            <asp:Parameter Name="OrderWithinSecton" />
            <asp:Parameter Name="KPI_Section" />
            <asp:Parameter Name="Active" />
            <asp:Parameter Name="FLAG_DIVISINAL" />
            <asp:Parameter Name="FLAG_VENDOR" />
            <asp:Parameter Name="FLAG_ENGAGEMENTID" />
            <asp:Parameter Name="FLAG_CONTRACTID" />
            <asp:Parameter Name="FLAG_COSTCENTRE" />
            <asp:Parameter Name="FLAG_DEUBALvl4" />
            <asp:Parameter Name="FLAG_HRID" />
            <asp:Parameter Name="FLAG_REQUESTID" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="OriginalKPIID" Type="String" />
            <asp:Parameter Name="KPI_ID" />
            <asp:Parameter Name="KPI_or_Standalone_Metric" />
            <asp:Parameter Name="KPI_Name" />
            <asp:Parameter Name="KPI_Short_Description" />
            <asp:Parameter Name="KPI_Impact" />
            <asp:Parameter Name="Numerator_Description" />
            <asp:Parameter Name="Denominator_Description" />
            <asp:Parameter Name="Unit" />
            <asp:Parameter Name="Datasource" />
            <asp:Parameter Name="OrderWithinSecton" />
            <asp:Parameter Name="KPI_Section" />
            <asp:Parameter Name="Active" />
            <asp:Parameter Name="FLAG_DIVISINAL" />
            <asp:Parameter Name="FLAG_VENDOR" />
            <asp:Parameter Name="FLAG_ENGAGEMENTID" />
            <asp:Parameter Name="FLAG_CONTRACTID" />
            <asp:Parameter Name="FLAG_COSTCENTRE" />
            <asp:Parameter Name="FLAG_DEUBALvl4" />
            <asp:Parameter Name="FLAG_HRID" />
            <asp:Parameter Name="FLAG_REQUESTID" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <div class="grid-container">

    <div style="margin-bottom:18px;">
    <span id="toggleLabel" runat="server" style="font-weight:bold;">Active</span>
    <label class="toggle-switch" style="vertical-align:middle;margin:0 10px;">
        <asp:CheckBox ID="chkShowActive" runat="server" AutoPostBack="true" OnCheckedChanged="chkShowActive_CheckedChanged" />
        <span class="slider"></span>
    </label>
    
</div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="grid-style" OnRowCommand="GridView1_RowCommand"
    OnRowCreated="GridView1_RowCreated" DataKeyNames="KPI ID">
    <Columns>

        <asp:TemplateField>
            <HeaderTemplate>
                <asp:Button ID="btnAddKPI" runat="server" Text="+ Add KPI" CssClass="btn-add" OnClick="btnAddKPI_Click" />
            </HeaderTemplate>
            <ItemTemplate>
    <asp:Button ID="btnEdit" runat="server" Text="Edit"
        CommandName="EditKPI"
        CommandArgument='<%# Container.DataItemIndex %>'
        CssClass="btn-edit" />
  </ItemTemplate>
        </asp:TemplateField>
    <asp:TemplateField HeaderText="Metric" SortExpression="KPI or Standalone Metric">
        <HeaderTemplate>
            <div class="sortable-header">
                Metric
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpMetric" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI or Standalone Metric|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownMetric" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI or Standalone Metric|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortMetric" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("KPI or Standalone Metric") %></ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="KPI Name" SortExpression="KPI Name">
        <HeaderTemplate>
            <div class="sortable-header">
                KPI Name
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpKPIName" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI Name|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownKPIName" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI Name|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortKPIName" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("KPI Name") %></ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="KPI ID" SortExpression="KPI ID">
        <HeaderTemplate>
            <div class="sortable-header">
                KPI ID
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpKPIID" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI ID|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownKPIID" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI ID|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortKPIID" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("KPI ID") %></ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Short Description" SortExpression="KPI Short Description">
        <HeaderTemplate>
            <div class="sortable-header">
                Short Description
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpShortDesc" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI Short Description|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownShortDesc" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI Short Description|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortShortDesc" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("KPI Short Description") %></ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Impact" SortExpression="KPI Impact">
        <HeaderTemplate>
            <div class="sortable-header">
                Impact
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpImpact" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI Impact|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownImpact" runat="server" CommandName="CustomSort"
                        CommandArgument="KPI Impact|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortImpact" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("KPI Impact") %></ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Numerator" SortExpression="Numerator Description">
        <HeaderTemplate>
            <div class="sortable-header">
                Numerator
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpNum" runat="server" CommandName="CustomSort"
                        CommandArgument="Numerator Description|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownNum" runat="server" CommandName="CustomSort"
                        CommandArgument="Numerator Description|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortNum" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("Numerator Description") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Denominator" SortExpression="Denominator Description">
        <HeaderTemplate>
            <div class="sortable-header">
                Denominator
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpDen" runat="server" CommandName="CustomSort"
                        CommandArgument="Denominator Description|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownDen" runat="server" CommandName="CustomSort"
                        CommandArgument="Denominator Description|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortDen" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("Denominator Description") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Unit" SortExpression="Unit">
        <HeaderTemplate>
            <div class="sortable-header">
                Unit
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpUnit" runat="server" CommandName="CustomSort"
                        CommandArgument="Unit|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownUnit" runat="server" CommandName="CustomSort"
                        CommandArgument="Unit|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortUnit" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("Unit") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Datasource" SortExpression="Datasource">
        <HeaderTemplate>
            <div class="sortable-header">
                Datasource
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpDS" runat="server" CommandName="CustomSort"
                        CommandArgument="Datasource|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownDS" runat="server" CommandName="CustomSort"
                        CommandArgument="Datasource|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortDS" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# Eval("Datasource") %></ItemTemplate>
    </asp:TemplateField>

    <asp:TemplateField HeaderText="Order" SortExpression="OrderWithinSecton">
    <HeaderTemplate>
        <div class="sortable-header">
            Order
            <span class="sort-arrows">
                <asp:LinkButton ID="btnSortUpOrder" runat="server" CommandName="CustomSort" CommandArgument="OrderWithinSecton|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                <asp:LinkButton ID="btnSortDownOrder" runat="server" CommandName="CustomSort" CommandArgument="OrderWithinSecton|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
            </span>
            <asp:Label ID="lblCurrentSortOrder" runat="server" CssClass="sort-indicator"></asp:Label>
        </div>
    </HeaderTemplate>
    <ItemTemplate><%# Eval("OrderWithinSecton") %></ItemTemplate>
</asp:TemplateField>


        <asp:TemplateField HeaderText="Section" SortExpression="KPI_Section">
    <HeaderTemplate>
        <div class="sortable-header">
            Section
            <span class="sort-arrows">
                <asp:LinkButton ID="btnSortUpSection" runat="server" CommandName="CustomSort"
                    CommandArgument="KPI_Section|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                <asp:LinkButton ID="btnSortDownSection" runat="server" CommandName="CustomSort"
                    CommandArgument="KPI_Section|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
            </span>
            <asp:Label ID="lblCurrentSortSection" runat="server" CssClass="sort-indicator"></asp:Label>
        </div>
    </HeaderTemplate>
    <ItemTemplate><%# Eval("KPI_Section") %></ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField HeaderText="Active" SortExpression="Active">
        <HeaderTemplate>
            <div class="sortable-header">
                Active
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpActive" runat="server" CommandName="CustomSort"
                        CommandArgument="Active|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownActive" runat="server" CommandName="CustomSort"
                        CommandArgument="Active|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortActive" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("Active").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="FLAG DIVISINAL" SortExpression="FLAG_DIVISINAL">
        <HeaderTemplate>
            <div class="sortable-header">
                FLAG DIVISINAL
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpDiv" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_DIVISINAL|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownDiv" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_DIVISINAL|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortDiv" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("FLAG_DIVISINAL").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="FLAG VENDOR" SortExpression="FLAG_VENDOR">
        <HeaderTemplate>
            <div class="sortable-header">
                FLAG VENDOR
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpVendor" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_VENDOR|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownVendor" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_VENDOR|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortVendor" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("FLAG_VENDOR").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="FLAG ENGAGEMENTID" SortExpression="FLAG_ENGAGEMENTID">
        <HeaderTemplate>
            <div class="sortable-header">
                FLAG ENGAGEMENTID
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpEng" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_ENGAGEMENTID|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownEng" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_ENGAGEMENTID|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortEng" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("FLAG_ENGAGEMENTID").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="FLAG CONTRACTID" SortExpression="FLAG_CONTRACTID">
        <HeaderTemplate>
            <div class="sortable-header">
                FLAG CONTRACTID
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpContract" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_CONTRACTID|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownContract" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_CONTRACTID|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortContract" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("FLAG_CONTRACTID").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="FLAG COSTCENTRE" SortExpression="FLAG_COSTCENTRE">
        <HeaderTemplate>
            <div class="sortable-header">
                FLAG COSTCENTRE
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpCC" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_COSTCENTRE|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownCC" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_COSTCENTRE|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortCC" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("FLAG_COSTCENTRE").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="FLAG DEUBALvl4" SortExpression="FLAG_DEUBALvl4">
        <HeaderTemplate>
            <div class="sortable-header">
                FLAG DEUBALvl4
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpLvl4" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_DEUBALvl4|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownLvl4" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_DEUBALvl4|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortLvl4" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("FLAG_DEUBALvl4").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="FLAG HRID" SortExpression="FLAG_HRID">
        <HeaderTemplate>
            <div class="sortable-header">
                FLAG HRID
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpHRID" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_HRID|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownHRID" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_HRID|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortHRID" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("FLAG_HRID").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="FLAG REQUESTID" SortExpression="FLAG_REQUESTID">
        <HeaderTemplate>
            <div class="sortable-header">
                FLAG REQUESTID
                <span class="sort-arrows">
                    <asp:LinkButton ID="btnSortUpReq" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_REQUESTID|DESC" CssClass="arrow-icon" ToolTip="Sort Descending">&#9650;</asp:LinkButton>
                    <asp:LinkButton ID="btnSortDownReq" runat="server" CommandName="CustomSort"
                        CommandArgument="FLAG_REQUESTID|ASC" CssClass="arrow-icon" ToolTip="Sort Ascending">&#9660;</asp:LinkButton>
                </span>
                <asp:Label ID="lblCurrentSortReq" runat="server" CssClass="sort-indicator"></asp:Label>
            </div>
        </HeaderTemplate>
        <ItemTemplate><%# If(Eval("FLAG_REQUESTID").ToString() = "Y", "YES", "NO") %></ItemTemplate>
    </asp:TemplateField>
</Columns>

</asp:GridView>
        </div>
</asp:Content>
