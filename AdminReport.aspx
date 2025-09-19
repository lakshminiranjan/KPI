<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AdminReport.aspx.vb" Inherits="KPILibrary.AdminReport" %>
<%@ Register Assembly="DevExpress.Web.v25.1, Version=25.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

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

            
            <%--<dx:ASPxGridView ID="gvKPI" runat="server" KeyFieldName="ID" AutoGenerateColumns="False" Width="600px"
                OnPageIndexChanged="gvKPI_PageIndexChanged">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="KPI_Name" Caption="KPI Name" VisibleIndex="0" />
                    <dx:GridViewDataTextColumn FieldName="KPI_ID" Caption="KPI ID" VisibleIndex="1">
                        <DataItemTemplate>
                            <%# Eval("KPI_ID") %>
                            <asp:CheckBox ID="chkSelect" runat="server" />
                        </DataItemTemplate>
                        <HeaderTemplate>
                            KPI ID
                        </HeaderTemplate>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <SettingsPager PageSize="10" />
            </dx:ASPxGridView>--%>
            <dx:ASPxGridView ID="gvKPI" runat="server" KeyFieldName="KPI_ID" AutoGenerateColumns="False" Width="600px"
    OnPageIndexChanged="gvKPI_PageIndexChanged">
    <Columns>
        
        <dx:GridViewCommandColumn ShowSelectCheckbox="true" VisibleIndex="0" />

        <dx:GridViewDataTextColumn FieldName="KPI_Name" Caption="KPI Name" VisibleIndex="1" />
        <dx:GridViewDataTextColumn FieldName="KPI_ID" Caption="KPI ID" VisibleIndex="2" />
    </Columns>

    <SettingsPager PageSize="15" />
    <SettingsBehavior AllowSelectByRowClick="true" />
</dx:ASPxGridView>
           

            





            
<dx:ASPxGridView ID="gvGroups" runat="server" AutoGenerateColumns="False" KeyFieldName="GroupID" Width="360px"
    OnPageIndexChanged="gvGroups_PageIndexChanged"
    OnRowDeleting="gvGroups_RowDeleting"
    OnRowUpdating="gvGroups_RowUpdating"
    OnCustomButtonCallback="gvGroups_CustomButtonCallback"
    OnHtmlCommandCellPrepared="gvGroups_HtmlCommandCellPrepared">

    <Columns>
        
        <dx:GridViewCommandColumn Caption="Expand" VisibleIndex="0" ButtonType="Image">
            <CustomButtons>
                <dx:GridViewCommandColumnCustomButton ID="btnExpand">
                    <Image Url="~/Images/plus.png" Width="16px" Height="16px" />
                </dx:GridViewCommandColumnCustomButton>
            </CustomButtons>
        </dx:GridViewCommandColumn>

        <dx:GridViewDataTextColumn FieldName="GroupName" Caption="Group Name" VisibleIndex="1">
            <PropertiesTextEdit>
                <ValidationSettings RequiredField-IsRequired="true" />
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>

        <dx:GridViewCommandColumn ShowDeleteButton="true" ShowEditButton="true" Caption="Actions" VisibleIndex="2" />
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

    <SettingsPager PageSize="10" />
    <SettingsEditing Mode="Inline" />
        <SettingsDetail ShowDetailRow="true" ShowDetailButtons="false" />

</dx:ASPxGridView>



        </div>
    </form>
</body>
</html>
