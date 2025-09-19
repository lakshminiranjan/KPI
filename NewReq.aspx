<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="NewReq.aspx.vb" Inherits="KPILibrary.NewReq" %>
<%@ Register Assembly="DevExpress.Web.v25.1, Version=25.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v25.1"
    Namespace="DevExpress.Web.ASPxPivotGrid"
    TagPrefix="dxpg" %>
<%@ Register Assembly="DevExpress.XtraPivotGrid.v25.1, Version=25.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraPivotGrid" TagPrefix="xpg" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>KPI Report</title>
    <style>
        .toolbar { display:flex; gap:12px; align-items:center; margin:8px 0 16px; }
        .section { margin-bottom:24px; }
        .title { font:600 18px/1.4 system-ui,Segoe UI,Arial; margin:12px 0; }
    </style>
</head>
<body>
<form id="form1" runat="server">
   <%--<dx:ASPxGridView ID="gvDemo" runat="server" AutoGenerateColumns="False" KeyFieldName="ID" Width="500px">
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
</dx:ASPxGridView>--%>

   <dx:ASPxGridView ID="gvDemo" runat="server" AutoGenerateColumns="False" 
    KeyFieldName="ID" Width="500px">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="Name" Caption="Name" VisibleIndex="0" />
        <dx:GridViewDataTextColumn FieldName="Role" Caption="Role" VisibleIndex="1" />
    </Columns>

    <SettingsDetail ShowDetailRow="true" />

    <Templates>
        <DetailRow>
            <!-- Replace nested Grid with TreeList for branching -->
            <dx:ASPxTreeList ID="treeProjects" runat="server" AutoGenerateColumns="False"
                KeyFieldName="Project" ParentFieldName="ParentID" Width="450px"
                OnBeforePerformDataSelect="treeProjects_BeforePerformDataSelect">
                <Columns>
                    <dx:TreeListDataColumn FieldName="Project" Caption="Project" VisibleIndex="0" />
                    <dx:TreeListDataColumn FieldName="Status" Caption="Status" VisibleIndex="1" />
                </Columns>
            </dx:ASPxTreeList>
        </DetailRow>
    </Templates>
</dx:ASPxGridView>



</form>
</body>
</html>
