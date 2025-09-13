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
    <dx:ASPxCallbackPanel ID="cpMain" runat="server" ClientInstanceName="cpMain" OnCallback="cpMain_Callback">
        <PanelCollection>
            <dx:PanelContent>
                <div class="title">KPI Report</div>
                <div class="toolbar">
                    <dx:ASPxLabel ID="lblSection" runat="server" Text="KPI or Standalone Metric:" AssociatedControlID="ddlSection" />
                    <dx:ASPxComboBox ID="ddlSection" runat="server" Width="300px"
    IncrementalFilteringMode="Contains"
    DropDownStyle="DropDownList"
    ClientInstanceName="ddlSection"
    ValueType="System.String"
    SelectionMode="CheckColumn"
    EnableSelectAll="True">
    <Items>
        <dx:ListEditItem Text="Section 1" Value="1" />
        <dx:ListEditItem Text="Section 2" Value="2" />
        <dx:ListEditItem Text="Section 3" Value="3" />
    </Items>
</dx:ASPxComboBox>

             
                    
                    
                    <dx:ASPxButton ID="btnApply" runat="server" Text="Apply Filter" AutoPostBack="False">
                        <ClientSideEvents Click="function(){ cpMain.PerformCallback('apply'); }" />
                    </dx:ASPxButton>
                    <dx:ASPxButton ID="btnExportGridXlsx" runat="server" Text="Export Grid (XLSX)" AutoPostBack="False">
                        <ClientSideEvents Click="function(){ cpMain.PerformCallback('exportGrid'); }" />
                    </dx:ASPxButton>
                    <dx:ASPxButton ID="btnExportPivotXlsx" runat="server" Text="Export Pivot (XLSX)" AutoPostBack="False">
                        <ClientSideEvents Click="function(){ cpMain.PerformCallback('exportPivot'); }" />
                    </dx:ASPxButton>
                </div>
                <div class="section">
                    <dx:ASPxGridView ID="gvKPI" runat="server" ClientInstanceName="gvKPI"
                        KeyFieldName="ID" Width="100%" OnHtmlDataCellPrepared="gvKPI_HtmlDataCellPrepared">
                        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
                        <SettingsBehavior AllowSort="True" AllowGroup="True" />
                        <SettingsPager PageSize="15" />
                    </dx:ASPxGridView>
                    <dx:ASPxGridViewExporter ID="gridExporter" runat="server" GridViewID="gvKPI" />
                </div>
                <div class="section">
                    <dxpg:ASPxPivotGrid ID="pvKPI" runat="server" ClientInstanceName="pvKPI"
                        OnCellClick="pvKPI_CellClick">
                        <Fields>
                            <dxpg:PivotGridField ID="fieldKPISection" FieldName="KPI or Standalone Metric" Area="RowArea" Caption="KPI or Standalone Metric" />
                            <dxpg:PivotGridField ID="fieldKPIName" FieldName="KPI Name" Area="RowArea" Caption="KPI Name" />
                          <dx:PivotGridField ID="fieldActive" Area="RowArea" FieldName="Active" Caption="Active Status" />
                            <dxpg:PivotGridField ID="fieldCount" FieldName="KPI ID" Area="DataArea" Caption="Count of KPI" SummaryType="Count" />
                        </Fields>
                        <OptionsView ShowRowGrandTotals="True" ShowColumnGrandTotals="True" />
                        <OptionsCustomization AllowFilter="True" AllowSort="True" />
                    </dxpg:ASPxPivotGrid>
                    <dxpg:ASPxPivotGridExporter ID="pivotExporter" runat="server" ASPxPivotGridID="pvKPI" />
                </div>
                <dx:ASPxPopupControl ID="popupDrillDown" runat="server" ClientInstanceName="popupDrillDown"
                    Modal="True" HeaderText="Drilldown Details" Width="1000px">
                    <ContentCollection>
                        <dx:PopupControlContentControl>
                            <dx:ASPxGridView ID="gvDrill" runat="server" KeyFieldName="ID" Width="100%">
                                <SettingsPager PageSize="15" />
                            </dx:ASPxGridView>
                            <div style="margin-top:10px; text-align:right;">
                                <dx:ASPxButton ID="btnClosePopup" runat="server" Text="Close" AutoPostBack="False">
                                    <ClientSideEvents Click="function(){ popupDrillDown.Hide(); }" />
                                </dx:ASPxButton>
                            </div>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl> 
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxCallbackPanel>
</form>
</body>
</html>
